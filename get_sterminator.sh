#!/bin/bash

# get sterminator build for Linux x86_64

readonly URL="https://github.com/zetok/sterminator/releases/download/v0.0.1/sterminator-v0.0.1-Linux-x86_64.tar.xz"

get_binary() {
    wget "$URL"
}

unpack() {
    local name="sterminator*.tar.xz"
    tar xvf $name
}

main() {
    get_binary
    unpack
}
main
