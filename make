#!/bin/bash

BUILD_FOLDER=$(dirname $0)/build

function prepare () {
    ${BUILD_FOLDER}/install-dependencies
}

function do_build () {
    for builder in ${BUILD_FOLDER}/*/build
        ${builder}
}

prepare && do_build

# vim: set ai et sw=4 syntax=zsh :
