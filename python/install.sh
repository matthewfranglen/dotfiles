set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

install () {
    install_pip && install_virtualenvwrapper
}

install_virtualenvwrapper () {
    "${PIP_COMMAND}" install --user virtualenvwrapper
}

install
