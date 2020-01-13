if empty($DIRCONFIG)
  silent ! DIRCONFIG=$HOME/.config/ && export DIRCONFIG && mkdir -p $DIRCONFIG
endif

" Put plugins here
call plug#begin($DIRCONFIG . "/vim/plugged")

Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'airblade/vim-gitgutter'

" Tagbar needs universal-ctags: https://github.com/universal-ctags/ctags to work correctly
Plug 'majutsushi/tagbar'

Plug 'dense-analysis/ale'
" Integration between Lightline and ALE
Plug 'maximbaz/lightline-ale'

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status != 'unchanged' || a:info.force
    !./install.py --clang-completer --rust-completer
    YcmRestartServer
  endif
endfunction

Plug 'ycm-core/YouCompleteMe', { 'do': function('BuildYCM') }

Plug 'rust-lang/rust.vim'

Plug 'terryma/vim-multiple-cursors'
Plug 'cohama/lexima.vim'

call plug#end()
" Stop putting plugins here

""""
" ALE
""""

let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0

nmap <silent> <leader>a <Plug>(ale_next_wrap)

" You will need to enter a character after entering Insert mode to make it go aways
let g:ale_close_preview_on_insert = 1

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] [%severity%] %s'

let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_enter = 1

let g:ale_fixers = {'*': ['trim_whitespace', 'remove_trailing_lines']}
let g:ale_fix_on_save = 1

""""
" Lightline
""""

let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'active': {
  \    'left': [ [ 'mode', 'paste' ],
  \              [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
  \    'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings' ],
  \               [ 'percent', 'lineinfo' ],
  \               [ 'fileformat', 'fileencoding', 'filetype' ] ]
  \ },
  \ 'component_expand': {
  \    'linter_checking': 'lightline#ale#checking',
  \    'linter_warnings': 'lightline#ale#warnings',
  \    'linter_errors': 'lightline#ale#errors'
  \ },
  \ 'component': {
  \    'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
  \    'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
  \    'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}',
  \ },
  \ 'component_visible_condition': {
  \    'readonly': '(&filetype!="help"&& &readonly)',
  \    'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
  \    'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
  \ },
  \ 'component_type': {
  \    'linter_checking': 'left',
  \    'linter_warnings': 'warning',
  \    'linter_errors': 'error'
  \ },
  \ 'separator': { 'left': ' ', 'right': ' ' },
  \ 'subseparator': { 'left': ' ', 'right': ' ' }
  \ }

let g:lightline#ale#indicator_checking = "[L]"
let g:lightline#ale#indicator_warnings = "[W] "
let g:lightline#ale#indicator_errors = "[E] "

""""
" Gitgutter
""""

" Update time
set updatetime=100

let g:gitgutter_map_keys = 0
let g:gitgutter_enabled = 1

augroup git_gutter_conf
  autocmd!
  autocmd BufWritePost,InsertLeave * GitGutter
augroup END

noremap <leader>: :GitGutterNextHunk<cr>
noremap <leader>= :GitGutterPrevHunk<cr>

highlight GitGutterAdd ctermfg=2 ctermbg=233
highlight GitGutterChange ctermfg=3 ctermbg=233
highlight GitGutterDelete ctermfg=1 ctermbg=233
highlight GitGutterChangeDelete ctermfg=5 ctermbg=233

""""
" TagBar
""""

noremap <silent> <F12> :TagbarToggle<cr>
noremap <silent> <F11> :TagbarOpen fj<cr>
noremap <silent> <F10> :TagbarSetFoldlevel 99<cr>
noremap <silent> <F9> :TagbarSetFoldlevel 1<cr>

""""
" vim-markdown
""""

let g:markdown_fenced_languages = ['python', 'c', 'cpp', 'rust']

let g:markdown_syntax_conceal = 1
" Warning: may slow Vim, reduce as needed
let g:markdown_minlines = 100

""""
" rust
""""

let g:autofmt_autosave = 1
" See :h ale-integration-rust
let g:ale_linters = {'rust': ['rls', 'cargo', 'rustc', 'rustfmt']}

" https://github.com/majutsushi/tagbar/wiki#universal-ctags-variant
let g:rust_use_custom_ctags_defs = 1
let g:tagbar_type_rust = {
  \ 'ctagsbin' : 'ctags',
  \ 'ctagstype' : 'rust',
  \ 'kinds' : [
      \ 'n:modules',
      \ 's:structures:1',
      \ 'i:interfaces',
      \ 'c:implementations',
      \ 'f:functions:1',
      \ 'g:enumerations:1',
      \ 't:type aliases:1:0',
      \ 'v:constants:1:0',
      \ 'M:macros:1',
      \ 'm:fields:1:0',
      \ 'e:enum variants:1:0',
      \ 'P:methods:1',
  \ ],
  \ 'sro': '::',
  \ 'KIND2SCOPE' : {
      \ 'n': 'module',
      \ 's': 'struct',
      \ 'i': 'interface',
      \ 'c': 'implementation',
      \ 'f': 'function',
      \ 'g': 'enum',
      \ 't': 'typedef',
      \ 'v': 'variable',
      \ 'M': 'macro',
      \ 'm': 'field',
      \ 'e': 'enumerator',
      \ 'P': 'method',
  \ },
\ }

""""
" YouCompleteMe
""""

let g:ycm_complete_in_comments = 1
let g:ycm_use_ultisnips_completer = 0

" Preview window management
let g:ycm_add_preview_to_compleopt = 1
let g:ycm_autoclose_preview_window_after_completion = 2
" let g:ycm_autoclose_preview_window_after_insertion = 1

" let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
let g:ycm_key_list_stop_completion = ['<Left>', '<Right>']
let g:ycm_key_detailed_diagnostics = '<leader>d'

highlight Pmenu cterm=NONE ctermbg=182 ctermfg=234
highlight PmenuSel cterm=NONE ctermbg=176 ctermfg=232

""""
" Multiple cursors
""""

let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_start_word_key      = '<C-d>'
let g:multi_cursor_select_all_word_key = '<C-s>'
let g:multi_cursor_start_key           = 'g<C-d>'
let g:multi_cursor_select_all_key      = 'g<C-s>'
let g:multi_cursor_next_key            = '<C-d>'
let g:multi_cursor_prev_key            = '<C-q>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

highlight multiple_cursors_cursor cterm=NONE ctermfg=7 ctermbg=160
highlight multiple_cursors_visual cterm=NONE ctermfg=7 ctermbg=88

" https://github.com/terryma/vim-multiple-cursors#settings
" let g:multi_cursor_exit_from_insert_mode = 1

nnoremap <silent> <C-a> :MultipleCursorsFind <C-R>/<CR>
vnoremap <silent> <C-a> :MultipleCursorsFind <C-R>/<CR>

""""
" Lexima
""""

call lexima#add_rule({'char': '$', 'input_after': '$', 'filetype': 'latex'})
call lexima#add_rule({'char': '$', 'at': '\%#\$', 'leave': 1, 'filetype': 'latex'})
call lexima#add_rule({'char': '<BS>', 'at': '\$\%#\$', 'delete': 1, 'filetype': 'latex'})
