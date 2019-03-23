set showbreak=↪
set fillchars=vert:│,fold:─
set listchars=tab:\▏\ ,extends:⟫,precedes:⟪,nbsp:␣,trail:·

"call dein#add('itchyny/lightline.vim')
"call dein#add('FriedPandaFries/Lightline-Extras')


colorscheme space-vim-dark

"github.com/ajmwagar/vimkampf

function! LightlineBufferline()
  call bufferline#refresh_status()
  return [ g:bufferline_status_info.before, g:bufferline_status_info.current, g:bufferline_status_info.after]
endfunction

function! Timer()
  " return strftime("%H:%S")
  return strftime("%H:%M") . " (GMT)" "Timer in status line
  " return !date
endfunction

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
  if expand('%:t') != ''
    return expand('%:t') . " "  " .  WebDevIconsGetFileTypeSymbol()
  else
    return ''
  endif
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' " . WebDevIconsGetFileTypeSymbol()  ''
endfunction

function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? ' +' : ''
  return filename . modified
endfunction




" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction

augroup LightLineOnALE
  autocmd!
  autocmd User ALEFixPre   call MaybeUpdateLightline()
  autocmd User ALEFixPost  call MaybeUpdateLightline()
  autocmd User ALELintPre  call MaybeUpdateLightline()
  autocmd User ALELintPost call MaybeUpdateLightline()
augroup end

" autocmd User ALELint call MaybeUpdateLightline()
autocmd User LanguageClientDiagnosticsChanged call MaybeUpdateLightline()
autocmd User LanguageClientStarted call LspStarted()
autocmd User LanguageClientStopped call LspStopped()
" autocmd User ALEJobStarted call MaybeUpdateLightline()
" autocmd User ALELintPost call MaybeUpdateLightline()
" autocmd User ALEFixPost call MaybeUpdateLightline()

let s:indicator_warnings = 'W: '
let s:indicator_errors = 'E: '
let s:indicator_ok = 'OK'
let s:indicator_checking = 'Linting...'
let s:indicator_notstarted = 'Starting...'

let g:language_client_started = 0

function! LspStarted() abort
  let g:language_client_started = 1
  call lightline#update()
endfunction

function! LspStopped() abort
  let g:language_client_started = 0
  call lightline#update()
endfunction

function! LsNotStarted() abort
  return (g:language_client_started == 0) ? s:indicator_notstarted : ''
endfunction

function! AleLinted() abort
  return get(g:, 'ale_enabled', 0) == 1
    \ && getbufvar(bufnr(''), 'ale_linted', 0) > 0
    \ && ale#engine#IsCheckingBuffer(bufnr('')) == 0
endfunction

function LightlineLinterWarnings() abort
  if !AleLinted()
    return ''
  endif
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:all_non_errors == 0 ? '' : printf(s:indicator_warnings . '%d', all_non_errors)
endfunction

function LightlineLinterErrors() abort
if (LanguageClient_serverStatus() == 1)
    if !AleLinted()
      return ''
    endif
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    return l:all_errors == 0 ? '' : printf(s:indicator_errors . '%d', all_errors)
  endif
  let l:error_no = len(getqflist())
  return l:error_no == 0 ? '' : printf(s:indicator_errors . " %d", error_no)
endfunction

function LightlineLinterOK() abort
  if (LanguageClient_serverStatus() == 1) || (g:language_client_started == 0)
    if !lightline#ale#linted()
      return ''
    endif
    let l:counts = ale#statusline#Count(bufnr(''))
    return l:counts.total == 0 ? s:indicator_ok : ''
  endif
  let l:error_no = len(getqflist())
  return l:error_no == 0 ? s:indicator_ok : ''
endfunction

function! LightlineLinterChecking() abort
  return ale#engine#IsCheckingBuffer(bufnr('')) ? s:indicator_checking : ''
endfunction


let g:lightline =
  \{
  \ 'colorscheme': 'evil',
  \ 'active': {
  \   'left': [ ['mode', 'paste'],
  \             ['gitbranch', 'readonly', 'filename', 'modified'] ],
  \   'right': [ ['time', 'lineinfo', 'filetype', 'percent','fileformat'],
  \             ['linter_checking', 'linter_warnings', 'linter_errors', 'linter_ok'] ]
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
  \   'time': 'Timer',
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
  \  'linter_checking': 'LightlineLinterChecking',
  \  'linter_warnings': 'LightlineLinterWarnings',
  \  'linter_errors': 'LightlineLinterErrors',
  \  'linter_ok': 'LightlineLinterOK',
  \  'bufferline': 'MyBufferline',
  \  'tablinesep': 'MyTablineSep'
  \ },
  \ 'component_visible_condition': {
  \   'readonly': '(&filetype!="help"&& &readonly)',
  \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
  \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' }
  \ }
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Linter Specific Settings:
""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nmap <silent> <C-k> <Plug>(ale_previous_wrap)
"nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
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
