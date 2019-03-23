let s:gui = has('gui_running')

function! Bufferline()
  call bufferline#refresh_status()
  return [ g:bufferline_status_info.before, g:bufferline_status_info.current, g:bufferline_status_info.after]
endfunction

function! Timer()
  " return strftime("%H:%S")
  return strftime("%H:%M") . " (GMT)" "Timer in status line
  " return !date
endfunction

function! Fileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! Filetype()
  if expand('%:t') != ''
    return expand('%:t') . " "  " .  WebDevIconsGetFileTypeSymbol()
  else
    return ''
  endif
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' " . WebDevIconsGetFileTypeSymbol()  ''
endfunction

function! Filename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  return filename
endfunction

function! Fsize(f) abort
  let l:size = getfsize(expand(a:f))
  if l:size == 0 || l:size == -1 || l:size == -2
    return ''
  endif
  if l:size < 1024
    let size = l:size.' bytes'
  elseif l:size < 1024*1024
    let size = printf('%.1f', l:size/1024.0).'k'
  elseif l:size < 1024*1024*1024
    let size = printf('%.1f', l:size/1024.0/1024.0) . 'm'
  else
    let size = printf('%.1f', l:size/1024.0/1024.0/1024.0) . 'g'
  else
    let size = printf('%.1f', l:size/1024.0/1024.0/1024.0/1024.0) . 't'
  endif
  return '  '.size.' '
endfunction

function! BufnrWinnr() abort
  let l:bufnr = bufnr('%')
  if !s:gui
    function! s:circled_num(num) abort
      return nr2char(9311 + a:num)
    endfunction
    let l:bufnr = l:bufnr > 20 ? l:bufnr : s:circled_num(l:bufnr).' '
  endif
  return ' '.l:bufnr
endfunction

function! TotalBuf() abort
  return '[TOT:'.len(filter(range(1, bufnr('$')), 'buflisted(v:val)')).']'
endfunction


function! Paste() abort
  return &paste ? 'PASTE ' : ''
endfunction