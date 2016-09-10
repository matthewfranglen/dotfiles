set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

validate () {
    which docker >/dev/null
}

install () {
    make_local_bin && install_pip && install_docker_compose
}

fail () {
    echo -- "Will not install docker-compose as docker is not available." >&2
}

install_docker_compose () {
    if [ -e "${HOME}/.local/bin/docker-compose" ]
    then
        return
    fi

    "${PIP_COMMAND}" install --user docker-compose
}

if validate
then
    install
else
    fail
fi
