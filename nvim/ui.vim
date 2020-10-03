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
colorscheme horizon
"}}

"{{ LSP/Floating windows
hi Pmenu ctermbg=247 ctermfg=124 guibg=#4b4b4b guifg=#f1f1f1
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

hi link LspDiagnosticsInformation NormalFloat
hi link LspDiagnosticsInformationSign NormalFloat
hi link LspDiagnosticsInformationFloating NormalFloat

hi link LspDiagnosticsHint NormalFloat
hi link LspDiagnosticsHintSign NormalFloat
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
