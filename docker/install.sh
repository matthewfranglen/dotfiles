
install () {
    prepare && install_docker_compose
}

validate () {
    which docker >/dev/null
}

fail () {
    echo -- "Will not install docker-compose as docker is not available." >&2
}

prepare () {
    if test ! -e ~/.local/bin/
    then
        mkdir ~/.local/bin/
    fi
}

install_docker_compose () {
    get_url_to_file "https://github.com/docker/compose/releases/download/VERSION_NUM/docker-compose-`uname -s`-`uname -m`" "~/.local/bin/docker-compose"
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
        echo "Unable to install docker-compose... wget and curl commands not found"
        return 1
    fi
}

install
