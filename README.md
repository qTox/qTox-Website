**Current build status:**
[![Build Status](https://travis-ci.org/qTox/qTox-Website.svg?branch=master)](https://travis-ci.org/qTox/qTox-Website)
qtox.github.io
==================

Source code for the qTox website

Translations
============

As well as new translations, improvement of translations we already have is
welcome too.

## Using weblate

The easy way of translating is to use [**Weblate**].

## Manually

Just copy ``index.en.json`` to ``index.??.json``, where ``??`` is your
language's [Zend locale name]. If the language you are translating to has more
than one dialect (for example: Brazilian Portuguese vs Portuguese Portuguese),
you can add ``_??`` before ``.json``, where ``??`` is a unique code for your
dialect. A full example: ``index.pt_BR.json`` Capitalization **does** matter!

#### Please **use LF (Unix) line endings in your json files**. Even on Windows, a decent editor like Notepad++ will let you do this!

Language file metadata
----------------------

The JSON files used by buildsite.py have some special names which are used by
the script to build the bar of languages in the footer. The names are:

- ``_language``: The (native) name of your language. Example: *Français*
- ``_comment``: A comment about the language file (optional).
- ``_author``: The creator(s) of the file.
- ``_direction``: ``rtl`` or ``ltr`` only (specifies the text direction of the
  language. If you leave this key out, it will be left-to-right).


Building the site
=================

Building the site requires Python 2 or Python 3 and the pystache library.

Also requires [`sterminator`]. To get it, run `bash get_sterminator.sh`.

To build website, run in the main directory ``bash buildsite.sh``.


To make the folder layout do the following:
Move in to the site folder ``cd site``
Make a list of all the languages ``ls | tr ' ' '\n' | grep html | tr '.' '\n' | grep -v 'html' > list``.
Make a folder for every language ``cat list | xargs mkdir``.
Move a language in to a folder ``cat list | xargs -I % mv %.html %/index.html``.
Make an index page ``ln -s en/index.html``.
<br/>
Change EN to a default language ``cat list | xargs -I % ln -s assets %``.
<br/>
Remove the list file ``rm list``


[`sterminator`]: https://github.com/zetok/sterminator
[**Weblate**]: https://hosted.weblate.org/projects/tox/website/
[Zend locale name]: https://framework.zend.com/manual/1.12/en/zend.locale.appendix.html
