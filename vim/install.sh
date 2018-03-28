set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

install () {
    if ! is_python_command_available
    then
        echo "Unable to install vim environment... python not found" >&2
        return ${STATUS_ERROR}
    fi

    install_pip  || return ${STATUS_ERROR}
    install_yapf || return ${STATUS_ERROR}

    return ${STATUS_OK}
}

install_yapf () {
    PIP_REQUIRE_VIRTUALENV= pip install --user yapf
}

install
