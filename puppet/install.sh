set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

install () {
    if ! is_gem_command_available
    then
        echo "Unable to install puppet environment... gem not found" >&2
        return ${STATUS_ERROR}
    fi

    install_puppet_lint || return ${STATUS_ERROR}

    return ${STATUS_OK}
}

install_puppet_lint () {
    gem install --user puppet-lint
}

install
