. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

install () {
    install_pip && install_virtualenvwrapper
}

install_virtualenvwrapper () {
    "${HOME}/.local/bin/pip" install --user virtualenvwrapper
}

install
