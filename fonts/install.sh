set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

install () {
    if ! is_on_local_machine
    then
        echo "Not installing fonts... currently running on remote host" >&3
        return ${STATUS_SKIPPED}
    fi

    if ! is_font_cache_command_available
    then
        echo "Unable to install fonts... fc-cache command not found" >&2
        return ${STATUS_ERROR}
    fi

    install_fonts || return ${STATUS_ERROR}

    return ${STATUS_OK}
}

is_font_cache_command_available () {
    which fc-cache >/dev/null
}

install_fonts () {
    fc-cache -f "${DOTFILES_FOLDER}/.fonts"
}

install
