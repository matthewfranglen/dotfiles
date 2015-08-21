
LOCAL_BIN_FOLDER="${HOME}/.local/bin"

make_local_bin () {
    if [ ! -e "${LOCAL_BIN_FOLDER}" ]
    then
        mkdir -p "${LOCAL_BIN_FOLDER}"
    fi
}

install_pip () {
    local get_pip_file="/tmp/get-pip.py"

    if [ ! -e "${HOME}/.local/bin/pip" ]
    then
        get_url_to_file "https://bootstrap.pypa.io/get-pip.py" "${get_pip_file}" || return 1
        python "${get_pip_file}" --user
        rm "${get_pip_file}"
    fi
}

get_url_to_file () {
    local url="$1"
    local filename="$2"

    if which wget >/dev/null
    then
        wget --output-document "${filename}" "${url}"
    elif which curl >/dev/null
    then
        curl --location "${url}" > "${filename}"
    else
        echo "Unable to install docker-compose... wget and curl commands not found"
        return 1
    fi
}

