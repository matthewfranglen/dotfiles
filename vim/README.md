# VIM

This is the configuration for vim. This includes enough plugins to require
a readme to briefly cover the benefits of each one.


## Plugins

These are the functional plugins. They change the behaviour of vim in some way.

### [ack](https://github.com/mileszs/ack.vim.git)

Better than grep!

### [ctrlp](https://github.com/kien/ctrlp.vim)

Allows you to find files by typing part of the name. Can handle typos and
abbreviations to a degree.

### [jslint.vim](https://github.com/hallettj/jslint.vim)

Javascript linting thanks to jslint.

### [kwbdi](https://github.com/vim-scripts/kwbdi.vim)

Allows you to close a buffer without changing the layout.
The buffer can be closed in this way using [leader]bd

### [neobundle](https://github.com/Shougo/neobundle.vim)

Vim plugin manager capable of downloading and building plugins.

### [nerdtree](https://github.com/scrooloose/nerdtree)

Provides a file browser in a split.
Can open it with :NERDTree, which will autocomplete from :N
A change in my vimrc allows it to be toggled with [F7]

### [syntastic](https://github.com/scrooloose/syntastic)

Linting for a wide variety of languages. Can use linting programs available on
the system.

### [tabular](https://github.com/godlygeek/tabular)

Allows you to easily line up code statements so that assignments can be more easily
read. There is an excellent help document available at :help Tabular.txt. The basic
use is:

:Tab /[PATTERN]

This will operate on the current line, and all lines above and below that also match
[PATTERN]. This will indent every occurance of pattern to be at the same point.
Example:

    a = b = c
    aa = bb = cc
    aaa = bbb = ccc

:Tab /=

    a   = b   = c
    aa  = bb  = cc
    aaa = bbb = ccc

The :Tab command with no pattern will repeat the last pattern.

### [tagbar](https://github.com/majutsushi/tagbar)

Provides an overview of the current file, showing a list of methods, variables, and
packages. You can navigate to the window and jump to the listed elements. Remember that
you can use '' (double single quote) to jump back to where you were previously.

A vimrc change allows you to toggle the (initially hidden) tagbar with [F8].

### [vim-colors-solarized](https://github.com/altercation/vim-colors-solarized)

Provides fancy colors for vim. There are a *lot* more here:

http://vimcolorschemetest.googlecode.com/svn/html/index-pl.html

### [vim-fugitive](https://github.com/tpope/vim-fugitive)

Git integration for VIM. Provides many commands which can be used to
both commit and read the git repo. Good tutorials here:

http://vimcasts.org/blog/2011/05/the-fugitive-series/

### [vim-numbertoggle](https://github.com/jeffkreeftmeijer/vim-numbertoggle)

Allows you to toggle the different forms of line number using [leader]n.

### [vim-repeat](https://github.com/tpope/vim-repeat)

Allows you to repeat plugin mapped actions using `.`. Requires specific support
from the plugin.

### [vim-sensible](https://github.com/tpope/vim-sensible)

Sensible defaults for vim. Has a lot of sensibles, and part of this is persistent undo
files. Those undo files will litter your filesystem unless you use the install script,
or create the ~/.local/share/vim/undo folder manually.

Notable improvements include incremental searches and the aforementioned undo files.

### [vim-surround](https://github.com/tpope/vim-surround)

Allows you to wrap motions (like words) with various characters. Supports
HTML / XML type tag opening and closing, as well as the various pairs of
{} [] () etc.

#### Quick Reference

cs[FROM][TO]            Change Surround (from single characters)
cst[TO]                 Change tag to ...

ds[SURROUND]            Delete surround

ys[MOTION][SURROUND]    Add surround. Not limited to single characters.
yss[SURROUND]           Wrap entire line.

Using { [ ( will add a surrounding space. Using } ] ) will not add that space.

Starting with < starts an xml/html tag. Starting with > will surround the
motion with <>.

### [vim-unimpaired](https://github.com/tpope/vim-unimpaired.git)

Provides pairs of actions which involve the [ and ] keys. There is a large
selection of action pairs, use `:help unimpaired` to see them all.

### [vim-visual-star-search](https://github.com/bronson/vim-visual-star-search)

Allows a visual selection to be used as the entire search for * and #. Vim
itself would just use the current word under the cursor (i.e. ignore the visual
selection entirely).

### [vim-xpath](https://github.com/actionshrimp/vim-xpath)

Allows you to perform XPath queries, and provides a split with the results. You can
select results to jump to the appropriate place in the XML document.

Use :XPathSearchPrompt to start the process. Requires libxml.

## Syntax Plugins

These are the syntax plugins. They add support for specific syntaxes.

### [dart-vim-plugin](https://github.com/dart-lang/dart-vim-plugin)

Syntax highlighting and such for the dart language.

### [nginx](https://github.com/vim-scripts/nginx.vim.git)

Syntax highlighting and such for nginx files.

### [vim-css3-syntax](https://github.com/hail2u/vim-css3-syntax.git)

Syntax highlighting and such for the css language, including css 3 support.

### [vim-golang](https://github.com/jnwhiteh/vim-golang.git)

Syntax highlighting and such for the go language.

### [vim-less](https://github.com/groenewege/vim-less.git)

Syntax highlighting and such for the dynamic stylesheet language
[LESS](http://lesscss.org).

### [vim-markdown](https://github.com/tpope/vim-markdown)

Syntax highlighting and such for the markdown language.

### [vim-perl](https://github.com/vim-perl/vim-perl)

Syntax highlighting and such for the perl language.
