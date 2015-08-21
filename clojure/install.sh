
install () {
    install_lein
}

install_lein () {
    local lein_folder="${HOME}/.local/bin"
    local lein_command="${lein_folder}/lein"

    if [ ! -e "${lein_folder}" ]
    then
        mkdir -p "${lein_folder}"
    fi
    if [ ! -e "${lein_command}" ]
    then
        get_url_to_file "https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein" "${lein_command}" || return 1
        chmod 755 "${lein_command}"
    fi
}

get_url_to_file () {
    local url=$1
    local filename=$2

    if which wget >/dev/null
    then
        wget --output-document "${filename}" "${url}"
    elif which curl >/dev/null
    then
        curl --location "${url}" > "${filename}"
    else
        echo "Unable to install clojure... wget and curl commands not found"
        return 1
    fi
}

install
