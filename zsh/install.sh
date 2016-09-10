set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

install () {
    install_antigen
    install_fasd
    install_fzf
    install_noti
}

install_antigen () {
    local antigen_script_file="${HOME}/.antigen.zsh"

    if [ -e "${antigen_script_file}" ]
    then
        return
    fi

    get_url_to_file "https://raw.githubusercontent.com/zsh-users/antigen/master/antigen.zsh" "${antigen_script_file}" || return 1
}

install_fzf () {
    if [ -e ~/.fzf ]
    then
        return
    fi

    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
}

install_fasd () {
    local fasd_script_file="${HOME}/.fasd.zsh"
    local fasd_link_file="${HOME}/.local/bin/fasd"

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
    local bin_folder="${HOME}/.local/bin"
    local noti_binary="${bin_folder}/noti"
    local noti_download="/tmp/noti.tar.gz"

    if [ -e "${noti_binary}" ]
    then
        return
    fi

    get_url_to_file "https://github.com/variadico/noti/releases/download/v2.3.0/noti2.3.0.linux-amd64.tar.gz" "${noti_download}" || return 1
    (
        cd "${bin_folder}"
        tar -xzf "${noti_download}"
        rm "${noti_download}"
    )
}

install
