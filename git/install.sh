set -eu

. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

validate () {
    validate_gem_command && validate_ruby_dev
}

validate_gem_command () {
    which gem >/dev/null
}

validate_ruby_dev () {
    ruby -e 'require "mkmf"'
}

install () {
    prepare && install_git_up
}

fail () {
    echo -- "Cannot install git-up as ruby or ruby-dev is not available." >&2
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

if validate
then
    install
else
    fail
fi
