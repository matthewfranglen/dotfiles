if [ -e ~/.local/bin/virtualenvwrapper_lazy.sh ]
then
    source ~/.local/bin/virtualenvwrapper_lazy.sh
fi

if [ -e ~/.pyenv/bin ]
then
    export PATH="/home/matthew/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
