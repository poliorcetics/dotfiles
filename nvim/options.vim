"{ Builtin options and settings
" NetRW
let g:netrw_list_hide = netrw_gitignore#Hide()
let g:netrw_list_hide = g:netrw_list_hide.'.*\.swp$,\.Trash/$,target/$,'
let g:netrw_list_hide = g:netrw_list_hide.'\.localized$,\.Xauthority$,'
let g:netrw_list_hide = g:netrw_list_hide.'\.CFUserTextEncoding$,\.git/$,'
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
let g:netrw_home = stdpath('data')

" change filechar for folding, vertical split, and message sepator
set fillchars=fold:\ ,vert:\│,msgsep:‾

" Split window below/right when creating horizontal/vertical windows
set splitbelow splitright

" Time in milliseconds to wait for a mapped sequence to complete,
" see https://unix.stackexchange.com/q/36882/221410 for more info
set timeoutlen=1000

" CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300

" One clipboard to rule them all (else use `"+yy` to copy the current line under the cursor)
" Clipboard settings, always use clipboard for all delete, yank, change, put
" operation, see https://stackoverflow.com/q/30691466/6064933
if !empty(provider#clipboard#Executable())
    set clipboard+=unnamedplus
endif

" Disable creating swapfiles, see https://stackoverflow.com/q/821902/6064933
set noswapfile

" Set up backup directory
let g:backupdir = expand(stdpath('data') . '/backup')
if !isdirectory(g:backupdir)
   call mkdir(g:backupdir, 'p')
endif
set backupdir=g:backupdir,/tmp,/private/tmp
set backupskip+=g:backupdir/*,/tmp/*,/private/tmp/*

" Copy the original file to backupdir and overwrite it
set backupcopy=auto

" Set up undo directory
let g:undodir = expand(stdpath('data') . '/undo')
if !isdirectory(g:undodir)
   call mkdir(g:undodir, 'p')
endif
set undodir=g:undodir,/tmp,/private/tmp
" Persistent undo means you can undo after closing a buffer/Vim/NeoVim
set undofile

" General tab settings
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " expand tab to spaces so that tabs are spaces

" Show line number and relative line number
set number relativenumber

" Ignore case in general, but become case-sensitive when uppercase is present
set ignorecase smartcase

" File and script encoding settings for vim
set fileencoding=utf-8
set fileencodings=utf-8,latin1
scriptencoding utf-8

" Break line at predefined characters
set linebreak
" Character to show before the lines that have been soft-wrapped
set showbreak=↪

" Have a fixed column for the diagnostics to appear in.
" This removes the jitter when warnings/errors flow in
set signcolumn=yes

" List all items and start selecting matches in cmd completion
set wildmode=list:full

" Show current line where the cursor is
set cursorline
" Set a ruler at column 80, see https://stackoverflow.com/q/2447109/6064933
set colorcolumn=80,100,120

" Minimum lines to keep above and below cursor when scrolling
set scrolloff=5

" Use mouse to select and resize windows, etc.
set mouse=nic         " Enable mouse in several mode
set mousemodel=popup  " Set the behaviour of mouse

" Always show the status line
set laststatus=2

" Format the status line (will be replaced by plugins if necessary)
set statusline=>\ MODE:\ \[%{mode()}\]\ \ \[%{getcwd()}\]\ \ %{utils#HasPaste()}%F%m%r%h\ %w\ \ FT:\ %y\ \ Line:\ %l\ \ Column:\ %c
" Hide the '--INSERT--' and '--VISUAL--' indicators
set noshowmode

" Fileformats to use for new files
set fileformats=unix,mac,dos

" The way to show the result of substitution in real time for preview
set inccommand=nosplit

" Ignore certain files and folders when globbing
set wildignore+=*.o,*.obj,*.bin,*.dll,*.exe,*.out
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**,*/.vscode/*
set wildignore+=*/target/*,Cargo.lock
set wildignore+=*.pyc
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz

" Ask for confirmation when handling unsaved or read-only files
set confirm

" Do not use visual and errorbells
set visualbell noerrorbells

" The level we start to fold
set foldlevel=0

" The number of command and search history to keep
set history=500

" Use list mode and customized listchars
set list listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:+

" Show current file in the terminal title
set title

" Do not show "match xx of xx" and other messages during auto-completion
set shortmess+=c

" Completion behaviour
set completeopt=menuone,noinsert,noselect
set completeopt-=preview  " Disable the preview window

" Settings for popup menu
set pumheight=10  " Maximum number of items to show in popup menu

" Insert mode key word completion setting
set complete+=kspell complete-=w complete-=b complete-=u complete-=t

set spelllang=en      " Spell languages
set spellsuggest+=10  " The number of suggestions shown in the screen for z=

" Align indent to next multiple value of shiftwidth. For its meaning,
" see http://vim.1045645.n5.nabble.com/shiftround-option-td5712100.html
set shiftround

" Virtual edit is useful for visual block edit
set virtualedit=block

" Correctly break multi-byte characters such as CJK,
" see https://stackoverflow.com/q/32669814/6064933
set formatoptions+=mM

" Do not add two spaces after a period when joining lines or formatting texts,
" see https://stackoverflow.com/q/4760428/6064933
set nojoinspaces

" Text after this column number is not highlighted
set synmaxcol=200

set nostartofline

" Hide buffer when abandonned
set hid
" Show matching brackets
set showmatch

" Don't redraw when executing macros (good for small configs / max performance)
set lazyredraw

" External program to use for grep command
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
    set grepformat=%f:%l:%c:%m
endif
"}
