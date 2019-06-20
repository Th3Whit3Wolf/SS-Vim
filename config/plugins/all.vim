set mouse=a " Enable mouse if possible

if dein#tap('tagbar')
	nnoremap <silent> <Leader>t :<C-u>TagbarOpenAutoClose<CR>
	" Also use h/l to open/close folds
	let g:tagbar_map_closefold = ['h', '-', 'zc']
	let g:tagbar_map_openfold = ['l', '+', 'zo']
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File Explorer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Defx Toggle
" if dein#tap('defx.nvim')
" 	nnoremap <silent> <Leader>f
" 		\ :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()`<CR>
" endif
"nnoremap <silent> <Leader>f :<C-u>Defx -resume -toggle -buffer-name=tab`tabpagenr()`<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File Explorer
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if dein#tap('vim-go')
	autocmd MyAutoCmd FileType go
		\   nmap <C-]> <Plug>(go-def)
		\ | nmap <Leader>god  <Plug>(go-describe)
		\ | nmap <Leader>goc  <Plug>(go-callees)
		\ | nmap <Leader>goC  <Plug>(go-callers)
		\ | nmap <Leader>goi  <Plug>(go-info)
		\ | nmap <Leader>gom  <Plug>(go-implements)
		\ | nmap <Leader>gos  <Plug>(go-callstack)
		\ | nmap <Leader>goe  <Plug>(go-referrers)
		\ | nmap <Leader>gor  <Plug>(go-run)
		\ | nmap <Leader>gov  <Plug>(go-vet)
endif


if dein#tap('open-browser.vim')
	nmap gx <Plug>(openbrowser-smart-search)
	vmap gx <Plug>(openbrowser-smart-search)
endif

if dein#tap('undotree')
	nnoremap <Leader>gu :UndotreeToggle<CR>
endif

if dein#tap('emmet-vim')
	autocmd MyAutoCmd FileType html,css,jsx,javascript,javascript.jsx
		\ EmmetInstall
		\ | imap <buffer> <C-Return> <Plug>(emmet-expand-abbr)
endif

if dein#tap('vim-operator-surround')
	map <silent>sa <Plug>(operator-surround-append)
	map <silent>sd <Plug>(operator-surround-delete)
	map <silent>sr <Plug>(operator-surround-replace)
endif

if dein#tap('fzf.vim')
  if executable('rg')
    set grepprg=rg\ -i\ --vimgrep

    " Ripgrep on /
    command! -nargs=+ -complete=file -bar Rg silent! grep! <args>|cwindow|redraw!
    nnoremap <leader>/ :Rg<SPACE>
  endif

  " FZF
  let g:fzf_command_prefix = 'Fzf'
  if executable('fzf')
    nnoremap <leader>v :FzfFiles<cr>
    nnoremap <leader>u :FzfTags<cr>
    nnoremap <leader>j :call fzf#vim#tags("'".expand('<cword>'))<cr>
    nnoremap <silent> <F12> :<C-u>Buffers<cr>

    if executable('rg')
      " :Find <term> runs `rg <term>` and passes it to fzf
      command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
      nnoremap <C-f> :Find
      nnoremap <leader>' :execute "Find " . expand("<cword>")<cr>
    endif
  else
    nnoremap <leader>v :CtrlP<Space><cr>
  endif

  " FZF
  if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --no-messages "" .'
    set grepprg=rg\ --vimgrep
  endif
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Async Test
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap  <buffer><F10> :call <SID>compile_and_run()<CR>
function! s:compile_and_run()
	let l:sleep = 5
    exec 'w'
    if &filetype == 'c'
      if executable('gcc')
        exec "AsyncRun! gcc % -o %<; time ./%<"
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      endif
		elseif &filetype == 'cpp'
      if executable('g++')
        exec "AsyncRun! g++ -std=c++17 % -o %<; time ./%<"
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      endif
		elseif &filetype == 'rust'
      if executable('cargo')
        exec "AsyncRun! cargo build; time cargo run"
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Rust is not installed!'
      endif
	elseif &filetype == 'java'
      if executable('javac')
        exec "AsyncRun! javac %; time java %<"
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Java is not installed!'
      endif
  elseif &filetype == 'sh'
    if getline(1)[0:18] ==# "#!/usr/bin/env bash" || getline(1)[0:14] ==# "#!/usr/bin/bash"
        if executable('bash')
          exec "AsyncRun! time bash %"
          exec 'sleep ' . l:sleep
          exec bufnr('$') . 'bw'
        else
          echo 'Bash is not installed!'
        endif
    elseif getline(1)[0:18] ==# "#!/usr/bin/env dash" || getline(1)[0:14] ==# "#!/usr/bin/dash"
      if executable('dash')
        exec "AsyncRun! time dash %"
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Dash is not installed!'
      endif
    elseif getline(1)[0:18] ==# "#!/usr/bin/env fish" || getline(1)[0:14] ==# "#!/usr/bin/fish"
      if executable('fish')
        exec "AsyncRun! time fish %"
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Fish is not installed!'
      endif
    elseif getline(1)[0:18] ==# "#!/usr/bin/env tcsh" || getline(1)[0:14] ==# "#!/usr/bin/tcsh"
      if executable('tcsh')
        exec "AsyncRun! time tcsh %"
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
        else
          echo 'Tcsh is not installed!'
      endif
    elseif getline(1)[0:17] ==# "#!/usr/bin/env csh" || getline(1)[0:13] ==# "#!/usr/bin/csh"
      if executable('csh')
        exec "AsyncRun! time csh %"
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Csh is not installed!'
      endif
    elseif getline(1)[0:17] ==# "#!/usr/bin/env ksh" || getline(1)[0:13] ==# "#!/usr/bin/ksh"
      if executable('ksh')
        exec "AsyncRun! time ksh %"
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Ksh is not installed!'
      endif
    elseif getline(1)[0:17] ==# "#!/usr/bin/env zsh" || getline(1)[0:13] ==# "#!/usr/bin/zsh"
      if executable('zsh')
        exec "AsyncRun! time zsh %"
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Zsh is not installed!'
      endif
    endif
  elseif &filetype == 'python'
    if getline(1)[0:21] ==# "#!/usr/bin/env python3" || getline(1)[0:17] ==# "#!/usr/bin/python3"
      if executable('python3')
			  exec "AsyncRun! time python3 %"
			  exec 'sleep ' . l:sleep
			  exec bufnr('$') . 'bw'
      else
        echo 'Python3 is not installed!'
      endif
    elseif getline(1)[0:21] ==# "#!/usr/bin/env python2" || getline(1)[0:17] ==# "#!/usr/bin/python2"
      if executable('python2')
        exec "AsyncRun! time python2 %"
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Python2 is not installed!'
      endif
    elseif getline(1)[0:20] ==# "#!/usr/bin/env python" || getline(1)[0:16] ==# "#!/usr/bin/python"
      if executable('python')
        exec "AsyncRun! time python %"
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Python executable can not be found!'
      endif
    elseif getline(1)[0:19] ==# "#!/usr/bin/env pypy3" || getline(1)[0:15] ==# "#!/usr/bin/pypy3"
      if executable('pypy3')
        exec "AsyncRun! time pypy3 %"
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Pypy3 is not installed!'
      endif
    elseif getline(1)[0:18] ==# "#!/usr/bin/env pypy" || getline(1)[0:14] ==# "#!/usr/bin/pypy"
      if executable('pypy')
        exec "AsyncRun! time pypy %"
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Pypy is not installed!'
      endif
    elseif getline(1)[0:20] ==# "#!/usr/bin/env jython" || getline(1)[0:16] ==# "#!/usr/bin/jython"
      if executable('jython')
        exec "AsyncRun! time jython %"
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Jython is not installed!'
      endif
    endif
  elseif &filetype == 'go'
    if executable('go')
      exec "AsyncRun! go build %; time ./%<"
      exec 'sleep ' . l:sleep
      exec bufnr('$') . 'bw'
    else
        echo 'Go is not installed!'
    endif
    elseif &filetype == 'haskell'
    if executable('ghc')
      exec "AsyncRun! ghc % -o %<; time ./%<"
      exec 'sleep ' . l:sleep
      exec bufnr('$') . 'bw'
    else
        echo 'Haskell is not installed!'
    endif
  endif
endfunction
let g:asyncrun_open = 12
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Async Compile
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F9> :call <SID>compile()<CR>
function! s:compile()
    exec 'w'
    if &filetype == 'c'
      if executable('gcc')
        exec "AsyncRun! gcc % -o %< -march=native -mtune=native -O2"
      endif
		elseif &filetype == 'cpp'
      if executable('g++')
        exec "AsyncRun! g++ -std=c++17 % -o %< -march=native -mtune=native -O2"
      endif
		elseif &filetype == 'rust'
    if executable('cargo')
      exec "AsyncRun! cargo build --release"
    else
      echo 'Rust is not installed!'
    endif
	elseif &filetype == 'java'
    if executable('javac')
      exec "AsyncRun! javac %"
    else
      echo 'Java is not installed!'
    endif
  elseif &filetype == 'go'
    if executable('go')
      exec "AsyncRun! go build %"
    else
      echo 'Go is not installed!'
    endif
    elseif &filetype == 'haskell'
    if executable('ghc')
      exec "AsyncRun! ghc % -o %<"
    else
     echo 'Haskell is not installed!'
    endif
  endif
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Shebang
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:shell_shebang()
  let options  = [
      \ 'bash',
      \ 'csh',
      \ 'dash',
      \ 'ksh',
      \ 'fish',
      \ 'tcsh',
      \ 'zsh',
      \ 'none'
      \ ]

  let choice = inputlist([ 'Select your shell:' ]
          \ + map(copy(options), '"[".(v:key+1)."] ".v:val'))

  if choice >= 1 && choice <= (len(copy(options)) - 2)
    0put = '#!/usr/bin/env ' . (options)[choice - 1]
	endif
endfunction

function! s:python_shebang()
	 if getline(1)[0:1] !=# "#!"
    let options  = [
        \ 'python2',
        \ 'python3',
        \ 'pypy',
        \ 'pypy3',
        \ 'jython',
        \ 'none'
        \ ]

    let choice = inputlist([ 'Select your shell:' ]
            \ + map(copy(options), '"[".(v:key+1)."] ".v:val'))

    if choice >= 1 && choice <= (len(copy(options)) - 2)
			0put = '#!/usr/bin/env ' . (options)[choice - 1]
    endif
	endif
endfunction

" Autoprompt Add Shebang
if has("autocmd")
	autocmd BufNewFile *.sh call <SID>shell_shebang()
  autocmd BufNewFile *.py call <SID>python_shebang()
 	autocmd BufNewFile *.rb 0put =\"#!/usr/bin/env ruby"
  autocmd BufNewFile *.pl 0put =\"#!/usr/bin/env perl"
	autocmd BufNewFile *.php 0put =\"#!/usr/bin/env php
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Change Shebang
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap  <buffer><F6> :call <SID>change_bang()<CR>
function! s:change_bang()
	if &filetype == 'shell'
   if getline(1)[0:1] !=# "#!"
    let shell_options  = [
        \ 'bash',
        \ 'csh',
        \ 'dash',
        \ 'ksh',
        \ 'fish',
        \ 'tcsh',
        \ 'zsh',
        \ 'none'
        \ ]

    let choice = inputlist([ 'Select your shell:' ]
            \ + map(copy(shell_options), '"[".(v:key+1)."] ".v:val'))

    if choice >= 1 && choice <= (len(copy(shell_options)) - 2)
			1d
			0put = '#!/usr/bin/env ' . (shell_options)[choice - 1]
      endif
    endif
	elseif &filetype == 'python'
   if getline(1)[0:1] !=# "#!"

    let python_options  = [
        \ 'python2',
        \ 'python3',
        \ 'pypy',
        \ 'pypy3',
        \ 'jython',
        \ 'none'
        \ ]

    let choice = inputlist([ 'Select your shell:' ]
            \ + map(copy(python_options), '"[".(v:key+1)."] ".v:val'))

    if choice >= 1 && choice <= (len(copy(python_options)) - 2)
			1d
			0put = '#!/usr/bin/env ' . (python_options)[choice - 1]
      endif
    endif
	endif
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Search
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ripgrep for search

""""""""""""""""""""""""""""""""""""""""
" Autocompletion
""""""""""""""""""""""""""""""""""""""""
set signcolumn=yes
set noinfercase
set complete=.,w,b,u,k
set completeopt=longest,menuone,noselect
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#chains = {
  \ 'default' : ['c-n', 'tags', 'dict', 'ulti', 'file', 'omni'],
  \ 'vim' : ['path', 'cmd', 'keyn'],
  \ }

let g:UltiSnipsExpandTrigger = "<f5>"        " Do not use <tab>
let g:UltiSnipsJumpForwardTrigger = "<c-b>" " Do not use <c-j>

let g:mucomplete#can_complete = {}
let g:mucomplete#completion_delay = 100
let g:mucomplete#reopen_immediately = 0
set shortmess+=c " Turn off completion messages
"setlocal omnifunc=LanguageClient#complete

let g:NERDTreeHijackNetrw = 1
execute 'source' fnameescape(resolve(expand($VIMPATH.'/config/plugins/checker.vim')))

" specify browser to open preview page
" default: ''
" specify browser to open preview page
" default: ''
" if executable('surfer')
""  let g:mkdp_browser = 'surfer'
" elseif executable('firefox-developer-edition')
""  let g:mkdp_browser = 'firefox-developer-edition'
" endif


if executable('surfer')
  let g:mkdp_browser = 'surfer'
endif

let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1
    \ }

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 1

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" use a custom markdown style must be absolute path
let g:mkdp_markdown_css = $TMPPATH.'/misc/markdown.css'

" use a custom highlight style must absolute path
let g:mkdp_highlight_css = $TMPPATH.'/misc/highlight.css'


let g:mkdp_page_title = '「${name}」'