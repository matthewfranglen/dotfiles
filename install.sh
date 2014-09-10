#!/bin/sh

DOTFILES_DIR=/tmp/dotfiles

install_dependencies () {
    if ! which git
    then
        sudo apt-get install git
    fi
    if ! which pip
    then
        install_pip
    fi
    if ! which ansible
    then
        install_ansible
    fi
    if [ ! -e ${DOTFILES_DIR} ]
    then
        install_dotfiles
    fi
}

install_pip () {
    curl https://bootstrap.pypa.io/get-pip.py | sudo python
}

install_ansible () {
    sudo pip install ansible
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
