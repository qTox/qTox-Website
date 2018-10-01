#!/usr/bin/env python

import json
import os
import pystache
import re
import shutil

AUTHORITATIVE = "en"

def do_format_template(name: str, template: bytes):
    basename = ".".join(name.split(".")[:-1])
    if not basename:
        return
    print("Enumerating languages... ", end="")
    language_files = [lf for lf in os.listdir(os.getcwd())
                      if lf.endswith(".json") and lf.startswith(basename + ".")]
    print("{0} found.".format(len(language_files)))

    af_fname = "{0}.{1}.json".format(basename, AUTHORITATIVE)
    print("Using {} as a base.".format(af_fname))

    with open(af_fname, "r") as af:
        main_values = json.load(af)

    renderer = pystache.renderer.Renderer()
    lang_values = {}
    lang_list = []
    for language in language_files:
        language = language.split(".")[-2]
        lf_fname = "{0}.{1}.json".format(basename, language)

        if not re.match(r"^[A-Za-z0-9_.]+$", language):
            continue
        with open(lf_fname, "r") as lf:
            try:
                values = json.load(lf)
            except ValueError:
                print("Error in {}!".format(lf_fname))
                raise
        for key in values:
            if isinstance(values[key], str):
                values[key] = values[key].replace("\n", "<br>")
        lang_list.append({"lang_name": values["Language"],
                          "lang_shortcode": language})

        temp = main_values.copy()
        temp.update(values)
        lang_values[language] = temp
    lang_list.sort(key=lambda x: x["lang_shortcode"])
    lang_list[-1]["last"] = 1
    for language in language_files:
        language = language.split(".")[-2]
        with open("site/{1}.html".format(basename, language), "w") as outfile:
            outfile.write(renderer.render(template, lang_values[language],
                          languages=lang_list))

def main():
    if not os.path.isdir(os.path.join(os.getcwd(), "site")):
        os.mkdir("site")
    if os.path.isdir(os.path.join("site", "assets")):
        shutil.rmtree(os.path.join("site", "assets"))
    shutil.copytree("assets", os.path.join("site", "assets"))
    templates = [tp_name for tp_name in os.listdir()
                 if tp_name.endswith(".mustache")]
    for template_name in templates:
        with open(template_name) as tmp_file:
            print("Building template {0}.".format(template_name))
            do_format_template(template_name, tmp_file.read())

if __name__ == "__main__":
    main()
