set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

install () {
    if ! is_docker_present
    then
        echo -- "Will not install docker-compose as docker is not available." >&3
        return ${STATUS_SKIPPED}
    fi

    if is_docker_compose_present
    then
        return ${STATUS_OK}
    fi

    make_local_bin         || return ${STATUS_ERROR}
    install_pip            || return ${STATUS_ERROR}
    install_docker_compose || return ${STATUS_ERROR}

    return ${STATUS_OK}
}

is_docker_present () {
    which docker >/dev/null
}

is_docker_compose_present () {
    [ -e "${LOCAL_BIN_FOLDER}/docker-compose" ]
}

install_docker_compose () {
    "${PIP_COMMAND}" install --user docker-compose
}

install
