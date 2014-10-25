" Hides the symlinks that plague this project, making nerdtree a lot cleaner
function! NERDTreeCustomIgnoreFilter(path)
    if a:path.isSymLink
        return 1
    endif
endfunction

" Pylint is used by jenkins. Violations of pylint are something worth
" addressing, so reduce the linting noise.
let g:syntastic_python_checkers = ['pylint']

" Use custom settings for pylint. For once we will have NO IGNORABLE ERRORS!
" Yay!
let g:syntastic_python_pylint_args = '--rcfile pylintrc'
