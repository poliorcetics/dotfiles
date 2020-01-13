augroup rust_auto_formatting
  autocmd!
  autocmd BufWritePost *.rs silent execute ":!rustfmt " . expand('%:p') . " 2>&1 1>/dev/null"
augroup END
