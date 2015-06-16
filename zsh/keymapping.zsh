# VI Mode
bindkey -v

# Disable ctrl-s ctrl-q (suspend, resume. frequently really really annoying!)
# http://geekanova.blogspot.co.uk/2012/11/ctrl-s-freezes-terminal.html
stty -ixon -ixoff

# Map caps lock to escape. This can fail if your keyboard is plugged in after
# this runs, hence the function definition. As this updates X11 it should only
# be done locally.
function load_keyboard_map () {
    # Don't want to run this on remote hosts!
    # This updates X! Doing this via a keyboard map option now, don't want to
    # have to unset other things or worry about partial failures.
    [ -z "$SSH_CONNECTION" ] && setxkbmap -option caps:escape
}
load_keyboard_map

# Fix delete, home and end which would otherwise just caps a random bunch of
# characters. Thanks to Michael Francis for this fix!
# (Amazingly these bindings vary, so this may not work for you. inputrc is
# supposed to be the source for this sort of thing)
source =(
    cat /etc/inputrc |
        sed -ne '/^#/d'        \
            -e 's/://'         \
            -e 's/^/bindkey /' \
            -e '/\(delete-char\|beginning-of-line\|end-of-line\)/p'
)

# This allows the entire line to be used as a search when pressing up or down.
# Move to the start of the line to prevent this.
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# This allows control-r to be used to perform a reverse search
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

bindkey -M viins '^t' push-line
bindkey -M vicmd '^t' push-line

# This allows alt-. to insert the last word of the last command (i.e. !$)
bindkey "^[." insert-last-word

# Enter command mode and v will provide a full $EDITOR for commands
# N.B. The builtin fc (fix command) can be used to edit and rerun history
autoload -U         edit-command-line
zle      -N         edit-command-line
bindkey  -M vicmd v edit-command-line

# Map control-p to the vim ctrlp command. Will open vim and run ctrlp.
function vim-ctrlp () {
    BUFFER='vim +:CtrlP'
    zle accept-line
}
zle -N                vim-ctrlp
bindkey -M viins '^P' vim-ctrlp

function shell-fg () {
    if [ $#BUFFER -ne 0 ]
    then
        zle push-line
    fi
    BUFFER="fg"
    zle accept-line
}
zle -N       shell-fg
bindkey '^Z' shell-fg

# vim: set ai et sw=4 syntax=zsh :
