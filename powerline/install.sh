set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

install () {
    if is_on_local_machine
    then
        install_pip && install_powerline
    else
        echo "Not installing powerline... currently running on remote host"
        true
    fi
}

install_powerline () {
    if [ -e "${HOME}/.local/bin/powerline" ]
    then
        return
    fi

    "${PIP_COMMAND}" install --user powerline-status
}

install
