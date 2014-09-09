# Prompt based on Pure by Sindre Sorhus
# https://github.com/sindresorhus/pure
# MIT License


# Change this to your own username
DEFAULT_USERNAME=$(ls -l $0 | awk '{ print $3 }')

# Threshold (sec) for showing cmd exec time
CMD_MAX_EXEC_TIME=5


# For my own and others sanity
# git:
# %b => current branch
# %a => current action (rebase/merge)
# prompt:
# %F => color dict
# %f => reset color
# %~ => current path
# %* => time
# %n => username
# %m => shortname host
# %(?..) => prompt conditional - %(condition.true.false)

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git # You can add hg too if needed: `git hg`
zstyle ':vcs_info:git*' formats       ' %F{white} %b'
zstyle ':vcs_info:git*' actionformats ' %F{white} %b|%a'

# Show username if not default or if on another server
[[ $USER != $DEFAULT_USERNAME || ! -z $SSH_CONNECTION ]] && local username='%n@%m '

git_status() {
    if [ ! -z $vcs_info_msg_0_ ]
    then
        echo -n '%F{black}%K{green}'

        echo -n $vcs_info_msg_0_
        # Fastest possible way to check if repo is dirty
        # See: https://gist.github.com/sindresorhus/3898739
        git diff --quiet --ignore-submodules HEAD 2>/dev/null; [ $? -eq 1 ] && echo -n '%B%F{yellow} M %b' || echo -n ' '

        echo '%F{green}%K{black}'
    fi
}

pretty_print_time() {
    local seconds=$1
    local minutes=$(($seconds / 60))
    local hours=$(($minutes / 60))
    local days=$(($hours / 24))

    seconds=$(($seconds % 60))
    minutes=$(($minutes % 60))
    hours=$(($hours % 24))

    # Create array of the non-zero times.
    # Got to declare this separate from the local definition, otherwise things get all funny.
    local result
    result=()
    for value unit in $days d $hours h $minutes m $seconds s
    do
        if [ $value -gt 0 ]
        then
            result[$(($#result + 1))]="${value}${unit}"
        fi
    done

    # Join the array with spaces - could be much fancier
    echo ${(j: :)result}
}

# Displays the exec time of the last command if set threshold was exceeded
cmd_exec_time() {
    local stop=`date +%s`
    local start=${cmd_timestamp:-$stop}
    let local elapsed=$stop-$start
    [ $elapsed -gt $CMD_MAX_EXEC_TIME ] && pretty_print_time $elapsed
}

preexec() {
    cmd_timestamp=`date +%s`
}

precmd() {
    vcs_info
    # Add `%*` to display the time
    local _color
    if [ -z $SSH_CONNECTION ]
    then
        _color=white
    else
        _color=red
    fi
    print -P "\n%F{black}%K{$_color}%~ %F{$_color}%K{black}`git_status` %F{236}$username%f %F{yellow}`cmd_exec_time`%f%F{black}%k"

    # Reset value since `preexec` isn't always triggered
    unset cmd_timestamp
}

# Prompt turns red if the previous command didn't exit with 0
PROMPT='%{%(?.%F{green}.%F{red})%}➜%{%f%} '
# Can be disabled:
# PROMPT='%F{magenta}❯%f '

# Change Terminal / Screen / TMux title for terminal when moving to another machine
if [ ! -z $SSH_CONNECTION ]
then
    echo -ne "\033k${USER}@${HOST}\033\\"
fi

# vim: set ai et sw=4 syntax=zsh :
