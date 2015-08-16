
install () {
    prepare && install_git_up
}

validate () {
    which gem >/dev/null
}

fail () {
    echo -- "Cannot install git-up as ruby is not available." >&2
}

prepare () {
    if test ! -e ~/.gem
    then
        mkdir ~/.gem
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
