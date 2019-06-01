let s:indicator_warnings = 'W: '
let s:indicator_errors = 'E: '
let s:indicator_ok = 'OK'
let s:indicator_checking = 'Linting...'
let s:indicator_notstarted = 'Starting...'
let s:current_buf_number = bufnr('%')
let s:qflist = getqflist()

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
if (LanguageClient_serverStatus() == 1)
  if !AleLinted()
    return ''
  endif
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:all_non_errors == 0 ? '' : printf(s:indicator_warnings . '%d', all_non_errors)
endif
  let l:current_buf_diagnostics = filter(s:qflist, {index, dict -> dict['bufnr'] == s:current_buf_number && dict['type'] == 'W'})
  let l:count = len(l:current_buf_diagnostics)
  return l:count > 0 && g:LanguageClient_loaded ? '' :  printf(s:indicator_warnings . " %d", l:count)
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
  let l:current_buf_diagnostics = filter(s:qflist, {index, dict -> dict['bufnr'] == s:current_buf_number && dict['type'] == 'E'})
  let l:count = len(l:current_buf_diagnostics)
  return l:count > 0 && g:LanguageClient_loaded ? '' :  printf(s:indicator_errors . " %d", l:count)
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

function!LinterChecking() abort
  return ale#engine#IsCheckingBuffer(bufnr('')) ? s:indicator_checking : ''
endfunction


function! LC_warning_count()
  let current_buf_number = bufnr('%')
  let qflist = getqflist()
  let current_buf_diagnostics = filter(qflist, {index, dict -> dict['bufnr'] == current_buf_number && dict['type'] == 'W'})
  let count = len(current_buf_diagnostics)
  return count > 0 && g:LanguageClient_loaded ? 'W: ' . count : ''
endfunction

function! LC_error_count()
  let current_buf_number = bufnr('%')
  let qflist = getqflist()
  let current_buf_diagnostics = filter(qflist, {index, dict -> dict['bufnr'] == current_buf_number && dict['type'] == 'E'})
  let count = len(current_buf_diagnostics)
  return count > 0 && g:LanguageClient_loaded ? 'E: ' . count : ''
endfunction
