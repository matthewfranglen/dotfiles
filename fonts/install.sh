. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

validate () {
    if [ "$SSH_CONNECTION" != "" ]
    then
        echo -- "Not installing fonts... currently running on remote host" >&2
        return 1
    elif ! which fc-cache >/dev/null
    then
        echo "Unable to install fonts... fc-cache command not found"
        return 1
    fi
    return 0
}

install_fonts () {
    fc-cache -f "${DOTFILES_FOLDER}/.fonts"
}

validate && install_fonts
