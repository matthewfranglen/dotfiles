source ~/.antigen.zsh

[ -e ~/.antigen-plugins.zsh ] && source ~/.antigen-plugins.zsh
antigen-bundle Tarrasch/zsh-colors
antigen-bundle Tarrasch/zsh-functional
antigen-bundle bobthecow/git-flow-completion
antigen-bundle matthewfranglen/docker-go
antigen-bundle matthewfranglen/easy-ln
antigen-bundle matthewfranglen/git-stashes
antigen-bundle matthewfranglen/git-update
antigen-bundle matthewfranglen/gitflow-avh --branch=master
antigen-bundle matthewfranglen/memcached-cli
antigen-bundle matthewfranglen/random
antigen-bundle matthewfranglen/show-server-cert
antigen-bundle matthewfranglen/spark
antigen-bundle matthewfranglen/speedread
antigen-bundle matthewfranglen/watch-me
antigen-bundle matthewfranglen/window-to-gif
antigen-bundle supercrabtree/k
antigen-bundle zsh-users/zsh-autosuggestions
antigen-bundle zsh-users/zsh-history-substring-search
antigen-bundle zsh-users/zsh-syntax-highlighting

for bundle in $antigen_bundles
do
    antigen-bundle ${bundle}
done
unset antigen_bundles

antigen-apply

# Set the autocomplete color for zsh-autocomplete.
# Has to be done after loading.
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=5"

source ~/.fzf.zsh

# vim: set ai et sw=4 syntax=zsh :
