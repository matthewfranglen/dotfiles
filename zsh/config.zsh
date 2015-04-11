# zmv allows for mass renames. Use -n to test the rename. Example:
# zmv '(*)-HDTV-WAKKA-WAKKA.(*)' '$1.$2'
autoload -U zmv

# This allows exclusions and the like in the pattern expansion
setopt extended_glob

# Report the status of background jobs immediately, rather than waiting until
# just before printing a prompt.
setopt notify

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

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
if [ -z ${JAVA_HOME} ]
then
    export JAVA_HOME=/usr/lib/jvm/default-java
fi

export LC_ALL="en_US.UTF-8"

# vim: set ai et sw=4 syntax=zsh :
