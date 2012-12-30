# This adds additional functionality to the zsh above and beyond the default settings

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory notify
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _list _expand _complete _ignored _match
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 0
zstyle ':completion:*' menu select=1
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/orfax/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# This allows exclusions and the like in the pattern expansion
setopt extended_glob

###############################
# make less more friendly for #
# non-text input files, see   #
# lesspipe(1)                 #
###############################
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Extra key mappings
bindkey "^[." insert-last-word

# add bin folder to path
PATH=$PATH:${0:h}/bin

# Load aliases, prompt etc
. ${0:h}/aliases
. ${0:h}/prompt

# Editor stuff

export VISUAL=/usr/bin/vim
export EDITOR=/usr/bin/vim
export SVN_EDITOR=/usr/bin/vim
export GIT_EDITOR=/usr/bin/vim
export LESS=ir
export JAVA_HOME=/usr/lib/jvm/default-java

# vim: set ai et sw=4 syntax=sh :
