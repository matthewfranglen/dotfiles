dot files
=========

This is my current set of dotfiles. It has been rewritten to be based heavily on https://github.com/holman/dotfiles


Installation
------------

    git clone https://github.com/matthewfranglen/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    script/bootstrap
    script/install

Testing
-------

Yeah, it's that bad.

    docker build --tag dotfiles --no-cache .
    docker run --volume $PWD:/root/.dotfiles --rm -ti dotfiles

Then run

    ~/.dotfiles/script/bootstrap && ~/.dotfiles/script/install ; zsh
