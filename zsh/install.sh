if [ ! -e ~/.antigen.zsh ]
then
    wget --output-document ~/.antigen.zsh https://raw.githubusercontent.com/zsh-users/antigen/master/antigen.zsh
fi

if [ ! -e ~/.fasd.zsh ]
then
    wget --output-document ~/.fasd.zsh https://raw.githubusercontent.com/clvv/fasd/master/fasd
    chmod 755 ~/.fasd.zsh
    ln -s ~/.fasd.zsh ~/.local/bin/fasd
fi
