# It is not possible to determine the location of this file because this will
# be run with `sh` and that does not provide any way to reliably determine
# that. See http://unix.stackexchange.com/a/96238
#
# Thus this uses the convention that the sourcing script is in a subdirectory
# of the dotfiles directory and that ${0} contains the relative path to that
# script. The ROOT_FOLDER path will be wrong if this is not true.

LOCAL_BIN_FOLDER="${HOME}/.local/bin"
DOTFILES_FOLDER="`dirname \`dirname \\\`readlink -f $0\\\`\``"

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
        local status=$?
        rm "${get_pip_file}"

        return $status
    else
        true
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
        echo "Unable to download ${file} from ${url}... wget and curl commands not found"
        return 1
    fi
}

