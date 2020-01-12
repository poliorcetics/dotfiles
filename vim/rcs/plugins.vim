if empty($DIRCONFIG)
  let $DIRCONFIG = ~/.config/
  silent !mkdir -p $DIRCONFIG
endif

" Put plugins here
call plug#begin($DIRCONFIG . "/vim/plugged")

Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-fugitive'
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
" Git gutter
""""

" Update time
set updatetime=100

let g:gitgutter_map_keys = 0
let g:gitgutter_enabled = 1
nnoremap <silent> <leader>d :GitGutterToggle<cr>

augroup git_gutter_conf
  autocmd!
  autocmd BufWritePost * GitGutter
augroup END

""""
" TagBar
""""

noremap <silent> <F12> :TagbarToggle<cr>
noremap <silent> <F11> :TagbarOpen fj<cr>
noremap <silent> <F10> :TagbarSetFoldlevel 99<cr>
noremap <silent> <F9> :TagbarSetFoldlevel 1<cr>
