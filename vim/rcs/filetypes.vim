""""
" Python
""""

let python_highlight_all = 1

augroup python_ft
  autocmd!
  autocmd FileType python syn keyword pythonDecorator True None False self
  autocmd BufNewFile,BufRead *.jinja set syntax=htmljinja
  autocmd FileType python map <buffer> F :set foldmethod=indent<cr>

  autocmd FileType python set cindent
  autocmd FileType python set cinkeys-=0#
  autocmd FileType python set indentkeys-=0#
  autocmd FileType python set shiftwidth=4
  autocmd FileType python set tabstop=4
augroup END
