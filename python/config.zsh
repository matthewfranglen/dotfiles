if [ -e ~/.local/bin/virtualenvwrapper_lazy.sh ]
then
    source ~/.local/bin/virtualenvwrapper_lazy.sh
fi

if [ -e ~/.pyenv/bin ] && [ -z "${PYENV_INIT}" ]
then
    export PYENV_INIT=1
    export PATH="${HOME}/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
