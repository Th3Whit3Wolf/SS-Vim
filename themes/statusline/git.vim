let s:font = 1
let s:gui = has('gui_running')
let s:jobs = {}

function! s:is_tmp_file() abort
  if !empty(&buftype) | return 1 | endif
  if index(['startify', 'gitcommit'], &filetype) > -1 | return 1 | endif
  if expand('%:p') =~# '^/tmp' | return 1 | endif
endfunction

" Reference: https://github.com/chemzqm/vimrc/blob/master/statusline.vim
function! g:GitBranch(...) abort
  let s:status = GitStatus()
  if s:is_tmp_file() | return '' | endif
  let reload = get(a:, 1, 0) == 1
  if exists('b:branch') && !reload | return b:branch.s:status  | endif
  if !exists('*FugitiveExtractGitDir') | return '' | endif
  let roots = values(s:jobs)
  let dir = get(b:, 'git_dir', FugitiveExtractGitDir(resolve(expand('%:p'))))
  if empty(dir) | return '' | endif
  let b:git_dir = dir
  let root = fnamemodify(dir, ':h')
  if index(roots, root) >= 0 | return '' | endif

  let argv = add(has('win32') ? ['cmd', '/c']: ['bash', '-c'], 'git branch')
  if exists('*job_start')
    let job = job_start(argv, {'out_io': 'pipe', 'err_io':'null',  'out_cb': function('s:out_cb')})
    if job_status(job) == 'fail' | return '' | endif
    let s:cwd = root
    let job_id = matchstr(job, '\d\+')
    let s:jobs[job_id] = root
  elseif exists('*jobstart')
    let job_id = jobstart(argv, {
      \ 'cwd': root,
      \ 'stdout_buffered': v:true,
      \ 'stderr_buffered': v:true,
      \ 'on_exit': function('s:on_exit')
      \})
    if job_id == 0 || job_id == -1 | return '' | endif
    let s:jobs[job_id] = root
  elseif exists('g:loaded_fugitive')
    let l:head = fugitive#head()
    let l:symbol = s:font ? " \ue0a0 " : ' Git:'
    return empty(l:head) ? '' : l:symbol.l:head . s:status
  endif

  return ''
endfunction

function! s:out_cb(channel, message) abort
  if a:message =~ "^* "
    let l:job = ch_getjob(a:channel)
    let l:job_id = matchstr(string(l:job), '\d\+')
    if !has_key(s:jobs, l:job_id) | return | endif
    let l:branch = substitute(a:message, '*', s:font ? "  \ue0a0" : '  Git:', '')
    call s:SetGitBranch(s:cwd, l:branch)
    call remove(s:jobs, l:job_id)
  endif
endfunction

function! s:on_exit(job_id, data, _event) dict abort
  if !has_key(s:jobs, a:job_id) | return | endif
  if v:dying | return | endif
  let l:cur_branch = join(filter(self.stdout, 'v:val =~ "*"'))
  if !empty(l:cur_branch)
    let l:branch = substitute(l:cur_branch, '*', s:font ? "  \ue0a0" : '  Git:', '')
    call s:SetGitBranch(self.cwd, l:branch.' ')
  else
    let err = join(self.stderr)
    if !empty(err) | echoerr err | endif
  endif
  call remove(s:jobs, a:job_id)
endfunction

function! s:SetGitBranch(root, str) abort
  let buf_list = filter(range(1, bufnr('$')), 'bufexists(v:val)')
  let root = a:root
  for nr in buf_list
    let path = fnamemodify(bufname(nr), ':p')
    if has('win32')
      let path = substitute(path, '\', '/', 'g')
      let root = substitute(root, '\', '/', 'g')
    endif
    if match(path, a:root) >= 0
      call setbufvar(nr, 'branch', a:str)
    endif
  endfor
endfunction

function! g:GitStatus() abort
  let l:summary = [0, 0, 0]
  if exists('b:sy')
    let l:summary = b:sy.stats
  elseif exists('b:gitgutter.summary')
    let l:summary = b:gitgutter.summary
  endif
  if max(l:summary) > 0
    return ' +'.l:summary[0].' ~'.l:summary[1].' -'.l:summary[2].' '
  endif
  return ''
endfunction
