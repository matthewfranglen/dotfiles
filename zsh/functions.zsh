eval "$(~/.fasd.zsh --init auto)"

function load_ssh_agent () {
    if [ -f ~/.agent.env ]
    then
        . ~/.agent.env > /dev/null
        if ! kill -0 $SSH_AGENT_PID &> /dev/null
        then
            echo "Stale agent file found. Spawning new agent… "
            eval `ssh-agent | tee ~/.agent.env`
            ssh-add
        fi
    else
        echo "Starting ssh-agent"
        eval `ssh-agent | tee ~/.agent.env`
        ssh-add
    fi
}

function load_dbus_daemon () {
    if [ -f ~/.dbus.env ]
    then
        . ~/.dbus.env > /dev/null
        if ! kill -0 $DBUS_SESSION_BUS_PID &> /dev/null
        then
            echo "Stale daemon file found. Spawning new daemon… "
            eval `dbus-launch | tee ~/.dbus.env`
        fi
    else
        echo "Starting dbus daemon"
        eval `dbus-launch | tee ~/.dbus.env`
    fi
}

# http://stackoverflow.com/a/904023
function most_useless_use_of_zsh {
   local lines columns colour a b p q i pnew
   ((columns=COLUMNS-1, lines=LINES-1, colour=0))
   for ((b=-1.5; b<=1.5; b+=3.0/lines)) do
       for ((a=-2.0; a<=1; a+=3.0/columns)) do
           for ((p=0.0, q=0.0, i=0; p*p+q*q < 4 && i < 32; i++)) do
               ((pnew=p*p-q*q+a, q=2*p*q+b, p=pnew))
           done
           ((colour=(i/4)%8))
            echo -n "\\e[4${colour}m "
        done
        echo
    done
}

function make_java_source_ctags_file () {
    local jdk=${1:A}

    if [ ! -e ${jdk}/src.zip ]
    then
        echo "You must provide the path to the JDK" >&2
        false
        return
    fi

    (
        mkdir /tmp/java-source-code
        cd /tmp/java-source-code
        unzip ${jdk}/src.zip >/dev/null
        ctags --recurse -f ~/.vimtags_jdk .
    )
    rm -r /tmp/java-source-code
}

function set_terminal_title () {
    echo -ne "\033k${1}\033\\"
}

function show_github_activity () {
    antigen-bundle matthewfranglen/git-activity
    git-activity --limit $COLUMNS matthewfranglen | spark
}

# Combine fasd and control-p for quick file lookups.
# This isn't bound to a key as it needs a directory, so the name is short.
function vp () {
    (
        z "$*"
        vim +:CtrlP
    )
}

function vf () {
    vim $(f "$*")
}

# Join a list of arguments by the first argument
function join () {
    local IFS=$1
    shift
    echo $*
}

# This will watch some files, executing a command when any changes are made
# This requires the package 'inotify-tools'

local EVENTS="modify,attrib,close_write,move,create,delete"

function wait_until_change () {
    local watched_file="$1"

    if [ ! -e "${watched_file}" ]
    then
        echo "Path does not exist: ${watched_file}" >&2
        return 1
    fi

    if [ -d "${watched_file}" ]
    then
        inotifywait --recursive --event "${EVENTS}" "${watched_file}"
    else
        inotifywait --event "${EVENTS}" "${watched_file}"
    fi
}

function watch_and_execute () {
    local watched_file="$1"
    shift

    while wait_until_change "${watched_file}"
    do
        eval "${@}"
    done
}

# Don't dirty up the process tree on remote servers
if [ -z $SSH_CONNECTION ]
then
    load_dbus_daemon
    load_ssh_agent
fi

# vim: set ai et sw=4 syntax=zsh :
