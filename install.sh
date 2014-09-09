#!/bin/sh

DOTFILES_DIR=/tmp/dotfiles

install_dependencies () {
    if ! which git
    then
        sudo apt-get install git
    fi
    if [ ! -e ~/bin/ansible ]
    then
        install_ansible
    fi
    if [ ! -e ${DOTFILES_DIR} ]
    then
        install_dotfiles
    fi
}

install_ansible () {
    mkdir -p ~/bin/source/ansible
    git clone https://github.com/ansible/ansible.git ~/bin/source/ansible
    (
        cd ~/bin
        for c in source/ansible/bin/*
        do
            ln -s $c
        done
    )
}

install_dotfiles () {
    mkdir -p ${DOTFILES_DIR}
    git clone https://github.com/matthewfranglen/dotfiles ${DOTFILES_DIR}
    (
        cd ${DOTFILES_DIR}
        git submodule update --init --recursive
    )
}

run_ansible () {
    (
        cd ${DOTFILES_DIR}
        ~/bin/ansible-playbook playbook.yml
    )
}

install_dependencies && run_ansible

echo "Remove ${DOTFILES_DIR} when you are finished"

# vim: set ai et sw=4 syntax=sh :
