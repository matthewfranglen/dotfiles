set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

HUB_URL="https://github.com/github/hub/releases/download/v2.2.9/hub-linux-amd64-2.2.9.tgz"
HUB_DOWNLOAD="/tmp/hub.tgz"
HUB_COMMAND="${LOCAL_BIN_FOLDER}/hub"

install () {
    if [ -e "${HUB_COMMAND}" ]
    then
        return ${STATUS_OK}
    fi

    make_local_bin || return ${STATUS_ERROR}
    install_hub    || return ${STATUS_ERROR}

    return ${STATUS_OK}
}

install_hub () {
    get_url_to_file "${HUB_URL}" "${HUB_DOWNLOAD}" && chmod 755 "${HUB_COMMAND}"
    local folder="$(mktemp -d)"

    (
        cd "${folder}"
        tar xzf "${HUB_DOWNLOAD}"
        mv */bin/hub "${HUB_COMMAND}"
    )

    rm -rf "${folder}"
}

install
