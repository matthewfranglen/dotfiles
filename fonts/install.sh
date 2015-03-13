if which fc-cache >/dev/null
then
    fc-cache -f ~/.fonts
else
    echo "Unable to install fonts... fc-cache command not found"
fi
