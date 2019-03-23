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

function! AleLinted() abort
  return get(g:, 'ale_enabled', 0) == 1
    \ && getbufvar(bufnr(''), 'ale_linted', 0) > 0
    \ && ale#engine#IsCheckingBuffer(bufnr('')) == 0
endfunction

function! LinterWarnings() abort
    if !AleLinted()
    return ''
  endif
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:all_non_errors == 0 ? '' : printf(s:indicator_warnings . '%d', all_non_errors)
endfunction

function! LinterErrors() abort
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

function! LinterOK() abort
  if (LanguageClient_serverStatus() == 1) || (g:language_client_started == 0)
    if !lightline#ale#linted()
      return ''
    endif
    let l:error_no = len(getqflist())
  return l:error_no == 0 ? s:indicator_ok : '
  endif
endfunction

" Old Neovim Lsp
" let l:error_no = len(getqflist())
" return l:error_no == 0 ? '' : printf(s:indicator_errors . " %d", error_no)

function!LinterChecking() abort
  return ale#engine#IsCheckingBuffer(bufnr('')) ? s:indicator_checking : ''
endfunction
