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

readonly FONT_URL="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete%20Mono.ttf"
readonly FONTS_FOLDER="${HOME}/.local/share/fonts"
readonly FONT_FILE="${FONTS_FOLDER}/Source Code Pro Nerd Font Complete Mono.ttf"

install_fonts () {
    [ ! -e "${FONTS_FOLDER}" ] && mkdir "${FONTS_FOLDER}"
    get_url_to_file "${FONT_URL}" "${FONT_FILE}"
    fc-cache -f "${FONTS_FOLDER}"
}

install
