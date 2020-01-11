if empty($DIRCONFIG)
  let $DIRCONFIG = ~/.config/
  silent !mkdir -p $DIRCONFIG
endif

" Put plugins here
call plug#begin($DIRCONFIG . "/vim/plugged")

Plug 'itchyny/lightline.vim'
"Plug 'maximbaz/lightline-ale'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

call plug#end()
" Stop putting plugins here

""""
" Lightline
""""

let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \    'left': [ [ 'mode', 'paste' ],
  \              [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
  \    'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings' ],
  \               [ 'percent', 'lineinfo' ],
  \               [ 'fileformat', 'fileencoding', 'filetype' ] ]
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
" To insert before 'component_type' if wanted
"  \ 'component_expand': {
"  \    'linter_checking': 'lightline#ale#checking',
"  \    'linter_warnings': 'lightline#ale#warnings',
"  \    'linter_errors': 'lightline#ale#errors'
"  \ },
" Uncomment to make the above work if needed
" let g:lightline#ale#indicator_checking = "[L]"
" let g:lightline#ale#indicator_warnings = "[W] "
" let g:lightline#ale#indicator_errors = "[E] "


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
