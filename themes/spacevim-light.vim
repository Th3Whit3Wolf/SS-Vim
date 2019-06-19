set showbreak=↪
set fillchars=vert:│,fold:─
set listchars=tab:\▏\ ,extends:⟫,precedes:⟪,nbsp:␣,trail:·

colorscheme space-vim-dark
execute 'source' fnameescape(resolve(expand($VIMPATH.'/config/plugins/checker.vim')))
execute 'source' fnameescape(resolve(expand($VIMPATH.'/themes/statusline/linters.vim')))
execute 'source' fnameescape(resolve(expand($VIMPATH.'/themes/statusline/git.vim')))
execute 'source' fnameescape(resolve(expand($VIMPATH.'/themes/statusline/misc.vim')))

function! LightlineMode()
  return expand('%:t') ==# '__Tagbar__' ? 'Tagbar':
        \ expand('%:t') ==# 'ControlP' ? 'CtrlP' :
        \ &filetype ==# 'unite' ? 'Unite' :
        \ &filetype ==# 'vimfiler' ? 'VimFiler' :
        \ &filetype ==# 'vimshell' ? 'VimShell' :
        \ &filetype ==# 'defx' ? 'Defx' :
        \ lightline#mode()
endfunction

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! MaybeUpdateLightline()
  if exists('#lightline')
    call g:GitBranch(1)
    call lightline#update()
  end
endfunction

let g:lightline =
  \{
  \ 'colorscheme': 'spacemacs',
  \ 'active': {
  \   'left': [ ['bn', 'mode', 'paste'],
  \             ['git', 'readonly', 'filename'] ],
  \   'right': [ ['time', 'lineinfo', 'percent','fileformat'],
  \             ['linter_checking', 'linter_warnings', 'linter_errors', 'linter_ok']]
  \ },
  \ 'inactive': {
  \   'left': [ [ 'filename' ] ],
  \   'right': [ [ 'lineinfo' ], [ 'percent' ] ]
  \ },
  \ 'tabline': {
  \   'left': [ [ 'bn', 'tabs', 'tablinesep', 'bufferline'] ],
  \   'right': [ [ 'folder' ] ]
  \ },
  \ 'tab': {
  \   'active': [ '' ],
  \   'inactive': [ '' ]
  \ },
  \ 'component': {
  \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
  \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
  \   'lineinfo': ' %3l:%-2v',
  \ },
  \ 'component_function': {
  \   'bn': 'BufnrWinnr',
  \   'time': 'Timer',
  \   'git': 'GitBranch',
  \   'mode': 'LightlineMode',
  \   'filename': 'Filename',
  \   'fileformat': 'Fileformat',
  \   'filetype': 'Filetype',
  \ },
  \ 'component_type': {
  \   'readonly': 'error',
  \   'linter_checking': 'left',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'bufferline': 'bufsel',
  \   'tablinesep': 'tabsep'
  \ },
  \ 'component_expand': {
  \  'linter_checking': 'LinterChecking',
  \  'linter_warnings': 'LinterWarnings',
  \  'linter_errors': 'LinterErrors',
  \  'linter_ok': 'LinterOK',
  \  'bufferline': 'MyBufferline',
  \  'tablinesep': 'MyTablineSep'
  \ },
  \ 'component_visible_condition': {
  \   'readonly': '(&filetype!="help"&& &readonly)',
  \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '>', 'right': '<' }
  \ }
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other Settings:
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:MyFavIcons = "⚡"
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: Tagbar icons
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tagbar_width = 28
let g:tagbar_iconchars = ['↠', '↡']
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: GitGutter icons
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▋'
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: vim-gitgutter
""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight! GitGutterAdd ctermfg=22 guifg=#006000 ctermbg=NONE guibg=NONE
highlight! GitGutterChange ctermfg=58 guifg=#5F6000 ctermbg=NONE guibg=NONE
highlight! GitGutterDelete ctermfg=52 guifg=#600000 ctermbg=NONE guibg=NONE
highlight! GitGutterChangeDelete ctermfg=52 guifg=#600000 ctermbg=NONE guibg=NONE
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto Update Lightline when not in goyo
""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup LightLine_Linter
  autocmd!
  autocmd BufEnter * call MaybeUpdateLightline()
  autocmd User LanguageClientDiagnosticsChanged call MaybeUpdateLightline()
  autocmd User LanguageClientStarted call LspStarted()
  autocmd User LanguageClientStopped call LspStopped()
  autocmd User ALEFixPre   call MaybeUpdateLightline()
  autocmd User ALEFixPost  call MaybeUpdateLightline()
  autocmd User ALELintPre  call MaybeUpdateLightline()
  autocmd User ALELintPost call MaybeUpdateLightline()
  autocmd User GitGutter,Startified,LanguageClientStarted call MaybeUpdateLightline()
  autocmd BufWinEnter,ShellCmdPost,BufWritePost * call MaybeUpdateLightline()
  autocmd FileChangedShellPost,ColorScheme * call MaybeUpdateLightline()
  autocmd FileReadPre,ShellCmdPost,FileWritePost * call MaybeUpdateLightline()
augroup end
