source ~/.antigen.zsh
[ -e ~/.antigen-plugins.zsh ] && source ~/.antigen-plugins.zsh
antigen-bundle Tarrasch/zsh-functional
antigen-bundle bobthecow/git-flow-completion
antigen-bundle matthewfranglen/easy-ln
antigen-bundle matthewfranglen/git-update
antigen-bundle matthewfranglen/memcached-cli
antigen-bundle matthewfranglen/spark
antigen-bundle matthewfranglen/speedread
antigen-bundle supercrabtree/k
antigen-bundle zsh-users/zsh-history-substring-search
antigen-bundle zsh-users/zsh-syntax-highlighting

for bundle in $antigen_bundles
do
    antigen-bundle ${bundle}
done
unset antigen_bundles

antigen-apply

# vim: set ai et sw=4 syntax=zsh :
