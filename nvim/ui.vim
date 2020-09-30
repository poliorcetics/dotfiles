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
" augroup cursor_color
"     autocmd!
"     autocmd ColorScheme * highlight Cursor cterm=bold ctermfg=Red ctermbg=Red gui=bold guibg=Red guifg=Red
"     autocmd ColorScheme * highlight Cursor2 ctermfg=Red ctermbg=Red guifg=Red guibg=Red
"     autocmd ColorScheme * highlight lCursor cterm=bold ctermfg=Red ctermbg=Red gui=bold guibg=Red guifg=Red
"     autocmd ColorScheme * highlight lCursor2 ctermfg=Red ctermbg=Red guifg=Red guibg=Red
" augroup END

" Set up cursor color and shape in various mode, ref:
" https://github.com/neovim/neovim/wiki/FAQ#how-to-change-cursor-color-in-the-terminal
" set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:ver25-Cursor2/lCursor2,r-cr:hor20,o:hor20

hi Visual ctermbg=240 guibg=#585858

"{{ LSP/Floating windows
hi Pmenu ctermbg=247 ctermfg=124 guibg=#757c87 guifg=#f1f1f1
hi link NormalFloat Pmenu

hi link LspDiagnosticsError Error
hi link LspDiagnosticsErrorSign Error
hi link LspDiagnosticsErrorFloating NormalFloat 
hi LspDiagnosticsErrorFloating ctermfg=160 guifg=#870000

hi WarningMsg ctermfg=226 guifg=#ffff00

hi link LspDiagnosticsWarning WarningMsg
hi link LspDiagnosticsWarningSign WarningMsg
hi link LspDiagnosticsWarningFloating NormalFloat
hi LspDiagnosticsWarningFloating ctermfg=226 guifg=#ffff00

hi link LspDiagnosticsInformation Normal
hi link LspDiagnosticsInformationSign Normal
hi link LspDiagnosticsInformationFloating NormalFloat

hi link LspDiagnosticsHint Normal
hi link LspDiagnosticsHintSign Normal
hi link LspDiagnosticsHintFloating NormalFloat
"}}

"{{ NVIM colorizer
lua << EOF

-- Highlight all files, but customize some others.
require 'colorizer'.setup({
    '*';
    css = { rgb_fn = true; names = true; };
    vim = { names = true; };
}, { names = false; mode = 'foreground' })

EOF
"}}
"}
