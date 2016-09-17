set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

readonly LEIN_URL="https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein"
readonly LEIN_COMMAND="${LOCAL_BIN_FOLDER}/lein"

install () {
    if [ -e "${LEIN_COMMAND}" ]
    then
        return ${STATUS_OK}
    fi

    make_local_bin || return ${STATUS_ERROR}
    install_lein   || return ${STATUS_ERROR}

    return ${STATUS_OK}
}

install_lein () {
    get_url_to_file "${LEIN_URL}" "${LEIN_COMMAND}" && chmod 755 "${LEIN_COMMAND}"
}

install
