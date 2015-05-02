if test -e ~/.gem/ruby && test -n "$( find ~/.gem/ruby -maxdepth 2 -name 'bin' )"
then
    path+=(~/.gem/ruby/*/bin)
fi
