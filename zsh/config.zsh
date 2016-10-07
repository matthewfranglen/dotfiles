# zmv allows for mass renames. Use -n to test the rename. Example:
# zmv '(*)-HDTV-WAKKA-WAKKA.(*)' '$1.$2'
autoload -U zmv

# This allows exclusions and the like in the pattern expansion
setopt extended_glob

# Report the status of background jobs immediately, rather than waiting until
# just before printing a prompt.
setopt notify

export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

export KEYTIMEOUT=1

setopt NO_BG_NICE # don't nice background tasks
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS # allow functions to have local options
setopt LOCAL_TRAPS # allow functions to have local traps
setopt HIST_VERIFY
setopt SHARE_HISTORY # share history between sessions ???
setopt EXTENDED_HISTORY # add timestamps to history
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF

setopt APPEND_HISTORY # adds history
setopt INC_APPEND_HISTORY SHARE_HISTORY # adds history incrementally and share it across sessions
setopt HIST_IGNORE_ALL_DUPS # don't record dupes in history
setopt HIST_REDUCE_BLANKS

# don't expand aliases _before_ completion has finished
# like: git comm-[tab]
setopt complete_aliases

export VISUAL=vim
export EDITOR=vim
export SVN_EDITOR=vim
export GIT_EDITOR=vim
export LESS=ir
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

# Set the autocomplete color for zsh-autocomplete
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=5"

# Permit X11 sharing with docker containers
# Allows using docker containers for GUI applications
# See https://blog.jessfraz.com/post/docker-containers-on-the-desktop/
if [ -z "$SSH_CONNECTION" ]
then
    xhost +
fi

# Disable python virtualenv prompt modifications
# They are handled by the prompt.zsh config
export VIRTUAL_ENV_DISABLE_PROMPT=1

# vim: set ai et sw=4 syntax=zsh :
