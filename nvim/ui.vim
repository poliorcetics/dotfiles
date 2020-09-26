"{ UI-related settings
"{{ General settings about colors
" Enable true colors support. Do not set this option if your terminal does not
" support true colors! For a comprehensive list of terminals supporting true
" colors, see https://github.com/termstandard/colors and
" https://gist.github.com/XVilka/8346728.
set termguicolors

" Use dark background
set background=dark
"}}

"{{ Colorscheme settings
" colorscheme desert
colorscheme horizon
"}}

" Highlight groups for cursor color
augroup cursor_color
    autocmd!
    autocmd ColorScheme * highlight Cursor cterm=bold gui=bold guibg=green guifg=black
    autocmd ColorScheme * highlight Cursor2 guifg=red guibg=red
augroup END

" Set up cursor color and shape in various mode, ref:
" https://github.com/neovim/neovim/wiki/FAQ#how-to-change-cursor-color-in-the-terminal
set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor20
"}
