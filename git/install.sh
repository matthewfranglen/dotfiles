. "`dirname \`dirname \\\`readlink -f $0\\\`\``/script/lib.sh"

validate () {
    which gem >/dev/null
}

install () {
    prepare && install_git_up
}

fail () {
    echo -- "Cannot install git-up as ruby is not available." >&2
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
