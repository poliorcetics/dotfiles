augroup rust_auto_formatting
  autocmd!
  autocmd BufWritePost *.rs silent execute ":!rustfmt " . expand('%:p') . " 1>/dev/null 2>&1 || true"
augroup END
