set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

install () {
    if ! validate
    then
        echo "Unable to install git-up... ruby or ruby-dev is not available." >&2
        return ${STATUS_ERROR}
    fi

    prepare        || return ${STATUS_ERROR}
    install_git_up || return ${STATUS_ERROR}

    return ${STATUS_OK}
}

validate () {
    validate_gem_command && validate_ruby_dev
}

validate_gem_command () {
    which gem >/dev/null
}

validate_ruby_dev () {
    ruby -e 'require "mkmf"'
}

prepare () {
    if test ! -e "${HOME}/.gem"
    then
        mkdir "${HOME}/.gem"
    fi
}

install_git_up () {
    gem install --user-install git-up
}

install
