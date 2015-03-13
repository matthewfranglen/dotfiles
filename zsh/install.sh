
install () {
    install_antigen
    install_fasd
}

install_antigen () {
    local antigen_script_file=~/.antigen.zsh

    get_url_to_file "https://raw.githubusercontent.com/zsh-users/antigen/master/antigen.zsh" "${antigen_script_file}" || return 1
}

install_fasd () {
    local fasd_script_file=~/.fasd.zsh

    get_url_to_file "https://raw.githubusercontent.com/clvv/fasd/master/fasd" "${fasd_script_file}" || return 1
    chmod 755 "${fasd_script_file}"
    ln -s "${fasd_script_file}" ~/.local/bin/fasd
}

get_url_to_file () {
    local url=$1
    local filename=$2

    if which wget >/dev/null
    then
        wget --output-document "${filename}" "${url}"
    elif which curl >/dev/null
    then
        curl --output "${filename}" "${url}"
    else
        echo "Unable to install zsh... wget and curl commands not found"
        return 1
    fi
}

install
