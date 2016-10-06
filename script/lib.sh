# It is not possible to determine the location of this file because this will
# be run with `sh` and that does not provide any way to reliably determine
# that. See http://unix.stackexchange.com/a/96238
#
# Thus this uses the convention that the sourcing script is in a subdirectory
# of the dotfiles directory and that ${0} contains the relative path to that
# script. The DOTFILES_FOLDER path will be wrong if this is not true.

STATUS_OK=0
STATUS_SKIPPED=1
STATUS_ERROR=2

LOCAL_BIN_FOLDER="${HOME}/.local/bin"
DOTFILES_FOLDER="`dirname \`dirname \\\`readlink -f $0\\\`\``"
LOGS_FOLDER="${DOTFILES_FOLDER}/logs"

STDOUT_LOGFILE="${LOGS_FOLDER}/install.log"
STDERR_LOGFILE="${LOGS_FOLDER}/error.log"
SKIP_LOGFILE="${LOGS_FOLDER}/skip.log"

info () {
  printf "  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m?\033[0m ] $1 "
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

skip () {
  printf "\r\033[2K  [\033[0;34mSKIP\033[0m] $1\n"
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
        wget --quiet --output-document "${filename}" "${url}"
    elif which curl >/dev/null
    then
        curl --silent --location "${url}" > "${filename}"
    else
        printf "Unable to download ${filename} from ${url}... wget and curl commands not found\n" >&2
        return 1
    fi
}

