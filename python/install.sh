set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

install () {
    install_pip && install_virtualenvwrapper
}

install_virtualenvwrapper () {
    if [ -e "/usr/local/bin/virtualenv" ] || [ -e "${HOME}/.local/bin/virtualenv" ]
    then
        return
    fi

    "${PIP_COMMAND}" install --user virtualenvwrapper
}

install
