#!/bin/bash

set -eu -o pipefail

create_files() {
    ./buildsite.py
}

get_lang_name() {
    echo "$@" \
        | sed -r 's/index.([a-zA-Z]{2}(_[A-Z]{2})?).json/\1/'
}

translate_files() {
    local tool="sterminator"
    [[ -e "$tool" ]]

    for json_file in index.*.json
    do
        local lang_name=$(get_lang_name "$json_file")
        local web_file="site/$lang_name.html"
        ./"$tool" "$web_file" "$json_file" & # muh parallel
    done
}

main() {
    create_files
    translate_files
}
main
