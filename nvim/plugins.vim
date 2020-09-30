"{ Plugin installation
"{{ Vim-plug directory
" The directory to install plugins.
let g:PLUGIN_HOME = expand(stdpath('data') . '/plugged')
"}}

call plug#begin(g:PLUGIN_HOME)
"{{ Movement related plugins
" Super fast movement with vim-sneak
Plug 'justinmk/vim-sneak'

Plug 'mg979/vim-visual-multi'
"}}

"{{ LSP related plugins
" Collection of common configurations for the Nvim LSP client
Plug 'neovim/nvim-lspconfig'

" Extentions to built-in LSP, for example, providing type inlay hints
Plug 'tjdevries/lsp_extensions.nvim'

" Autocompletion framework for built-in LSP
Plug 'nvim-lua/completion-nvim'

" Diagnostic navigation and settings for built-in LSP
Plug 'nvim-lua/diagnostic-nvim'

" Semantic highlighting for C/C++
" Plug 'jackguo380/vim-lsp-cxx-highlight'
"}}

"{{ UI: Color, theme etc.
Plug 'ntk148v/vim-horizon'
Plug 'norcalli/nvim-colorizer.lua'

Plug 'itchyny/vim-cursorword'
"}}

"{{ Plugin to deal with URL
" Highlight URLs inside vim
Plug 'itchyny/vim-highlighturl'
"}}

"{{ File editting plugin
" Comment plugin
Plug 'tpope/vim-commentary'
"}}

"{{ Git related plugins
" Show git change (change, delete, add) signs in vim sign column
Plug 'mhinz/vim-signify'

" Plug 'tpope/vim-fugitive'
"}}

"{{ Text object plugins
" Additional powerful text object for vim, this plugin should be studied
" carefully to use its full power
Plug 'wellle/targets.vim'
"}}

"{{ Misc plugins
Plug 'cespare/vim-toml'
Plug 'itchyny/lightline.vim'
" Tagbar needs universal-ctags: https://github.com/universal-ctags/ctags to work correctly
" Plug 'majutsushi/tagbar'
"}}
call plug#end()
"}

syntax enable
filetype plugin indent on

"{ Plugin settings
"{{ Auto-completion related
nnoremap <silent> <c-F1> <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> K      <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> gD     <cmd>lua vim.lsp.buf.implementation()<cr>
nnoremap <silent> <c-k>  <cmd>lua vim.lsp.buf.signature_help()<cr>
nnoremap <silent> 1gD    <cmd>lua vim.lsp.buf.type_definition()<cr>
nnoremap <silent> gr     <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> g0     <cmd>lua vim.lsp.buf.document_symbol()<cr>
nnoremap <silent> gW     <cmd>lua vim.lsp.buf.workspace_symbol()<cr>
nnoremap <silent> gd     <cmd>lua vim.lsp.buf.declaration()<cr>

" Configure lsp
" https://github.com/neovim/nvim-lspconfig#rust_analyzer
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require 'nvim_lsp'
local util = require 'nvim_lsp/util'

-- function to attach completion and diagnostics when setting up lsp
local on_attach = function(client)
    require 'completion'.on_attach(client)
    require 'diagnostic'.on_attach(client)
end

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup {
    on_attach = on_attach;
    filetypes = { "rust"; "rs" };
    root_dir = util.root_pattern("Cargo.toml");
}

-- Enable clangd
nvim_lsp.clangd.setup {
    cmd = { "/usr/local/opt/llvm/bin/clangd"; "--background-index" };
    filetypes = { "c"; "cpp" };
    root_dir = util.root_pattern("compile_commands.json", "compile_flags.txt");
    on_attach = on_attach;
    -- Enable semantic highlighting for C/C++
    -- init_options = {
    --     highlight = {
    --     }
    -- }
}

EOF

"{{{ clangd and compile_commands.json
" - https://clang.llvm.org/docs/JSONCompilationDatabase.html
"
" CMAKE:
"
"   cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1
"
" compile_commands.json will be written to your build directory. You should
" symlink it (or copy it) to the root of your project, if they are different.
"
"   ln -s ~/myproject-build/compile_commands.json ~/myproject/
"
" BEAR MAKE:
"
" - https://github.com/rizsotto/Bear
" - Use the following command to generate it for `make` based compilation:
"
"   make clean; bear make
"
" COMPILEDB MAKE:
"
" - https://github.com/nickdiego/compiledb
" - Use the following command to generate the `compile_commands.json` file:
"
"   compiledb make
"}}}

" Visualize diagnostics
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_trimmed_virtual_text = '40'
" Don't show diagnostics while in insert mode
let g:diagnostic_insert_delay = 1

" Show diagnostic popup on cursor hover
augroup lsp_diagnostics
    au!
    autocmd CursorHold * lua vim.lsp.util.show_line_diagnostics()
    " Enable type inlay hints
    autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
        \ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment" }
augroup END

let g:markdown_fenced_languages = [
    \ 'rs=rust',
    \ 'rust',
    \ 'bash=sh',
    \ 'c',
    \ 'cpp',
    \ ]
"}}

"{{ Movement related
"""""""""""""""""""""""""""""vim-sneak settings"""""""""""""""""""""""
" Jump immediately after entering sneak mode
let g:sneak#s_next = 1

"""""""""""""""""""""""""""""vim-visual-multi settings"""""""""""""""""""""""
let g:VM_default_mappings = 0

let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'
let g:VM_maps['Find Subword Under'] = '<C-d>'
let g:VM_maps["Add Cursor Up"]      = '<C-p>'
let g:VM_maps["Add Cursor Down"]    = '<C-m>'
let g:VM_maps["Exit"]               = '<Esc>'
"}}

"{{ Navigation and tags
""""""""""""""""""""""""""" tagbar settings """"""""""""""""""""""""""""""""""
" let g:tagbar_autoshowtag = 1
" let g:tagbar_autopreview = 1
" let g:tagbar_previewwin_pos = 'botright'
" let g:tagbar_sort = 0

" " Shortcut to toggle tagbar window
" nnoremap <silent> <F12> :TagbarToggle<CR>
" noremap <silent> <F11> :TagbarOpen fj<cr>
" noremap <silent> <F10> :TagbarSetFoldlevel 99<cr>
" noremap <silent> <F9> :TagbarSetFoldlevel 1<cr>

" " Add support for markdown files in tagbar.
" let g:md_ctags_bin = fnamemodify(stdpath('config').'/tools/markdown2ctags.py', ':p')

" let g:tagbar_type_markdown = {
"     \ 'ctagstype': 'markdown.pandoc',
"     \ 'ctagsbin' : g:md_ctags_bin,
"     \ 'ctagsargs' : '-f - --sort=yes',
"     \ 'kinds' : [
"     \   's:sections',
"     \   'i:images'
"     \ ],
"     \ 'sro' : '|',
"     \ 'kind2scope' : {
"     \   's' : 'section',
"     \ },
"     \ 'sort': 0,
"     \ }

" " https://github.com/majutsushi/tagbar/wiki#universal-ctags-variant
" let g:rust_use_custom_ctags_defs = 1
" let g:tagbar_type_rust = {
"     \ 'ctagsbin' : 'ctags',
"     \ 'ctagstype' : 'rust',
"     \ 'kinds' : [
"     \     'n:modules',
"     \     's:structures:1',
"     \     'i:interfaces',
"     \     'c:implementations',
"     \     'f:functions:1',
"     \     'g:enumerations:1',
"     \     't:type aliases:1:0',
"     \     'v:constants:1:0',
"     \     'M:macros:1',
"     \     'm:fields:1:0',
"     \     'e:enum variants:1:0',
"     \     'P:methods:1',
"     \ ],
"     \ 'sro': '::',
"     \ 'kind2scope' : {
"     \     'n': 'module',
"     \     's': 'struct',
"     \     'i': 'interface',
"     \     'c': 'implementation',
"     \     'f': 'function',
"     \     'g': 'enum',
"     \     't': 'typedef',
"     \     'v': 'variable',
"     \     'M': 'macro',
"     \     'm': 'field',
"     \     'e': 'enumerator',
"     \     'P': 'method',
"     \ },
"     \ }
"}}

"{{ Git-related
"""""""""""""""""""""""""vim-signify settings""""""""""""""""""""""""""""""
" The VCS to use
let g:signify_vcs_list = [ 'git', ]

" Change the sign for certain operations
let g:signify_sign_change = '~'
"}}

"{{ UI: Status line, look
let g:lightline = {
    \ 'colorscheme': 'solarized',
    \ 'active': {
    \    'left': [ [ 'mode', 'paste' ],
    \              [ 'readonly',
    \                'filename',
    \                'modified' ] ],
    \    'right': [ [ 'percent', 'lineinfo' ],
    \               [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'component': {
    \    'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
    \    'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
    \ },
    \ 'component_visible_condition': {
    \    'readonly': '(&filetype!="help"&& &readonly)',
    \    'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
    \ },
    \ 'separator': { 'left': ' ', 'right': ' ' },
    \ 'subseparator': { 'left': ' ', 'right': ' ' }
    \ }
" With vim-fugitive and ALE support:
" let g:lightline = {
"     \ 'colorscheme': 'solarized',
"     \ 'active': {
"     \    'left': [ [ 'mode', 'paste' ],
"     \              [
"     \                'fugitive',
"     \                'readonly',
"     \                'filename',
"     \                'modified' ] ],
"     \    'right': [ " [ 'linter_checking', 'linter_errors', 'linter_warnings' ],
"     \               [ 'percent', 'lineinfo' ],
"     \               [ 'fileformat', 'fileencoding', 'filetype' ] ]
"     \ },
"     \ 'component_expand': {
"     \    'linter_checking': 'lightline#ale#checking',
"     \    'linter_warnings': 'lightline#ale#warnings',
"     \    'linter_errors': 'lightline#ale#errors'
"     \ },
"     \ 'component': {
"     \    'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
"     \    'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
"     \    'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}',
"     \ },
"     \ 'component_visible_condition': {
"     \    'readonly': '(&filetype!="help"&& &readonly)',
"     \    'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
"     \    'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
"     \ },
"     \ 'component_type': {
"     \    'linter_checking': 'left',
"     \    'linter_warnings': 'warning',
"     \    'linter_errors': 'error'
"     \ },
"     \ 'separator': { 'left': ' ', 'right': ' ' },
"     \ 'subseparator': { 'left': ' ', 'right': ' ' }
"     \ }
"}}

"{{ Misc plugin setting
"}}
"}
