"{ Global Variable
"{{ Builtin variables
" Disable Python2 support
let g:loaded_python_provider = 0

" Path to Python 3 interpreter (must be an absolute path), make startup
" faster. See https://neovim.io/doc/user/provider.html.
if executable('python3')
    let g:python3_host_prog = exepath('python')
else
    echoerr 'Python 3 executable not found! You must install Python 3 and set its PATH correctly!'
endif

" Custom mapping <leader> (see `:h mapleader` for more info)
let mapleader = ','
"}}

"{{ Disable loading certain plugins
" Whether to load netrw by default, see
" https://github.com/bling/dotvim/issues/4
" let g:loaded_netrw       = 0
" let g:loaded_netrwPlugin = 0
let g:netrw_liststyle = 3
"}}
"}
