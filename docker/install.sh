. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

validate () {
    which docker >/dev/null
}

install () {
    make_local_bin && install_pip && install_docker_compose && install_docker_machine
}

fail () {
    echo -- "Will not install docker-{compose,machine} as docker is not available." >&2
}

install_docker_compose () {
    "${HOME}/.local/bin/pip" install --user docker-compose
}

install_docker_machine () {
    get_url_to_file "https://github.com/docker/machine/releases/download/v0.4.0/docker-machine_linux-amd64" "${HOME}/.local/bin/docker-machine"
    chmod 755 "${HOME}/.local/bin/docker-machine"
}

if validate
then
    install
else
    fail
fi
