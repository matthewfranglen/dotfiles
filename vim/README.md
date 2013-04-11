# VIM

This is the configuration for vim. This includes enough plugins to require
a readme to briefly cover the benefits of each one.


## Plugins

### [dart-vim-plugin](https://github.com/dart-lang/dart-vim-plugin)

Syntax highlighting and such for the dart language.

### [fugitive](https://github.com/tpope/vim-fugitive)

Git integration for VIM. Provides many commands which can be used to
both commit and read the git repo. Good tutorials here:

http://vimcasts.org/blog/2011/05/the-fugitive-series/

### [kwbdi](https://github.com/vim-scripts/kwbdi.vim)

Allows you to close a buffer without changing the layout.
The buffer can be closed in this way using <leader>bd

### [nerdtree](https://github.com/scrooloose/nerdtree)

Provides a file browser in a split.
Can open it with :NERDTree, which will autocomplete from :N
A change in my vimrc allows it to be toggled with <F7>

### [pyflakes](https://github.com/kevinw/pyflakes-vim)

Provides validation for python as you write. Problem lines get underlined
and when you move to them the error will appear in the status area. If you
have done something that fills the status area (like writing the file) you
will have to move off and back onto the line.

### [solarized](https://github.com/altercation/vim-colors-solarized)

Provides fancy colors for vim. There are a *lot* more here:

http://vimcolorschemetest.googlecode.com/svn/html/index-pl.html

### [syntastic](https://github.com/scrooloose/syntastic)

Another validation plugin, this one has a wide range of supported languages.
Uses chevrons on the left hand side to indicate problem languages. Has had some
false starts with Perl programs, but, well, Perl.

### [tabular](https://github.com/godlygeek/tabular)

Allows you to easily line up code statements so that assignments can be more easily
read. There is an excellent help document available at :help Tabular.txt. The basic
use is:

:Tab /<PATTERN>

This will operate on the current line, and all lines above and below that also match
<PATTERN>. This will indent every occurance of pattern to be at the same point.
Example:

    a = b = c
    aa = bb = cc
    aaa = bbb = ccc

:Tab /=

    a   = b   = c
    aa  = bb  = cc
    aaa = bbb = ccc

The :Tab command with no pattern will repeat the last pattern.

### [Tagbar](https://github.com/majutsushi/tagbar)

Provides an overview of the current file, showing a list of methods, variables, and
packages. You can navigate to the window and jump to the listed elements. Remember that
you can use '' (double single quote) to jump back to where you were previously.

A vimrc change allows you to toggle the (initially hidden) tagbar with <F8>.

### [vim-markdown](https://github.com/tpope/vim-markdown)

Syntax and stuff for markdown? I was hoping for more somehow.

### [vim-sensible](https://github.com/tpope/vim-sensible)

Sensible defaults for vim. Has a lot of sensibles, and part of this is persistent undo
files. Those undo files will litter your filesystem unless you use the install script,
or create the ~/.local/share/vim/undo folder manually.

Notable improvements include incremental searches and the aforementioned undo files.

### [vim-speeddating](https://github.com/tpope/vim-speeddating)

Allows ctrl-a and ctrl-x to work correctly on dates and times.

### [vim-surround](https://github.com/tpope/vim-surround)

Allows you to wrap motions (like words) with various characters. Supports
HTML / XML type tag opening and closing, as well as the various pairs of
{} [] () etc.

#### Quick Reference

cs<FROM><TO>            Change Surround (from single characters)
cst<TO>                 Change tag to ...

ds<SURROUND>            Delete surround

ys<MOTION><SURROUND>    Add surround. Not limited to single characters.
yss<SURROUND>           Wrap entire line.

Using { [ ( etc will add a surrounding space. Using } ] ) will not add that space.

### [vim-xpath](https://github.com/actionshrimp/vim-xpath)

Allows you to perform XPath queries, and provides a split with the results. You can
select results to jump to the appropriate place in the XML document.

Use :XPathSearchPrompt to start the process. Requires libxml.
