if [ ! -z $SSH_CONNECTION ]
then
    echo "Not installing fonts... currently running on remote host"
    exit 0
fi

if ! which fc-cache >/dev/null
then
    echo "Unable to install fonts... fc-cache command not found"
    exit 0
fi

fc-cache -f ~/.fonts
