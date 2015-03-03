if [ ! -e ~/.local/bin/pip ]
then
    wget --output-document /tmp/get-pip.py https://bootstrap.pypa.io/get-pip.py
    python /tmp/get-pip.py --user
    rm /tmp/get-pip.py
fi

~/.local/bin/pip install --user powerline-status
