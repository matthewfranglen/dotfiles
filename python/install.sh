set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

install () {
    if [ -e "/usr/local/bin/virtualenv" ] || [ -e "${HOME}/.local/bin/virtualenv" ]
    then
        return ${STATUS_OK}
    fi
    if ! is_python_command_available
    then
        echo "Unable to install virtualenv... python not found" >&2
        return ${STATUS_ERROR}
    fi

    install_pip               || return ${STATUS_ERROR}
    install_virtualenvwrapper || return ${STATUS_ERROR}

    return ${STATUS_OK}
}

install_virtualenvwrapper () {
    "${PIP_COMMAND}" install --user virtualenvwrapper
}

install
