set showbreak=↪
set fillchars=vert:│,fold:─
set listchars=tab:\▏\ ,extends:⟫,precedes:⟪,nbsp:␣,trail:·

colorscheme space-vim-dark


function! LightlineMode()
  return expand('%:t') ==# '__Tagbar__' ? 'Tagbar':
        \ expand('%:t') ==# 'ControlP' ? 'CtrlP' :
        \ &filetype ==# 'unite' ? 'Unite' :
        \ &filetype ==# 'vimfiler' ? 'VimFiler' :
        \ &filetype ==# 'vimshell' ? 'VimShell' :
        \ &filetype ==# 'defx' ? 'Defx' :
        \ lightline#mode()
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction

let g:lightline =
  \{
  \ 'colorscheme': 'evil',
  \ 'active': {
  \   'left': [ ['mode', 'paste'],
  \             ['gitbranch', 'readonly', 'filename', 'modified'] ],
  \   'right': [['lineinfo'], ['percent'], ['fileformat', 'filetype' , 'linter_checking', 'linter_warnings', 'linter_errors', 'linter_ok' ] ]
  \ },
  \ 'inactive': {
  \   'left': [ [ 'filename' ] ],
  \   'right': [ [ 'lineinfo' ], [ 'percent' ] ]
  \ },
  \ 'tabline': {
  \   'left': [ [ 'tabs', 'tablinesep', 'bufferline'] ],
  \   'right': [ [ 'folder' ] ]
  \ },
  \ 'tab': {
  \   'active': [ 'tabnum' ],
  \   'inactive': [ 'tabnum' ]
  \ },
  \ 'component': {
  \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
  \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
  \   'lineinfo': ' %3l:%-2v',
  \ },
  \ 'component_function': {
  \   'gitbranch': 'fugitive#head',
  \   'mode': 'LightlineMode',
  \   'filename': 'LightlineFilename',
  \   'fileformat': 'LightlineFileformat',
  \   'filetype': 'LightlineFiletype',
  \ },
  \ 'component_type': {
  \   'readonly': 'error',
  \   'linter_checking': 'left',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'left',
  \   'bufferline': 'bufsel',
  \   'tablinesep': 'tabsep'
  \ },
  \ 'component_expand': {
  \  'linter_checking': 'lightline#lsc#checking',
  \  'linter_warnings': 'lightline#lsc#warnings',
  \  'linter_errors': 'lightline#lsc#errors',
  \  'linter_ok': 'lightline#lsc#ok',
  \   'bufferline': 'MyBufferline',
  \   'tablinesep': 'MyTablineSep'
  \ },
  \ 'component_visible_condition': {
  \   'readonly': '(&filetype!="help"&& &readonly)',
  \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
  \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' }
  \ }


let g:lightline#lsc#indicator_checking = "\uf110"
let g:lightline#lsc#indicator_notstarted = "\ufbab"
let g:lightline#lsc#indicator_errors = "\uf05e"
let g:lightline#lsc#indicator_ok = "✓"
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: Tagbar icons {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tagbar_width = 28
let g:tagbar_iconchars = ['↠', '↡']
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: GitGutter icons {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▋'
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: vim-gitgutter {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight! GitGutterAdd ctermfg=22 guifg=#006000 ctermbg=NONE guibg=NONE
highlight! GitGutterChange ctermfg=58 guifg=#5F6000 ctermbg=NONE guibg=NONE
highlight! GitGutterDelete ctermfg=52 guifg=#600000 ctermbg=NONE guibg=NONE
highlight! GitGutterChangeDelete ctermfg=52 guifg=#600000 ctermbg=NONE guibg=NONE
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: vim-operator-flashy {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight! link Flashy DiffText

" Plugin: vim-bookmarks {{{
let g:bookmark_sign = '⚐'
highlight! BookmarkSign            ctermfg=12 guifg=#4EA9D7
highlight! BookmarkAnnotationSign  ctermfg=11 guifg=#EACF49
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: vim-choosewin {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:choosewin_label = 'SDFJKLZXCV'
let g:choosewin_overlay_enable = 1
let g:choosewin_statusline_replace = 1
let g:choosewin_overlay_clear_multibyte = 0
let g:choosewin_blink_on_land = 0

let g:choosewin_color_label = {
	\ 'cterm': [ 236, 2 ], 'gui': [ '#555555', '#000000' ] }
let g:choosewin_color_label_current = {
	\ 'cterm': [ 234, 220 ], 'gui': [ '#333333', '#000000' ] }
let g:choosewin_color_other = {
	\ 'cterm': [ 235, 235 ], 'gui': [ '#333333' ] }
let g:choosewin_color_overlay = {
	\ 'cterm': [ 2, 10 ], 'gui': [ '#88A2A4' ] }
let g:choosewin_color_overlay_current = {
	\ 'cterm': [ 72, 64 ], 'gui': [ '#7BB292' ] }
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: Defx {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:defx_git#indicators = {
	\ 'Modified'  : 'M',
	\ 'Staged'    : 'm',
	\ 'Untracked' : '?',
	\ 'Renamed'   : '≫',
	\ 'Unmerged'  : 'u',
	\ 'Ignored'   : 'i',
	\ 'Deleted'   : '✖',
	\ 'Unknown'   : '⁇'
	\ }

let g:defx_icons_enable_syntax_highlight = 1
let g:defx_icons_column_length = 2
let g:defx_icons_directory_icon = ''
let g:defx_icons_mark_icon = '*'
let g:defx_icons_parent_icon = ''
let g:defx_icons_default_icon = ''
let g:defx_icons_directory_symlink_icon = ''

hi Defx_git_Untracked guibg=NONE guifg=NONE ctermbg=NONE ctermfg=NONE
hi Defx_git_Ignored guibg=NONE guifg=NONE ctermbg=NONE ctermfg=NONE
hi Defx_git_Unknown guibg=NONE guifg=NONE ctermbg=NONE ctermfg=NONE
hi Defx_git_Renamed ctermfg=214 guifg=#fabd2f
hi Defx_git_Modified ctermfg=214 guifg=#fabd2f
hi Defx_git_Unmerged ctermfg=167 guifg=#fb4934
hi Defx_git_Deleted ctermfg=167 guifg=#fb4934
hi Defx_git_Staged ctermfg=142 guifg=#b8bb26

hi Defx_git_Untracked ctermfg=12 guifg=#81a2be
hi Defx_git_Ignored   ctermfg=8  guifg=#404660
hi Defx_git_Unknown   ctermfg=3  guifg=#f0c674
hi Defx_git_Renamed   ctermfg=3  guifg=#de935f
hi Defx_git_Modified  ctermfg=9  guifg=#cc6666
hi Defx_git_Unmerged  ctermfg=14 guifg=#8abeb7
hi Defx_git_Deleted   ctermfg=13 guifg=#b294bb
hi Defx_git_Staged    ctermfg=10 guifg=#b5bd68