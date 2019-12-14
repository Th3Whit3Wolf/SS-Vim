color space-vim-dark
set termguicolors
hi Normal     ctermbg=NONE guibg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
set encoding=UTF-8
set mouse=a " Enable mouse if possible

let g:spaceline_colorscheme = 'space'
let g:spaceline_line_symbol = 0
let g:spaceline_seperate_style= 'slant'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Goyo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable visual candy in Goyo mode
function! s:goyo_enter()
	if has('gui_running')
		" Gui fullscreen
		set fullscreen
		set background=light
		set linespace=7
	elseif exists('$TMUX')
		" Hide tmux status
		silent !tmux set status off
	endif

	" Activate Limelight
	Limelight
endfunction

" s:goyo_leave()
" Enable visuals when leaving Goyo mode
function! s:goyo_leave()
	if has('gui_running')
		" Gui exit fullscreen
		set nofullscreen
		set background=dark
		set linespace=0
	elseif exists('$TMUX')
		" Show tmux status
		silent !tmux set status on
	endif

	" De-activate Limelight
	Limelight!
endfunction

" Goyo Commands
autocmd  User GoyoEnter call <SID>goyo_enter()
autocmd  User GoyoLeave call <SID>goyo_leave()

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
" => Sk | Fuzzing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let $SKIM_DEFAULT_COMMAND = "rg --files || fd ."
let $SKIM_DEFAULT_COMMAND = "fd --type f || rg --files"