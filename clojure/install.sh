set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

install () {
    make_local_bin && install_lein
}

install_lein () {
    local lein_command="${LOCAL_BIN_FOLDER}/lein"

    if [ -e "${lein_command}" ]
    then
        return
    fi

    get_url_to_file "https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein" "${lein_command}" || return 1
    chmod 755 "${lein_command}"
}

install
