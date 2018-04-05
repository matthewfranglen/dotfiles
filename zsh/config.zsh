# zmv allows for mass renames. Use -n to test the rename. Example:
# zmv '(*)-HDTV-WAKKA-WAKKA.(*)' '$1.$2'
autoload -U zmv

export KEYTIMEOUT=1

export VISUAL=vim
export EDITOR=vim
export SVN_EDITOR=vim
export GIT_EDITOR=vim

if [ -z ${JAVA_HOME} ] && [ -e /usr/lib/jvm/default-java ]
then
    export JAVA_HOME=/usr/lib/jvm/default-java
fi

export LC_ALL="en_GB.utf8"

# https://wiki.ubuntu.com/DesktopExperienceTeam/ApplicationMenu
# Disables global menu for everything.
export UBUNTU_MENUPROXY=

# Support multiple terms each of which must match exactly (i.e. not fuzzed).
# Can fuzz a word by starting with '
export FZF_DEFAULT_OPTS="--extended-exact"
# Setting fd as the default source for fzf
# This respects .gitignore
export FZF_DEFAULT_COMMAND='fd --type f'

# Disable python virtualenv prompt modifications
# They are handled by the prompt.zsh config
export VIRTUAL_ENV_DISABLE_PROMPT=1


# This allows exclusions and the like in the pattern expansion
setopt EXTENDED_GLOB

# Report the status of background jobs immediately, rather than waiting until
# just before printing a prompt.
setopt NOTIFY

setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt IGNORE_EOF

# don't expand aliases _before_ completion has finished
# like: git comm-[tab]
setopt COMPLETE_ALIASES

# vim: set ai et sw=4 syntax=zsh :
