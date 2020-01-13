augroup rust_auto_formatting
  autocmd!
  autocmd BufWritePost *.rs silent execute ":!rustfmt " . expand('%:p')
augroup END
