# Takes a PID and executable name. Checks that the pid is running and is the executable.
function is_running_as () {
    local process_pid=$1
    local process_name=$2

    if ! ps -p "${process_pid}" &> /dev/null
    then
        return 1
    fi

    [ "$(ps -p ${process_pid} -o comm=)" = "${process_name}" ]
}

function load_ssh_agent () {
    if [ -f ~/.agent.env ]
    then
        . ~/.agent.env > /dev/null
        if ! is_running_as $SSH_AGENT_PID ssh-agent
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
        if ! is_running_as $DBUS_SESSION_BUS_PID dbus-daemon
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

function set_terminal_title () {
    echo -ne "\033k${1}\033\\"
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

    inotifywait --recursive --event "${EVENTS}" ${~watched_file}
}

function watch_and_execute () {
    local watched_file="$1"
    shift

    while wait_until_change "${watched_file}"
    do
        eval "${@}"
    done
}

function is_zip_file () {
    local file="${1}"

    [ "$(file --brief --mime-type ${file})" = "application/zip" ]
}

function zip_recursive_search () {
    local zipfile="${1}"
    local pattern="${2}"
    local result=""

    result=$(zipinfo -1 "${zipfile}" | egrep "${pattern}" 2>/dev/null | head -n1)

    if [ -n "${result}" ]
    then
        echo "${result}"
        return 0
    fi

    for inner in $(zipinfo -1 "${zipfile}")
    do
        if ! is_zip_file =(unzip -p "${zipfile}" "${inner}")
        then
            continue
        fi

        local result=$(zip_recursive_search =(unzip -p "${zipfile}" "${inner}") "${pattern}")

        if [ -n "${result}" ]
        then
            echo "${inner} -> ${result}"
            return 0
        fi
    done

    return 1
}

function docker_clean () {
    docker system prune -a
}

function mgk () {
    if ! git rev-parse --show-toplevel >/dev/null 2>&1
    then
        echo "Not inside a git repository" >&2
        return 1
    fi

    (
        cd "$(git rev-parse --show-toplevel)" ;
        gitk --all "$@" &!
    )
}

function mgg () {
    gitg --all "$@" &!
}


# Don't dirty up the process tree on remote servers
if [ -z $SSH_CONNECTION ]
then
    load_dbus_daemon
    load_ssh_agent
fi

# vim: set ai et sw=4 syntax=zsh :
