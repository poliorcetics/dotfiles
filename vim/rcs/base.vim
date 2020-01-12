if empty($DIRCONFIG)
  let $DIRCONFIG = ~/.config/
  silent !mkdir -p $DIRCONFIG
endif

" History size for Vim
set history=500

""""
" Temp files
""""

let $vim_tmp_dir = $DIRCONFIG . "/vim/tmp"
let $vim_backup_dir = $vim_tmp_dir . "/backup"
let $vim_undo_dir = $vim_tmp_dir . "/undo"
let $vim_swap_dir = $vim_tmp_dir . "/swap"

if empty(glob($vim_backup_dir))
  silent !mkdir -p $vim_backup_dir
  silent !echo '!.gitignore' > $vim_backup_dir/.gitignore
endif

if empty(glob($vim_undo_dir))
  silent !mkdir -p $vim_undo_dir
  silent !echo '!.gitignore' > $vim_undo_dir/.gitignore
endif

if empty(glob($vim_swap_dir))
  silent !mkdir -p $vim_swap_dir
  silent !echo '!.gitignore' > $vim_swap_dir/.gitignore
endif

" Backup dirs
set nobackup
set writebackup
set backupdir=$vim_backup_dir/,/tmp
set backupskip=$vim_tmp_dir/*,/tmp/*

if has("mac")
  set backupdir+=/private/tmp/*
  set backupskip+=/private/tmp/*
endif

" List of directory names for the swap files
set directory=$vim_swap_dir/,/tmp

" Persitent undo means you can undo after closing a buffer/Vim
try
  set undodir=$vim_undo_dir/
  set undofile
catch
endtry

""""
" Mapleader
""""

" With a map leader it's possible to do more key combinations
let mapleader = ","

""""
" Saving files
""""

" Fast saving
nnoremap <leader>w :w!<cr>

" Sudo save
command W w !sudo tee % > /dev/null

""""
" Wildmenu
""""

set wildmenu
set wildchar=<tab>
set wildmode=longest:full,full

if has("mac")
  set wildignore+=*.DS_Store
endif

" Generic directories, language directories and files
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.vscode/*
set wildignore+=*/__pycache__/*
set wildignore+=*.swp,*.o,*.obj,*~,*.pyc

""""
" NetRW
""""

" Tree style
let g:netrw_liststyle = 3
let g:netrw_list_hide = "\.DS_Store$,\.Trash/$,\.localized$,\.Xauthority$,\.CFUserTextEncoding$,\.git/$,\.vscode/$"
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

nnoremap <leader>n :Explore<cr>
noremap <leader>; :Ntree<cr>

""""
" Colors
""""

syntax enable
let c_comment_strings = 1
set background=dark
set t_Co=256

try
  colorscheme desert
catch
endtry

try
  colorscheme peaksea
catch
endtry

""""
" Basic UI/UX improvements
""""

" Lines wrapping off
set nowrap
set formatoptions-=t

" Current position and line number
set ruler
set number
set relativenumber
set cursorline
set cursorlineopt=number,line
" If possible, keep a few lines below/above the cursor when moving with j/k or Up/Down at the edge of the screen
set scrolloff=5
set signcolumn=yes

" Line number
highlight LineNr ctermbg=233 ctermfg=181
highlight CursorLineNr cterm=NONE ctermbg=233 ctermfg=226

" Active parts
highlight clear CursorLine
highlight CursorLine ctermbg=236
highlight StatusLine cterm=NONE ctermbg=52 ctermfg=250
highlight! link TabLineSel StatusLine

" Inactive parts
highlight StatusLineNC cterm=NONE ctermbg=233 ctermfg=58
highlight! link TabLine StatusLineNC

" Fillers
highlight clear SignColum
highlight clear TabLineFill
highlight SignColumn ctermbg=233
highlight! link TabLineFill SignColumn

" Sepatator
highlight VertSplit cterm=NONE ctermbg=233 ctermfg=58

set splitright
set splitbelow

" Incomplete commands
set showcmd

set cmdheight=1
" Hide buffer when abandonned
set hid
" Show matching brackets
set showmatch

" Backspace configuration
set backspace=indent,eol,start
set whichwrap=<,>,[,]

" Smart search
set ignorecase
set smartcase
set hlsearch
set incsearch

" Magical regex
set magic

" Don't redraw when executing macros (good for small configs / max performance)
set lazyredraw

""""
" Status line
""""

" Always show the status line
set laststatus=2

" Format the status line (will be replaced by plugins if necessary)
set statusline=>\ MODE:\ \[%{mode()}\]\ \ \[%{getcwd()}\]\ \ %{HasPaste()}%F%m%r%h\ %w\ \ FT:\ %y\ \ Line:\ %l\ \ Column:\ %c
" Hide the '--INSERT--' and '--VISUAL--' indicators
set noshowmode

""""
" Vim Menu
""""

" Ensure English
set langmenu=en_EN
let $LANG = "en_GB"
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

""""
" Sounds
""""

" Disallow annoying sounds
set noerrorbells
set novisualbell
set t_vb=
set tm=500

""""
" Encoding
""""

set encoding=utf8
set ffs=unix,mac,dos

""""
" Reload buffer
""""

set autoread

augroup buf_autoread
  autocmd!
  " Trigger autoread when file changes on disk
  " https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
  autocmd! FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
  " Notification on file change
  " https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
  autocmd FileChangedShellPost * echohl WarningMsg | echo "Buffer changed!" | echohl None
augroup END

""""
" Tabs
""""

" Use spaces instead of tabs
set expandtab
set smarttab
" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

set linebreak

set autoindent
set smartindent
set wrap

""""
" Visual mode related
""""

" Visual mode pressing * searches for the current selection
"             pressing # launch a search and replace on it
" From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<cr>/<C-R>=@/<cr><cr>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<cr>:%s/<C-R>=@/<cr>//g

""""
" Search
""""

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
noremap <space> /
noremap <c-space> ?

" Disable highlight when <leader><cr> is pressed
noremap <silent> <leader><cr> :noh<cr>

""""
" Navigating windows, tabs and buffer
""""

" Fast config editing
noremap <leader>e :tabe! $DIRCONFIG/vim<cr>

" Smart way to move between windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

noremap <C-k> <C-w>j
noremap <C-i> <C-w>k
noremap <C-j> <C-w>h
noremap <C-l> <C-w>l

" Fast move
noremap <C-"> 5-
noremap <C-'> 5+

" Move to next {/}
noremap [[ ?{<cr>w99[{
noremap ][ /}<cr>b99]}
noremap ]] j0[[%/{<cr>
noremap [] k$][%?}<cr>

" Close the current buffer
noremap <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
noremap <leader>ba :bufdo bd<cr>

" List all the buffers
noremap <leader>bl :buffers<cr>

noremap <leader>l :bnext<cr>
noremap <leader>h :bprevious<cr>

" Useful mappings for managing tabs
noremap <silent> <leader><leader> :tabnext<cr>
noremap <silent> <leader>tn :tabnew<cr>
noremap <silent> <leader>to :tabonly<cr>
noremap <silent> <leader>tc :tabclose<cr>
noremap <leader>tm :tabmove
noremap <leader>tt :tabnext
noremap <leader>to :tabedit

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nnoremap <leader>tl :exe "tabn ".g:lasttab<cr>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
noremap <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
noremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

augroup buf_read_post
  autocmd!
  " Return to last edit position when opening files, except for commit files
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# "commit" | exe "normal! g'\"" | endif
augroup END

""""
" Editing
""""

if has("mac") || has("macunix")
  nmap <D-j> <A-j>
  nmap <D-k> <A-k>
  vmap <D-j> <A-j>
  vmap <D-k> <A-k>
endif

" Moving lines up/down in NORMAL mode
nnoremap <silent> <S-Up> :m .-2<cr>==
nnoremap <silent> <S-Down> :m .+1<cr>==

" In VISUAL mode
vnoremap <silent> <S-Up> :m '<-2<cr>gv=gv
vnoremap <silent> <S-Down> :m '>+1<cr>gv=gv

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
  let l:save_cursor = getpos(".")
  let l:old_query = getreg('/')
  silent! %s/\s\+$//e
  call setpos('.', l:save_cursor)
  call setreg('/', l:old_query)
endfun

augroup clean_spaces
  autocmd!
  autocmd BufWritePre *.txt,*.js,*.py,*.sh,*.c,*.cpp,*.h,*.hpp,*.swift,*.java,*.rs :call CleanExtraSpaces()
augroup END

""""
" Copy / Paste macOS
""""

if has("mac") || has("macunix")
    set clipboard=unnamed

    " Yank text to the OS X clipboard
    noremap <leader>y "*y
    noremap <leader>yy "*Y

    " Preserve indentation while pasting text from the OS X clipboard
    noremap <leader>p :set paste<cr>:put *<cr>:set nopaste<cr>
endif

""""
" Misc
""""

iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

if has("langmap") && exists("+langremap")
  set nolangremap
endif

" time out for key codes
set ttimeout
" wait up to 100ms after Esc for special key
set ttimeoutlen=100

""""
" Filetype detection
""""

filetype plugin indent on

""""
" New commands
""""

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
endif

""""
" Command mode
""""

" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>

""""
" Helper functions
""""

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
