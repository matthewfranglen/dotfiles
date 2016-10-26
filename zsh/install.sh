set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

install () {
    if ! is_git_command_available
    then
        echo "Unable to install zsh... git command not found" >&2
        return ${STATUS_ERROR}
    fi

    install_antigen || return ${STATUS_ERROR}
    install_fasd    || return ${STATUS_ERROR}
    install_fzf     || return ${STATUS_ERROR}
    install_noti    || return ${STATUS_ERROR}
}

is_git_command_available () {
    which git >/dev/null
}

install_antigen () {
    local antigen_script_file="${HOME}/.antigen.zsh"

    if [ -e "${antigen_script_file}" ]
    then
        return
    fi

    get_url_to_file "https://cdn.rawgit.com/zsh-users/antigen/v1.2.1/bin/antigen.zsh" "${antigen_script_file}" || return 1
}

install_fzf () {
    if [ -e ~/.fzf ]
    then
        return
    fi

    git clone --quiet --depth 1 "https://github.com/junegunn/fzf.git" "${HOME}/.fzf"
    "${HOME}/.fzf/install" --no-completion --key-bindings --update-rc
}

install_fasd () {
    local fasd_script_file="${HOME}/.fasd.zsh"
    local fasd_link_file="${LOCAL_BIN_FOLDER}/fasd"

    make_local_bin

    if [ ! -e "${fasd_script_file}" ]
    then
        get_url_to_file "https://raw.githubusercontent.com/clvv/fasd/master/fasd" "${fasd_script_file}" || return 1
        chmod 755 "${fasd_script_file}"
    fi

    if [ ! -e "${fasd_link_file}" ]
    then
        ln -s "${fasd_script_file}" "${HOME}/.local/bin/fasd"
    fi
}

install_noti () {
    local noti_binary="${LOCAL_BIN_FOLDER}/noti"
    local noti_download="/tmp/noti.tar.gz"

    if [ -e "${noti_binary}" ]
    then
        return
    fi

    get_url_to_file "https://github.com/variadico/noti/releases/download/v2.3.0/noti2.3.0.linux-amd64.tar.gz" "${noti_download}" || return 1
    (
        cd "${LOCAL_BIN_FOLDER}"
        tar -xzf "${noti_download}"
        rm "${noti_download}"
    )
}

install
