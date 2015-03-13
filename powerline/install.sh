function get_url_to_file () {
    local url=$1
    local filename=$2

    if which wget >/dev/null
    then
        wget --output-document "${filename}" "${url}"
    elif which curl >/dev/null
    then
        curl --output "${filename}" "${url}"
    else
        echo "Unable to install powerline... wget and curl commands not found"
        exit 0
    fi
}

GET_PIP_FILE=/tmp/get-pip.py

if [ ! -e ~/.local/bin/pip ]
then
    get_url_to_file "https://bootstrap.pypa.io/get-pip.py" "${GET_PIP_FILE}"
    python "${GET_PIP_FILE}" --user
    rm "${GET_PIP_FILE}"
fi

~/.local/bin/pip install --user powerline-status
