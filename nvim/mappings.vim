"{ Custom key mappings
" NetRW
nnoremap <leader>n :Explore<cr>

" Trigger completion with <tab>
" found in :help completion
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
 
" inoremap <silent><expr> <TAB>
"     \ pumvisible() ? "\<C-n>" :
"     \ <SID>check_back_space() ? "\<TAB>" :
"     \ completion#trigger_completion()

" Quicker <Esc>
noremap ùù <Esc>

" Paste non-linewise text above or below current cursor,
" see https://stackoverflow.com/a/1346777/6064933
nnoremap <leader>p m`o<ESC>p``
nnoremap <leader>P m`O<ESC>p``

" Shortcut for faster save and quit
nnoremap <silent> <leader>w :update<cr>:w!<cr>
" Saves the file if modified and quit
nnoremap <silent> <leader>q :x<cr>

" Navigation in the location and quickfix list
nnoremap <silent> <F9> :lprevious<cr>zv
nnoremap <silent> <F10> :lnext<cr>zv
nnoremap <silent> <F11> :lfirst<cr>zv
nnoremap <silent> <F12> :llast<cr>zv
nnoremap <silent> <F5> :cprevious<cr>zv
nnoremap <silent> <F6> :cnext<cr>zv
nnoremap <silent> <F7> :cfirst<cr>zv
nnoremap <silent> <F8> :clast<cr>zv

" Insert a blank line below or above current line (do not move the cursor),
" see https://stackoverflow.com/a/16136133/6064933
nnoremap <expr> oo 'm`' . v:count1 . 'o<Esc>``'
nnoremap <expr> OO 'm`' . v:count1 . 'O<Esc>``'

" Insert a space after current character
nnoremap <Space><Space> a<Space><ESC>h

" Yank from current cursor position to the end of the line (make it
" consistent with the behavior of D, C)
nnoremap Y y$

" Do not include white space characters when using $ in visual mode,
" see https://vi.stackexchange.com/q/12607/15292
xnoremap $ g_

" Jump to matching pairs easily in normal mode
nnoremap <Tab> %

" Close current fold
nnoremap <leader>f :foldclose<cr>

" Continuous visual shifting (does not exit Visual mode), `gv` means
" to reselect previous visual area, see https://superuser.com/q/310417/736190
xnoremap < <gv
xnoremap > >gv

" When completion menu is shown, use <cr> to select an item and do not add an
" annoying newline. Otherwise, <enter> is what it is. For more info , see
" https://superuser.com/a/941082/736190 and
" https://unix.stackexchange.com/q/162528/221410
inoremap <expr> <cr> ((pumvisible())?("\<C-Y>"):("\<cr>"))
" Use <esc> to close auto-completion menu
inoremap <expr> <esc> ((pumvisible())?("\<C-e>"):("\<esc>"))

" Edit and reload init.vim quickly
nnoremap <silent> <leader>ev :tabnew $MYVIMRC <bar> tcd %:h<cr>
nnoremap <silent> <leader>sv :silent update $MYVIMRC <bar> source $MYVIMRC <bar>
    \ echomsg "Nvim config successfully reloaded!"<cr>

" Reselect the text that has just been pasted
nnoremap <leader>v `[V`]

" Search in selected region
vnoremap / :<C-U>call feedkeys('/\%>'.(line("'<")-1).'l\%<'.(line("'>")+1)."l")<cr>

" Change current working directory locally and print cwd after that,
" see https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
nnoremap <silent> <leader>cd :lcd %:p:h<cr>:pwd<cr>

" Use Esc to quit builtin terminal
tnoremap <ESC> <C-\><C-n>

" Decrease indent level in insert mode with shift+tab
inoremap <S-Tab> <ESC><<i

" Change text without putting it into the vim register,
" see https://stackoverflow.com/q/54255/6064933
nnoremap c "_c
nnoremap C "_C
nnoremap cc "_cc

" Remove trailing whitespace characters
nnoremap <silent> <leader><Space> :call utils#StripTrailingWhitespaces()<cr>

" check the syntax group of current cursor position
nnoremap <silent> <leader>st :call utils#SynGroup()<cr>

" Clear highlighting
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<cr><cr><C-L>

" Copy entire buffer.
nnoremap <silent> <leader>y :%y<cr>

" Visual mode pressing * searches for the current selection
"             pressing # launch a search and replace on it
" From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call utils#VisualSelection('', '')<cr>/<C-R>=@/<cr><cr>
vnoremap <silent> # :<C-u>call utils#VisualSelection('', '')<cr>:%s/<C-R>=@/<cr>//g

" Close the current buffer
noremap <leader>bd :bdel<cr>:tabclose<cr>gT
noremap <leader>bc :bdel<cr>

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

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nnoremap <leader>tl :exe "tabn ".g:lasttab<cr>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
noremap <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Moving lines up/down in NORMAL mode
nnoremap <silent> <S-Up> :m .-2<cr>==
nnoremap <silent> <S-Down> :m .+1<cr>==

" In VISUAL mode
vnoremap <silent> <S-Up> :m '<-2<cr>gv=gv
vnoremap <silent> <S-Down> :m '>+1<cr>gv=gv
"}
