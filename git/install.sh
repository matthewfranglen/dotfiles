
install () {
    prepare && install_git_up
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

install
