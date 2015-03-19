if [ -z ${PYTHONPATH} ]
then
    PYTHONPATH=~/.local/lib/python2.7/site-packages/
else
    PYTHONPATH=${PYTHONPATH}:~/.local/lib/python2.7/site-packages/
fi

export PYTHONPATH
