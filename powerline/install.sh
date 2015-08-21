. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

install () {
    if is_running_locally
    then
        install_pip && install_powerline
    else
        echo "Not installing powerline... currently running on remote host"
        true
    fi
}

is_running_locally () {
    [ "${SSH_CONNECTION}" = "" ]
}

install_powerline () {
    "${HOME}/.local/bin/pip" install --user powerline-status
}

install
