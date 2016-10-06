set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

install () {
    if ! is_on_local_machine
    then
        echo "Not installing powerline... currently running on remote host" >&3
        return ${STATUS_SKIPPED}
    fi
    if ! is_python_command_available
    then
        echo "Unable to install powerline... python not found" >&2
        return ${STATUS_ERROR}
    fi

    if [ -e "${LOCAL_BIN_FOLDER}/powerline" ]
    then
        return ${STATUS_OK}
    fi

    install_pip       || return ${STATUS_ERROR}
    install_powerline || return ${STATUS_ERROR}

    return ${STATUS_OK}
}

install_powerline () {
    "${PIP_COMMAND}" install --user powerline-status
}

install
