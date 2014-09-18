dot files
=========

This is my current set of dotfiles.


Installation
------------

You can install this by running the _install.sh_ script. This can be done remotely:

    curl https://raw.githubusercontent.com/matthewfranglen/dotfiles/master/install.sh | bash


Provision Remote Servers
------------------------

You can install a minimal set of dotfiles on a remote server by running the _dotfiles-provision_ script with the name of the server:

    ./dotfiles-provision example.com

You can specify a port:

    ./dotfiles-provision example.com:2222

The _dotfiles-provision_ script must be in the root of the dotfiles folder. This must be a checkout of the github project.

The _dotfiles-provision_ script has requirements that can be met by installing the dotfiles on the machine you are running it from.


Future Plans
------------

In future it will be possible to supplement roles to apply to the remote server (allowing for host specific content).

In future more things will be available built from source, and it should be easy to install them.
