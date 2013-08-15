dot files
=========

This is my current set of dotfiles.


Installation
------------

The install command allows them to be easily installed on any machine.
The install command does not delete any files, and will indicate any
existing files. This allows you to delete (or move) some files and then
try out some specific parts of this.

Currently the install requires sudo to update the system font cache, you can
refuse the password prompt to avoid this. The font update allows you to select
one of several _for powerline_ fonts as the terminal font to improve the look
of the powerline. This system update will not occur when run over a SSH
connection.

The install command will also attempt to install zsh if it is not available.
This also requires sudo and cancelling it will cause the install to fail.

This works best on mate-terminal. Konqueror has also been tested, but
some minor graphical artifacts with the tmux powerline were found.


Dependencies
------------

The install-dependencies command can be used to install the apt-get
dependencies required for all parts to work well.


Make
----

The make command will compile the latest versions of all of the configurations
stored within the build folder. This will install missing dependencies which
requires sudo. The compiled binaries will be installed to the build/bin folder.
