#!/bin/sh

DOTFILES_DIR=/tmp/dotfiles

install_dependencies () {
    sudo apt-get update
    sudo apt-get install --assume-yes python-dev

    if ! which git >/dev/null
    then
        install_git
    fi
    if ! which pip >/dev/null
    then
        install_pip
    fi
    if ! which ansible >/dev/null
    then
        install_ansible
    fi
    if [ ! -e ${DOTFILES_DIR} ]
    then
        install_dotfiles
    fi
}

install_git () {
    # Choosing not to support lucid (10.04) so no need to chase git-core
    sudo apt-get install --assume-yes git git-doc
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
        git checkout feature/ansible-installer
        git submodule update --init --recursive
    )
}

run_ansible () {
    (
        cd ${DOTFILES_DIR}
        ansible-playbook playbook.yml
    )
}

cleanup () {
    echo "Remove ${DOTFILES_DIR} when you are finished"
}

install_dependencies && run_ansible
STATUS=$?

cleanup
exit $STATUS

# vim: set ai et sw=4 syntax=sh :
