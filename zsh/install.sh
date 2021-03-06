set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

install () {
    if ! is_git_command_available
    then
        echo "Unable to install zsh... git command not found" >&2
        return ${STATUS_ERROR}
    fi

    install_antigen   || return ${STATUS_ERROR}
    install_fasd      || return ${STATUS_ERROR}
    install_fd        || return ${STATUS_ERROR}
    install_fzf       || return ${STATUS_ERROR}
    install_noti      || return ${STATUS_ERROR}
    install_oh_my_zsh || return ${STATUS_ERROR}
    install_ripgrep   || return ${STATUS_ERROR}
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

    get_url_to_file "https://git.io/antigen" "${antigen_script_file}" || return 1
}

install_fasd () {
    local fasd_script_file="${HOME}/.fasd.zsh"
    local fasd_link_file="${LOCAL_BIN_FOLDER}/fasd"

    make_local_bin

    if [ ! -e "${fasd_script_file}" ]
    then
        get_url_to_file "https://raw.githubusercontent.com/whjvenyl/fasd/master/fasd" "${fasd_script_file}" || return 1
        chmod 755 "${fasd_script_file}"
    fi

    if [ ! -e "${fasd_link_file}" ]
    then
        ln -s "${fasd_script_file}" "${HOME}/.local/bin/fasd"
    fi
}

install_fd () {
    local fd_download="/tmp/fd.tar.gz"
    local fd_binary="${LOCAL_BIN_FOLDER}/fd"
    if [ -e "${fd_binary}" ]
    then
        return
    fi

    local fd_folder="$(mktemp -d)"
    if [ ! -d "${fd_folder}" ]
    then
        return "${STATUS_ERROR}"
    fi

    get_url_to_file "https://github.com/sharkdp/fd/releases/download/v7.0.0/fd-v7.0.0-x86_64-unknown-linux-gnu.tar.gz" "${fd_download}" || return 1
    (
        cd "${fd_folder}"
        tar -xzf "${fd_download}"
        mv */fd "${fd_binary}"
        rm "${fd_download}"
    )
    rm -rf "${fd_folder}"
}

install_fzf () {
    if [ -e ~/.fzf ]
    then
        return
    fi

    git clone --quiet --depth 1 "https://github.com/junegunn/fzf.git" "${HOME}/.fzf"
    "${HOME}/.fzf/install" --no-completion --key-bindings --no-update-rc
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

install_oh_my_zsh () {
    export ZSH=$HOME/.oh-my-zsh

    if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
        mv ~/.zshrc ~/.zshrc.pre-oh-my-zsh
    fi

    get_url_to_file "https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh" - | zsh 2>&1
    if [ -e ~/.zshrc ]; then
        rm ~/.zshrc
    fi

    if [ -f ~/.zshrc.pre-oh-my-zsh ] || [ -h ~/.zshrc.pre-oh-my-zsh ]; then
        mv ~/.zshrc.pre-oh-my-zsh ~/.zshrc
    fi
}

install_ripgrep () {
    local ripgrep_download="/tmp/ripgrep.tar.gz"
    local ripgrep_binary="${LOCAL_BIN_FOLDER}/rg"
    if [ -e "${ripgrep_binary}" ]
    then
        return
    fi

    local ripgrep_folder="$(mktemp -d)"
    if [ ! -d "${ripgrep_folder}" ]
    then
        return "${STATUS_ERROR}"
    fi

    get_url_to_file "https://github.com/BurntSushi/ripgrep/releases/download/0.8.1/ripgrep-0.8.1-x86_64-unknown-linux-musl.tar.gz" "${ripgrep_download}" || return 1
    (
        cd "${ripgrep_folder}"
        tar -xzf "${ripgrep_download}"
        mv */rg "${ripgrep_binary}"
        rm "${ripgrep_download}"
    )
    rm -rf "${ripgrep_folder}"
}

install
