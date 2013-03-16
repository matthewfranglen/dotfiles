call pathogen#infect()
call pathogen#helptags()
syntax on
filetype plugin indent on

set modeline

set expandtab
set tabstop=4
set shiftwidth=4

" http://stackoverflow.com/questions/5601749/how-to-filter-out-files-by-extension-in-nerdtree
let NERDTreeIgnore = ['\.pyc$']

syntax enable
set background=dark
colorscheme solarized

" Convince Vim it can use 256 colors inside Gnome Terminal.
" Needs CSApprox plugin
set t_Co=256


" Left/Right arrow keys change buffers in all modes
noremap  <Left> <Esc>:bp<CR>
inoremap <Left> <Esc>:bp<CR>
nnoremap <Left> <Esc>:bp<CR>
vnoremap <Left> <Esc>:bp<CR>

noremap  <Right> <Esc>:bn<CR>
inoremap <Right> <Esc>:bn<CR>
nnoremap <Right> <Esc>:bn<CR>
vnoremap <Right> <Esc>:bn<CR>

" Disable up/down arrow keys
noremap  <up>   <nop>
noremap  <down> <nop>
nnoremap <up>   <nop>
nnoremap <down> <nop>
vnoremap <up>   <nop>
vnoremap <down> <nop>
inoremap <up>   <nop>
inoremap <down> <nop>

" ; is an alias for :
nnoremap ; :

" Make mouse middle click paste without formatting it.
map <MouseMiddle> <Esc>"*p
