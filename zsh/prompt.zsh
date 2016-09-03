# Prompt based on Pure by Sindre Sorhus
# https://github.com/sindresorhus/pure
# MIT License


# Change this to your own username
readonly DEFAULT_USERNAME=$(ls -l $0 | awk '{ print $3 }')

# Threshold (sec) for showing cmd exec time
readonly CMD_MAX_EXEC_TIME=5

# Show username if not default or if on another server
[ ! -z $SSH_CONNECTION ] && local username='%n@%m '

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
#
# colors (man zshmisc):
# %F (%f)
#        Start  (stop)  using  a  different foreground colour, if supported by
#        the terminal.  The colour may be specified two ways: either as a
#        numeric argument, as normal, or by a sequence in braces following the
#        %F, for example %F{red}.  In the latter case the values allowed are as
#        described for the fg zle_highlight attribute; see Character
#        Highlighting in zshzle(1).  This means that numeric colours are
#        allowed  in  the  second format also.
#
# %K (%k)
#        Start (stop) using a different bacKground colour.  The syntax is
#        identical to that for %F and %f.
#
# %{...%}
#        Include a string as a literal escape sequence.  The string within the
#        braces should not change the cursor position.  Brace pairs can nest.

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git # You can add hg too if needed: `git hg`
zstyle ':vcs_info:git*' formats       ' %F{white} %b'
zstyle ':vcs_info:git*' actionformats ' %F{white} %b|%a'

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

    print -P "\n`environment_status``path_status``git_status``user_status``command_execution_status`"

    # Reset value since `preexec` isn't always triggered
    unset cmd_timestamp
}

function zle-line-init zle-keymap-select {
    # Prompt turns red if the previous command didn't exit with 0
    INSERT_PROMPT='%{%(?.%F{green}.%F{red})%}➜%{%f%} '
    NORMAL_PROMPT='%{%F{blue}%}➜%{%f%} '

    case ${KEYMAP} in
        (vicmd)      PROMPT="$NORMAL_PROMPT" ;;
        (main|viins) PROMPT="$INSERT_PROMPT" ;;
        (*)          PROMPT="$INSERT_PROMPT" ;;
    esac
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select


environment_status() {
    local status_line
    status_line=$(join ' ' "$(docker_machine_status)" "$(virtualenv_status)")

    if [ -z "${status_line}" ]
    then
        return
    fi

    echo -n '%F{white}%K{black}'
    echo -n "${status_line}"
    echo ' %F{black}%K{white} '
}

path_status() {
    print -P "%F{black}%K{$_color}%~ %F{$_color}%K{black}"
}

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

user_status() {
    print -P " %F{236}$username%f %F{yellow}"
}

command_execution_status() {
    print -P "`cmd_exec_time`%f%F{black}%k"
}

docker_machine_status() {
    if [ -z ${DOCKER_MACHINE_NAME} ]
    then
        return
    fi

    echo -n "⊚∂ ${DOCKER_MACHINE_NAME}"
}

virtualenv_status() {
    if [ -z ${VIRTUAL_ENV} ]
    then
        return
    fi

    echo -n "⊚ℙ ${VIRTUAL_ENV:t}"
}

# Displays the exec time of the last command if set threshold was exceeded
cmd_exec_time() {
    local stop=`date +%s`
    local start=${cmd_timestamp:-$stop}
    let local elapsed=$stop-$start
    [ $elapsed -gt $CMD_MAX_EXEC_TIME ] && pretty_print_time $elapsed
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

# vim: set ai et sw=4 syntax=zsh :
