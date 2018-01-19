set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

install () {
    if [ -e "${HOME}/.pyenv" ] || [ -n "${PYENV_ROOT+x}" ]
    then
        return ${STATUS_OK}
    fi
    if ! is_python_command_available
    then
        echo "Unable to install pyenv... python not found" >&2
        return ${STATUS_ERROR}
    fi

    install_pip    || return ${STATUS_ERROR}
    install_pyenv  || return ${STATUS_ERROR}
    install_pipenv || return ${STATUS_ERROR}

    return ${STATUS_OK}
}

install_pyenv () {
    git clone --quiet https://github.com/pyenv/pyenv.git ~/.pyenv
    git clone --quiet https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
}

install_pipenv () {
    pip install --user pipenv
}

install
