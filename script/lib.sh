# It is not possible to determine the location of this file because this will
# be run with `sh` and that does not provide any way to reliably determine
# that. See http://unix.stackexchange.com/a/96238
#
# Thus this uses the convention that the sourcing script is in a subdirectory
# of the dotfiles directory and that ${0} contains the relative path to that
# script. The DOTFILES_FOLDER path will be wrong if this is not true.

LOCAL_BIN_FOLDER="${HOME}/.local/bin"
DOTFILES_FOLDER="`dirname \`dirname \\\`readlink -f $0\\\`\``"
STDOUT_LOGFILE="${DOTFILES_FOLDER}/logs/install.log"
STDERR_LOGFILE="${DOTFILES_FOLDER}/logs/error.log"

info () {
  printf "  [ \033[00;34m..\033[0m ] $1"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
}

is_on_local_machine () {
    [ -z ${SSH_CONNECTION+x} ]
}

make_local_bin () {
    if [ ! -e "${LOCAL_BIN_FOLDER}" ]
    then
        mkdir -p "${LOCAL_BIN_FOLDER}"
    fi
}

install_pip () {
    local get_pip_file="/tmp/get-pip.py"

    PIP_COMMAND="`which pip`"
    if [ $? -eq 0 ]
    then
        return
    fi

    get_url_to_file "https://bootstrap.pypa.io/get-pip.py" "${get_pip_file}" || return 1

    python "${get_pip_file}" --user
    local status=$?
    rm "${get_pip_file}"

    if [ ${status} -eq 0 ]
    then
        if which pip >/dev/null
        then
            PIP_COMMAND="`which pip`"
        else
            PIP_COMMAND="${LOCAL_BIN_FOLDER}/pip"
        fi
    else
        PIP_COMMAND="/bin/false"
    fi

    return $status
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

