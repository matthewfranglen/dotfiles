alias ll='ls -l'
alias la='ls -a'
alias lal='ls -al'
alias lla='ls -al'

alias youtube='each "youtube-dl --extract-audio --output \"%(title)s.%(ext)s\" \"\$1\""'

function mgk () {
    gitk --all "$@" &!
}

function mgg () {
    gitg --all "$@" &!
}

# vim: set ai et sw=4 syntax=zsh :
