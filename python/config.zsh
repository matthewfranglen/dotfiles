if [ -z "${PYENV_ROOT+x}" ]
then
    export PYENV_ROOT="${HOME}/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"

    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
