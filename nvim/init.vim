let g:nvim_config_root = stdpath('config')

let g:config_file_list = ['variables.vim',
    \ 'options.vim',
    \ 'autocommands.vim',
    \ 'mappings.vim',
    \ 'plugins.vim',
    \ 'ui.vim'
    \ ]

for s:fname in g:config_file_list
    execute 'source ' . g:nvim_config_root . '/' . s:fname
endfor

" A list of resources which inspire me
" This list is non-exhaustive as I can not remember the source of many
" settings.
"
" - http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" - https://github.com/tamlok/tvim/blob/master/.vimrc
" - https://nvie.com/posts/how-i-boosted-my-vim/
" - https://blog.carbonfive.com/2011/10/17/vim-text-objects-the-definitive-guide/
" - https://sanctum.geek.nz/arabesque/vim-anti-patterns/
" - https://github.com/gkapfham/dotfiles/blob/master/.vimrc
" - https://google.github.io/styleguide/vimscriptguide.xml
