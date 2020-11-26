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

"{ VARIABLES
let mapleader = ','                 " Custom map leader

"{{ Python
let g:loaded_python_provider = 0    " Disable Python2 support
" Path to Python 3 interpreter (must be an absolute path), make startup
" faster. See https://neovim.io/doc/user/provider.html.
if executable('python3')
    let g:python3_host_prog = exepath('python3')
else
    echoerr 'Python 3 executable not found! You must install Python 3 and set its PATH correctly!'
endif
"}}

"{{ NetRW
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_home = expand(stdpath('data'))      " Where to save netrw temp files
let g:netrw_liststyle = 3                       " Tree style
let g:netrw_list_hide = netrw_gitignore#Hide()  " Ignore what's in the .gitignore
let g:netrw_list_hide = g:netrw_list_hide.'.*\.swp$,\.Trash/$,target/$,'
let g:netrw_list_hide = g:netrw_list_hide.'\.localized$,\.Xauthority$,'
let g:netrw_list_hide = g:netrw_list_hide.'\.CFUserTextEncoding$,\.git/$,'
"}}
"}

"{ PLUGIN DOWNLOADS
call plug#begin(expand(stdpath('data') . '/plugged'))
" File editing plugins
Plug 'tpope/vim-commentary'             " Comment stuff out
Plug 'jiangmiao/auto-pairs'             " Insert matching parts of pairs
" Git plugins
Plug 'mhinz/vim-signify'                " Show changes in vim sign column
" Languages plugins
Plug 'cespare/vim-toml'                 " TOML language support
" LSP plugins
Plug 'neovim/nvim-lspconfig'            " Collections of common configurations for the Nvim LSP Client
Plug 'tjdevries/lsp_extensions.nvim'    " Extensions to built-in LSP (like inlay type hints)
Plug 'nvim-lua/completion-nvim'         " Autocompletion framework for built-in LSP
Plug 'liuchengxu/vista.vim'             " Tags/LSP symbols navigation/tree
" Movement plugins
Plug 'justinmk/vim-sneak'               " Super fast movement with s/S
Plug 'mg979/vim-visual-multi'           " Multi cursor editing
Plug 'wellle/targets.vim'               " VERY powerful plugin that should be properly studied to be used fully
Plug 'lotabout/skim', {                 
    \ 'dir': '~/.local/skim',
    \ 'do': './install'
    \ }                                 " Helper for the fuzzy finder
Plug 'lotabout/skim.vim'                " Fuzzy finder
" UI plugins (color, theme)
Plug 'ntk148v/vim-horizon'              " Horizon theme
Plug 'itchyny/lightline.vim'            " Status line
Plug 'norcalli/nvim-colorizer.lua'      " Colorize hex color codes/named colors
Plug 'itchyny/vim-cursorword'           " Underline the word under the cursor
Plug 'itchyny/vim-highlighturl'         " Highlight URLs inside Neovim
call plug#end()
"}

"{ OPTIONS
syntax enable                           " Syntax highlighting
filetype plugin indent on               " Filetype detection/plugin/indent

set autoread                            " Autoload file changes
set background=dark                     " Dark background
set confirm                             " Ask for confirmation when handling unsaved or read-only files
set fillchars=fold:\ ,vert:\│,msgsep:-  " Fill chars for folding, vertical splits, messages
set formatoptions+=mM                   " Correctly break multi-byte characters such as CJK
set history=2000                        " Number of commands and search history to keep
set ignorecase smartcase                " Ignore case in general, but become case-sensitive when uppercase is present
set inccommand=nosplit                  " The way to show the result of substitution in real time for preview
set nojoinspaces                        " Do not add two spaces after a period when joining lines or formatting texts
set nostartofline                       " Move to first non blank chracter in line when possible
set termguicolors                       " Enable true colors support. Do not set this option if your terminal does not
                                          " support true colors! For a comprehensive list of terminals supporting true
                                          " colors, see https://github.com/termstandard/colors and
                                          " https://gist.github.com/XVilka/8346728.
set timeoutlen=1000                     " Time in milliseconds to wait for a mapped sequence to complete,
set updatetime=300                      " Time in milliseconds of no cursor movement to trigger CursorHold
set virtualedit=block                   " Virtual edit is useful for visual block edit

"{{ Window options
set hid                                 " Hide buffer when abandoned
" set lazyredraw                          " Don't redraw when executing macros (good for small configs / max performance)
set list                                " Use list mode and customized listchars (line below)
set listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:+
set number relativenumber               " Line number and relative line number
set scrolloff=5                         " Minimum lines to keep above and below cursor when scrolling
set showmatch                           " Show matching brackets
set signcolumn=yes:1                    " Width of the signcolumn in multiples of 2
set splitbelow splitright               " Split window below/right when creating horizontal/vertical windows
set synmaxcol=200                       " Text after this column number is not highlighted
set title                               " SHow current file in the terminal title
set visualbell noerrorbells             " Do not use visual and error bells
"}}

"{{ Backup/undos/swapfiles
" Disable creating swapfiles, see https://stackoverflow.com/q/821902/6064933
set noswapfile

" Set up backup directory
let $backupdir = expand(stdpath('data') . '/backup')
if !isdirectory($backupdir) | call mkdir($backupdir, 'p') | endif
set backupdir=$backupdir,/tmp,/private/tmp         " Directories to try to write backups to
set backupskip+=$backupdir/*,/tmp/*,/private/tmp/* " Ignore the files in those directories for backups
set backupcopy=auto                                " Copy the original file to backupdir and overwrite it

" Set up undo directory
let $undodir = expand(stdpath('data') . '/undo')
if !isdirectory($undodir) | call mkdir($undodir, 'p') | endif
set undodir=$undodir,/tmp,/private/tmp             " Directories to write the undofiles to
set undofile                                       " Persistent undo
"}}

"{{ Clipboard
" Clipboard settings, always use clipboard for all delete, yank, change, put
" operation, see https://stackoverflow.com/q/30691466/6064933
if !empty(provider#clipboard#Executable())
    set clipboard+=unnamedplus
endif
"}}

"{{ Completion options
" Completion behaviour
set completeopt=menu,menuone,noinsert   " Show completion even if there is one item but do not autocomplete by default
set completeopt-=preview                " Ensure the preview window is disabled
set pumheight=10                        " Maximum number of items to show in popup menu
set shortmess+=c                        " Do not show "match xx of xx" and other messages during auto-completion
set complete=.,w,b,u,t,i,d,kspell       " Insert mode word completion setting
"}}

"{{ Cursor options
set cursorline              " Highlight cursor line
set colorcolumn=80,100,120  " Show columns at 80, 100 and 120 characters
"}}

"{{ Encodings and formats for files
set fileencoding=utf-8
set fileencodings=utf-8,latin1
set fileformats=unix,mac,dos
scriptencoding utf-8
"}}

"{{ Folds and folding
set foldlevelstart=0    " Start to fold immediately
set foldlevel=0         " Fold everything
set foldnestmax=4       " Maximum number of recursive fold
set foldmethod=syntax   " Default fold method, see `after/ftplugin/python.vim` for a local one
"}}

"{{ Grepping
" External program to use for grep command
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    set grepformat=%f:%l:%c:%m
endif
"}}

"{{ Line breaks
set linebreak   " Break at predifined characters
set showbreak=↪ " Character to show lines have been soft-wrapped
"}}


"{{ Spelling
set spelllang=en            " Spell languages
set spellsuggest=best,10    " The number of suggestions shown in the screen for z=
"}}

"{{ Status line
set laststatus=2 " Always show the status line
set noshowmode   " Hide '--INSERT--' and other such indicators
" Format the status line (will be replaced by plugins if necessary)
set statusline=>\ MODE:\ \[%{mode()}\]\ \ \[%{getcwd()}\]\ \ %{utils#HasPaste()}%F%m%r%h\ %w\ \ FT:\ %y\ \ Line:\ %l\ \ Column:\ %c
"}}

"{{ Tab and indenting
set expandtab       " Convert tabs to spaces
set shiftround      " Align indent to next multiple value of shiftwidth
set shiftwidth=4    " Size of tabs in spaces
set tabstop=4       " Number of spaces that a <Tab> in the file counts for
"}}

"{{ Wild options
set wildmenu
set wildmode=list:full
set wildoptions=pum,tagfile

" Ignore certain files and folders when globbing
set wildignore+=*.o,*.obj,*.bin,*.dll,*.exe,*.out
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/*,*/.vscode/*
set wildignore+=*/target/*,Cargo.lock
set wildignore+=*.pyc,.DS_Store
set wildignore+=*.DS_Store
"}}
"}

"{ AUTOCOMMANDS
" Do not use smart case in command line mode, extracted from https://vi.stackexchange.com/a/16511/15292.
aug dynamic_smartcase
    au!
    au CmdLineEnter : set nosmartcase
    au CmdLineLeave : set smartcase
aug END

aug term_settings
    au!
    au TermOpen * setlocal norelativenumber nonumber   " No number/relative number for terminal inside nvim
    au TermOpen * startinsert                          " Go to insert mode by default to start typing command
aug END

" More accurate syntax highlighting? (see `:h syn-sync`)
aug accurate_syn_highlight
    au!
    au BufEnter * :syntax sync fromstart
aug END

" Return to last edit position when opening a file
aug resume_edit_position
    au!
    au BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ | execute "normal! g`\"zvzz"
        \ | endif
aug END

" Display a message when the current file is not in utf-8 format.
" Note that we need to use `unsilent` command here because of this issue:
" https://github.com/vim/vim/issues/4379
aug non_utf8_file_warn
    au!
    au BufRead * if &fileencoding != 'utf-8' | unsilent echomsg 'File not in UTF-8 format!' | endif
aug END

" Automatically reload the file if it is changed outside of Nvim, see
" https://unix.stackexchange.com/a/383044/221410. It seems that `checktime`
" command does not work in command line. We need to check if we are in command
" line before executing this command. See also
" https://vi.stackexchange.com/a/20397/15292.
aug auto_read
    au!
    au FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() == 'n' && getcmdwintype() == '' | checktime | endif
    au FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded!" | echohl None
aug END

aug numbertoggle
    au!
    au BufEnter,FocusGained,WinEnter * if &nu | set rnu   | endif
    au BufLeave,FocusLost,WinLeave   * if &nu | set nornu | endif
aug END

" Highlight yanked region, see `:h lua-highlight`
aug yank_custom_highlight
    au!
    au ColorScheme * highlight YankColor ctermfg=59 ctermbg=41 guifg=#34495E guibg=#2ECC71
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="YankColor", timeout=700}
aug END

" Remember last tab
aug on_tab_leave
    au!
    au TabLeave * let g:lasttab = tabpagenr()
aug END
"}

"{ MAPPINGS
"{{ Buffers
" Next/previous buffer
noremap <leader>l :bnext<cr>
noremap <leader>h :bprevious<cr>
" Close the current buffer
noremap <leader>bd :bdel<cr>:tabclose<cr>gT
noremap <leader>bc :bdel<cr>
" Close all the buffers
noremap <leader>ba :bufdo bd<cr>
" List all the buffers
noremap <leader>bl :buffers<cr>
"}}
"{{ Completion
" When completion menu is shown, use <cr> to select an item and do not add an
" annoying newline. Otherwise, <enter> is what it is. For more info , see
" https://superuser.com/a/941082/736190 and
" https://unix.stackexchange.com/q/162528/221410
inoremap <expr> <cr> ((pumvisible())?("\<C-Y>"):("\<cr>"))
" Use <esc> to close auto-completion menu
inoremap <expr> <esc> ((pumvisible())?("\<C-e>"):("\<esc>"))
"}}

"{{ Folding movements
nnoremap z<Up> zk
nnoremap z<Down> zj
nnoremap z<Left> [z
nnoremap z<Right> ]z

vnoremap z<Up> zk
vnoremap z<Down> zj
vnoremap z<Left> [z
vnoremap z<Right> ]z
"}}

"{{ Indenting
" Continuous visual shifting (does not exit Visual mode), `gv` means
" to reselect previous visual area, see https://superuser.com/q/310417/736190
xnoremap < <gv
xnoremap > >gv
"}}

"{{ Location/Quickfix list navigation
" Close the quickfix/location window
nnoremap <silent> <leader>x :cclose<cr>:lclose<cr>
"}}

"{{ Marks
nnoremap <silent> ; `
nnoremap <silent> ;; ``
"}}
"{{ Modifications from outside Insert mode
" Insert a blank line below or above current line (do not move the cursor),
" see https://stackoverflow.com/a/16136133/6064933
nnoremap <expr> <leader>o 'm`' . v:count1 . 'o<Esc>``'
nnoremap <expr> <leader>O 'm`' . v:count1 . 'O<Esc>``'
" Insert a space after current character
nnoremap <leader><Space> a<Space><ESC>h
" Moving lines up/down in NORMAL mode
nnoremap <silent> <S-Up> :m .-2<cr>==
nnoremap <silent> <S-Down> :m .+1<cr>==
" In VISUAL mode
vnoremap <silent> <S-Up> :m '<-2<cr>gv=gv
vnoremap <silent> <S-Down> :m '>+1<cr>gv=gv
"}}

"{{ Movements
" Jump to matching pairs easily in normal mode
nnoremap <Tab> %
vnoremap <Tab> %
"}}

"{{ Pasting / Selecting / Yanking
" Change text without putting it into the vim register,
" see https://stackoverflow.com/q/54255/6064933
nnoremap c "_c
nnoremap C "_C
nnoremap cc "_cc

" Paste non-linewise text above or below current cursor,
" see https://stackoverflow.com/a/1346777/6064933
nnoremap <leader>p m`o<ESC>p``
nnoremap <leader>P m`O<ESC>p``

" Do not include white space characters when using $ in visual mode,
" see https://vi.stackexchange.com/q/12607/15292
xnoremap $ g_
" Reselect the text that has just been pasted
nnoremap <leader>v `[V`]

" Yank entire buffer.
nnoremap <silent> <leader>y :%y<cr>
" Yank from current cursor position to the end of the line (make it
" consistent with the behavior of D, C)
nnoremap Y y$
"}}

"{{ Search
" Clear highlighting
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<cr><cr><C-L>
" Search in selected region
vnoremap / :<C-U>call feedkeys('/\%>'.(line("'<")-1).'l\%<'.(line("'>")+1)."l")<cr>
" Start search with a space
nnoremap <Space> /
" Visual mode pressing * searches for the current selection
"             pressing # launch a search and replace on it
" From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call utils#VisualSelection('', '')<cr>/<C-R>=@/<cr><cr>
vnoremap <silent> # :<C-u>call utils#VisualSelection('', '')<cr>:%s/<C-R>=@/<cr>//g
"}}

"{{ Tabs
" Useful mappings for managing tabs
noremap <silent> <leader><leader> :tabnext<cr>
noremap <silent> <leader>; :tabprev<cr>
noremap <silent> <leader>tn :tabnew<cr>
noremap <silent> <leader>to :tabonly<cr>
noremap <silent> <leader>tc :tabclose<cr>
" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nnoremap <leader>tl :exe "tabn ".g:lasttab<cr>
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
noremap <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
"}}

"{{ Terminal
" Use Esc to quit builtin terminal
tnoremap <ESC> <C-\><C-n>
"}}

"{{ Utils and miscellaneous
" Check the syntax group of current cursor position
nnoremap <silent> <leader>st :call utils#SynGroup()<cr>
" Edit and reload init.vim quickly
nnoremap <silent> <leader>ev :tabnew $MYVIMRC <bar> tcd %:h<cr>
nnoremap <silent> <leader>sv :silent update $MYVIMRC <bar> source $MYVIMRC <bar>
            \ echomsg "Nvim config successfully reloaded!"<cr>
" Remove trailing whitespace characters
nnoremap <silent> <leader>k :call utils#StripTrailingWhitespaces() <bar>
            \ echomsg "Stripped trailing whitespaces"<cr>

" NetRW
nnoremap <leader>n :Explore<cr>
" Change current working directory locally and print cwd after that,
" see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
nnoremap <silent> <leader>cd :lcd %:p:h<cr>:pwd<cr>
nnoremap <leader>w :w<cr>
"}}
"}

"{ PLUGIN SETTINGS
"{{ File editing plugins
"}}

"{{ Git plugins
let g:signify_vcs_list = [ 'git', ]     " Ths VCS to use, I only use git right now
let g:signify_sign_change = '~'         " Change the sign for certain operations
"}}

"{{ Language plugins
"}}

"{{ LSP/Autocompletion plugins
" The most useful ones for me
nnoremap <silent> lp <cmd>lua vim.lsp.buf.code_action()<cr>
nnoremap <silent> lm <cmd>lua vim.lsp.buf.definition()<cr>
nnoremap <silent> ll <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> lf <cmd>lua vim.lsp.buf.formatting_sync()<cr>
nnoremap <silent> lk <cmd>lua vim.lsp.buf.rename()<cr>
nnoremap <silent> W <cmd>lua vim.lsp.diagnostic.goto_prev {wrap=true} <cr>
nnoremap <silent> X <cmd>lua vim.lsp.diagnostic.goto_next {wrap=true} <cr>

" xnoremap <silent> lp <cmd>lua vim.lsp.buf.range_code_action(nil, vim.api.nvim_eval("getpos(\"'<\")"), vim.api.nvim_eval("getpos(\"'>\")"))<cr>
" xnoremap <silent> lf <cmd>lua vim.lsp.buf.range_formatting(nil, vim.api.nvim_eval("getpos(\"'<\")"), vim.api.nvim_eval("getpos(\"'>\")"))<cr>

" Less useful but still cool
nnoremap <silent> lci <cmd>lua vim.lsp.buf.incoming_calls()<cr>
nnoremap <silent> lco <cmd>lua vim.lsp.buf.outgoing_calls()<cr>

" Miscellaneous
nnoremap <silent> ld <cmd>lua vim.lsp.buf.declaration()<cr>
nnoremap <silent> lc <cmd>lua vim.lsp.buf.document_symbol()<cr>
nnoremap <silent> li <cmd>lua vim.lsp.buf.implementation()<cr>
nnoremap <silent> ls <cmd>lua vim.lsp.buf.signature_help()<cr>
nnoremap <silent> lt <cmd>lua vim.lsp.buf.type_definition()<cr>
nnoremap <silent> lr <cmd>lua vim.lsp.buf.references()<cr>
nnoremap <silent> lw <cmd>lua vim.lsp.buf.workspace_symbol()<cr>

nnoremap <leader>rl :lua vim.lsp.stop_client(vim.lsp.get_active_clients())<cr>:edit<cr>:lua print("Server ready:", vim.lsp.buf.server_ready())<cr>

" Configure lsp
" https://github.com/neovim/nvim-lspconfig#rust_analyzer
lua <<EOF

-- lspconfig object
local lspconfig = require("lspconfig")

-- function to attach completion and diagnostics when setting up lsp
local on_attach = function(client)
    require("completion").on_attach(client)
    -- vim.api.nvim_command [[au CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
    -- vim.api.nvim_command [[au CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()]]
    vim.api.nvim_command [[au CursorHold  <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()]]
    vim.api.nvim_command [[au CursorHoldI <buffer> lua vim.lsp.diagnostic.show_line_diagnostics()]]
    vim.api.nvim_command [[au CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
    vim.api.nvim_command [[au Filetype *  setlocal omnifunc=v:lua.vim.lsp.omnifunc]]
end


-- Enable Rust Analyzer
lspconfig.rust_analyzer.setup {
    filetypes = { "rust"; "rs"; };
    on_attach = on_attach;
}

-- Enable clangd
lspconfig.clangd.setup {
    cmd = {
        "/usr/local/opt/llvm/bin/clangd";
        "--background-index";
        "--recovery-ast";
        "--clang-tidy";
        "--header-insertion=never";
        "--completion-parse=auto";
    };
    filetypes = { "c"; "cpp"; };
    on_attach = on_attach;
}

-- Enable PyLS
lspconfig.pyls.setup {
    configurationSources = { "pyflakes" };
    filetypes = { "python"; "py"; };
    on_attach = on_attach;
    plugins = {
        maccabe = { enabled = false; };
        pycodestyle = { enabled = false; };
        pydocstyle = { enabled = false; };
        pylint = { enabled = false; };
        yapf = { enabled = false; };
    };
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

let g:diagnostic_enable_virtual_text = 1        " Visualize diagnostics
let g:diagnostic_trimmed_virtual_text = '40'    " Trim inline messages to 40 characters
let g:diagnostic_insert_delay = 1               " Don't show diagnostics while in insert mode

augroup lsp_inlay_hints                         " Show diagnostic popup on cursor hover and enable type inlay hints
    au!
    au CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *
        \ lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "Comment" }
augroup END

let g:markdown_fenced_languages = [
    \ 'rs=rust', 'rust',
    \ 'bash=sh', 'zsh=sh',
    \ 'c',       'cpp',
    \ ]

"{{{ Vista
let g:vista_icon_indent = ["▸ ", ""]
let g:vista_default_executive = 'ctags'
let g:vista_executive_for = {
    \ 'c': 'lspconfig',
    \ 'cpp': 'lspconfig',
    \ 'rust': 'lspconfig',
    \ }
let g:vista#executives = [ 'ctags', 'lspconfig' ]
let g:vista#extensions = [ 'markdown', 'rst']
let g:vista#finders = [ 'sk', ]
let g:vista_cursor_delay = 100
let g:vista_blink = [0, 0]
let g:vista_top_level_blink = [0, 0]
let g:vista_echo_cursor_strategy = 'both'

nnoremap <silent> ù :Vista focus<cr>
nnoremap <silent> <F12> :Vista!!<cr>
nnoremap <silent> <F11> :Vista toc<cr>

hi link VistaColon Normal

aug vista_autocommand_for_search
    au!
    au FileType vista,vista_kind nnoremap <buffer> <silent> / :<c-u>call vista#finder#skim#Run()<CR>
aug END
"}}}
"}}

"{{ Movement plugins
" Jump immediately after entering sneak mode
let g:sneak#s_next = 1

let g:VM_default_mappings = 0
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'
let g:VM_maps['Find Subword Under'] = '<C-d>'
let g:VM_maps["Add Cursor Up"]      = '<C-p>'
let g:VM_maps["Add Cursor Down"]    = '<C-m>'
let g:VM_maps["Exit"]               = '<Esc>'

" Skim fuzzy finder

" The untracked and non-ignored will be at the bottom of the list.
" This is good because they are most of the time the ones I want when working
" on something that has a dirty git state.
let $SKIM_DEFAULT_COMMAND = "git ls-files -co --exclude-standard || fd --type f"
let g:fzf_command_prefix = 'SK'

nnoremap <leader>rg :SKRg<cr>
nnoremap <leader>fd :SKFiles .<cr>
nnoremap <leader>re :SKBLines<cr>
"}}

"{{ UI plugins
lua << EOF

-- NVIM Colorizer
-- Highlight all files, but customize some others.
require 'colorizer'.setup({
    '*';
    css = { rgb_fn = true; names = true; };
    vim = { names = true; };
}, { names = false; mode = 'foreground' })

EOF

let g:lightline = {
    \ 'colorscheme': 'solarized',
    \ 'active': {
    \    'left': [ [ 'mode', 'paste' ],
    \              [ 'readonly',
    \                'filename',
    \                'modified', ],
    \              [ 'vista_info' ], ],
    \    'right': [ [ 'percent', 'lineinfo' ],
    \               [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'component': {
    \    'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
    \    'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
    \ },
    \ 'component_function': {
    \    'vista_info': 'VistaStatusLine',
    \ },
    \ 'component_visible_condition': {
    \    'readonly': '(&filetype!="help"&& &readonly)',
    \    'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
    \ },
    \ 'separator': { 'left': ' ', 'right': ' ' },
    \ 'subseparator': { 'left': ' ', 'right': ' ' }
    \ }
"}}
"}

"{ UI & COLORSCHEME
colorscheme horizon

"{{ LSP/Floating windows
hi link NormalFloat Pmenu
hi Pmenu ctermbg=247 ctermfg=124 guibg=#3d4545 guifg=#f1f1f1
hi WarningMsg ctermfg=226 guifg=#ffff00

hi link LspDiagnosticsDefaultError       Error
hi link LspDiagnosticsDefaultWarning     WarningMsg
hi link LspDiagnosticsDefaultInformation NormalFloat
hi link LspDiagnosticsDefaultHint        NormalFloat

hi link LspDiagnosticsFloatingError NormalFloat
hi LspDiagnosticsFloatingError ctermfg=160 guifg=#cd3700

hi link LspDiagnosticsFloatingWarning NormalFloat
hi LspDiagnosticsFloatingWarning ctermfg=226 guifg=#ffff00
"}}
"}

"{ FUNCTIONS
function! VistaStatusLine() abort
    return get(b:, 'vista_nearest_method_or_function', '')
endfunction
"}
