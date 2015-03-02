eval "$(~/.fasd.zsh --init auto)"

#############
# SSH AGENT #
#############

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
# Don't dirty up the process tree on remote servers
[ -z $SSH_CONNECTION ] && load_ssh_agent

###############
# DBUS DAEMON #
###############

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
# Don't dirty up the process tree on remote servers
[ -z $SSH_CONNECTION ] && load_dbus_daemon

#########
# SILLY #
#########

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

# vim: set ai et sw=4 syntax=zsh :
