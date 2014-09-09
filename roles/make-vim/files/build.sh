#!/bin/sh

BIN_DIR=~/bin
VIM_SOURCE_DIR=${BIN_DIR}/source/vim
VIM_TARGET_DIR=${BIN_DIR}/target/vim

# Remove previous build
prepare () {
    rm -rf ${VIM_TARGET_DIR}
    mkdir -p ${VIM_TARGET_DIR}
}

do_configure () {
    # prefix is the location to put the result of building vim.
    # exec_prefix is the location to put the executable links.
    ./configure                    \
        --prefix=${VIM_TARGET_DIR} \
        --exec-prefix=${BIN_DIR}   \
        --enable-perlinterp        \
        --enable-pythoninterp      \
        --enable-multibyte         \
        --enable-fontset
}

build () {
    do_configure  &&
        make      &&
        make test &&
        make install
}

cd ${VIM_SOURCE_DIR}

prepare && build

# vim: set ai et sw=4 syntax=sh :
