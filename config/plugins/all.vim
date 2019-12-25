"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Apperance
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
color space-vim-dark
set termguicolors
hi Normal     ctermbg=NONE guibg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
set encoding=UTF-8
set mouse=a " Enable mouse if possible
let g:spaceline_colorscheme = 'space'
let g:spaceline_seperate_style= 'arrow-fade'
" or link it to another highlight group
highlight link Crates Comment
" vim-buffet
function! g:BuffetSetCustomColors()
    hi! BuffetCurrentBuffer guibg=#5d4d7a guifg=#cbc1d5 " cterm=NONE ctermbg=106 ctermfg=8
    hi! BuffetTrunc cterm=bold guibg=#5d4d7a guifg=#5d4d7a " ctermbg=66 ctermfg=8 
    hi! BuffetBuffer cterm=NONE guibg=#212026 guifg=#64606b " ctermbg=239 ctermfg=8 guibg=#504945 guifg=#000000
    hi! BuffetTab cterm=NONE guibg=#212026 guifg=#5d4d7a " ctermbg=66 ctermfg=8 guibg=#458588 guifg=#000000
    hi! BuffetActiveBuffer cterm=NONE guibg=#21206 guifg=#5d4d7a " ctermbg=10 ctermfg=239 guibg=#999999 guifg=#504945
endfunction
let g:buffet_use_devicons = 1
"let g:buffet_powerline_separators = 1
"let g:buffet_tab_icon = "\uf00a"
let g:buffet_show_index = 1
let g:buffet_modified_icon = "+"
let g:buffet_left_trunc_icon = "|"
let g:buffet_right_trunc_icon = "|"
let g:buffet_separator = "|"
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
      \ 'ruby',
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
        \ 'fish',
        \ 'ion',
        \ 'ksh',
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
" => Async Code Runner
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F10> :call <SID>code_runner()<CR>
function! s:code_runner()
	let l:sleep = 5
  exec 'w'
  if &filetype == 'c'
    if executable('gcc')
      AsyncRun echo "Running C compiler"; gcc %; ./a.out
      exec 'sleep ' . l:sleep
      exec bufnr('$') . 'bw'
    endif
  elseif &filetype == 'cpp'
    if executable('g++')
      AsyncRun echo "Running C++ compiler"; g++ %; ./a.out
      exec 'sleep ' . l:sleep
      exec bufnr('$') . 'bw'
    endif
  elseif &filetype == 'go'
    if executable('go')
      AsyncRun! go build %; time ./%:p
      exec 'sleep ' . l:sleep
      exec bufnr('$') . 'bw'
    else
        echo 'Go is not installed!'
    endif
  elseif (&filetype == 'haskell' || &filetype=='lhaskell')
    if executable('ghc')
      AsyncRun! ghc % -o %<; time ./%:p
      exec 'sleep ' . l:sleep
      exec bufnr('$') . 'bw'
    else
        echo 'GHC is not installed!'
    endif
  elseif (&filetype == 'ion' || getline(1)[0:17] ==# "#!/usr/bin/env ion" || getline(1)[0:13] ==# "#!/usr/bin/ion")
    if executable('go')
      AsyncRun! time ion %:p
      exec 'sleep ' . l:sleep
      exec bufnr('$') . 'bw'
    else
        echo 'Ion is not installed!'
    endif
	elseif &filetype == 'java'
    if executable('javac')
      AsyncRun echo "Running Javac"; javac Main.java; java Main;
      exec 'sleep ' . l:sleep
      exec bufnr('$') . 'bw'
    else
      echo 'Java is not installed!'
    endif
  elseif &filetype == 'javascript'
    if executable('node')
      AsyncRun echo "Running Node"; node %:p
      exec 'sleep ' . l:sleep
      exec bufnr('$') . 'bw'
    else
        echo 'Node is not installed!'
    endif
  elseif (&filetype == 'perl' || getline(1)[0:18] ==# "#!/usr/bin/env perl" || getline(1)[0:14] ==# "#!/usr/bin/perl")
    if executable('perl')
      AsyncRun! time perl %:p
      exec 'sleep ' . l:sleep
      exec bufnr('$') . 'bw'
    else
        echo 'Perl is not installed!'
    endif
  elseif &filetype == 'php'
    if executable('php')
      AsyncRun echo "Running php"; php %:p
      exec 'sleep ' . l:sleep
      exec bufnr('$') . 'bw'
    else
        echo 'PHP is not installed!'
    endif
  elseif &filetype == 'python'
    if (getline(1)[0:21] ==# "#!/usr/bin/env python3" || getline(1)[0:17] ==# "#!/usr/bin/python3")
      if executable('python3')
        AsyncRun! time python3 %:p
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Python3 is not installed!'
      endif
    elseif (getline(1)[0:21] ==# "#!/usr/bin/env python2" || getline(1)[0:17] ==# "#!/usr/bin/python2")
      if executable('python2')
        try
          AsyncRun! time python2 %:p
        catch
          AsyncRun! time python %:p
        endtry
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Python2 is not installed!'
      endif
    elseif (getline(1)[0:20] ==# "#!/usr/bin/env python" || getline(1)[0:16] ==# "#!/usr/bin/python")
      if executable('python')
        AsyncRun! time python %:p
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Python executable can not be found!'
      endif
    elseif (getline(1)[0:19] ==# "#!/usr/bin/env pypy3" || getline(1)[0:15] ==# "#!/usr/bin/pypy3")
      if executable('pypy3')
        AsyncRun! time pypy3 %:p
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Pypy3 is not installed!'
      endif
    elseif (getline(1)[0:18] ==# "#!/usr/bin/env pypy" || getline(1)[0:14] ==# "#!/usr/bin/pypy")
      if executable('pypy')
        AsyncRun! time pypy %:p
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Pypy is not installed!'
      endif
    elseif (getline(1)[0:20] ==# "#!/usr/bin/env jython" || getline(1)[0:16] ==# "#!/usr/bin/jython")
      if executable('jython')
        AsyncRun! time jython %:p
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Jython is not installed!'
      endif
    endif
  elseif (&filetype == 'ruby' || getline(1)[0:18] ==# "#!/usr/bin/env ruby" || getline(1)[0:14] ==# "#!/usr/bin/ruby")
    if executable('ruby')
      AsyncRun! time ruby %:p
      exec 'sleep ' . l:sleep
      exec bufnr('$') . 'bw'
    else
        echo 'Ruby is not installed!'
    endif
  elseif &filetype == 'rust'
    if executable('cargo')
      try
        AsyncRun echo "Running cargo"; cargo build; time cargo run;
      catch
        AsyncRun echo "Running rustc"; rustc %; ./%:p;
      endtry
      exec 'sleep ' . l:sleep
      exec bufnr('$') . 'bw'
    else
      echo 'Rust is not installed!'
    endif
  elseif &filetype == 'sh'
    if (getline(1)[0:18] ==# "#!/usr/bin/env bash" || getline(1)[0:14] ==# "#!/usr/bin/bash")
      if executable('bash')
        AsyncRun! time bash %:p
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Bash is not installed!'
      endif
    elseif (getline(1)[0:18] ==# "#!/usr/bin/env dash" || getline(1)[0:14] ==# "#!/usr/bin/dash")
      if executable('dash')
        AsyncRun! time dash %:p
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Dash is not installed!'
      endif
    elseif (getline(1)[0:18] ==# "#!/usr/bin/env fish" || getline(1)[0:14] ==# "#!/usr/bin/fish")
      if executable('fish')
        AsyncRun! time fish %:p
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Fish is not installed!'
      endif
    elseif (getline(1)[0:18] ==# "#!/usr/bin/env tcsh" || getline(1)[0:14] ==# "#!/usr/bin/tcsh")
      if executable('tcsh')
        AsyncRun! time tcsh %:p
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
        else
          echo 'Tcsh is not installed!'
      endif
    elseif (getline(1)[0:17] ==# "#!/usr/bin/env csh" || getline(1)[0:13] ==# "#!/usr/bin/csh")
      if executable('csh')
        AsyncRun! time csh %:p
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Csh is not installed!'
      endif
    elseif (getline(1)[0:17] ==# "#!/usr/bin/env ksh" || getline(1)[0:13] ==# "#!/usr/bin/ksh")
      if executable('ksh')
        AsyncRun! time ksh %:p
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Ksh is not installed!'
      endif
    elseif (getline(1)[0:17] ==# "#!/usr/bin/env zsh" || getline(1)[0:13] ==# "#!/usr/bin/zsh")
      if executable('zsh')
        AsyncRun! time zsh %:p
        exec 'sleep ' . l:sleep
        exec bufnr('$') . 'bw'
      else
        echo 'Zsh is not installed!'
      endif
    endif
  elseif &filetype == 'tex'
    if executable('pdflatex')
      AsyncRun echo "Running pdfLatex"; pdflatex %p;
      exec 'sleep ' . l:sleep
      exec bufnr('$') . 'bw'
    else
        echo 'PDFlatex is not installed!'
    endif
  elseif &filetype == 'typescript'
    if executable('ts-node')
      AsyncRun echo "Running TS Node"; ts-node %:p
      exec 'sleep ' . l:sleep
      exec bufnr('$') . 'bw'
    else
        echo 'TS Node is not installed!'
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
  elseif &filetype == 'go'
    if executable('go')
      exec "AsyncRun! go build %"
    else
      echo 'Go is not installed!'
    endif
  elseif (&filetype == 'haskell' || &filetype=='lhaskell')
    if executable('ghc')
      exec "AsyncRun! ghc % -o %<"
    else
      echo 'GHC is not installed!'
    endif
  elseif &filetype == 'java'
    if executable('javac')
      exec "AsyncRun! javac %"
    else
      echo 'Java is not installed!'
    endif
  elseif &filetype == 'markdown'
    if executable('pandoc')
      if(expand("%:t") == "README.md" || expand("%:t") == "README.md")
        AsyncRun echo "Compiling github markdown"; pandoc -s -S -c ~/.config/nvim/plugins/markdown/github.css -o %<.html %;
      else
        AsyncRun echo "Compiling pandoc pdflatex"; pandoc -s -S -o %<.pdf %;
      endif
    else
        echo 'pandoc is not installed!'
    endif
  elseif &filetype == 'rust'
    if executable('cargo')
      exec "AsyncRun! cargo build --release"
    else
      echo 'Rust is not installed!'
    endif
  endif
endfunction
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim Markdown Composer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:markdown_composer_syntax_theme = 'atom-one-dark'
let g:markdown_composer_custom_css = ['file://' . expand('~/.config/nvim/config/plugins/markdown/markdown.css')]
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Gutentags 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gutentags_cache_dir = $DATA_PATH . '/tags'
let g:gutentags_project_root = ['.root', '.git', '.svn', '.hg', '.project','go.mod', 'Cargo.toml', '.bzr', '_darcs', '_FOSSIL_', '.fslckout']
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_new = 0
let g:gutentags_exclude_filetypes = ['vista']
let g:gutentags_ctags_extra_args = ['--output-format=e-ctags']
let g:gutentags_ctags_exclude = ['*.json', '*.js', '*.ts', '*.jsx', '*.css', '*.less', '*.sass', '*.go', '*.dart', 'node_modules', 'dist', 'vendor']
" Tagbar
let g:tagbar_width = 60
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Neoformat
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neoformat_try_formatprg = 1
let g:jsx_ext_required = 0
let g:neoformat_enabled_javascript=['prettier']
let g:neoformat_enabled_html=['js-beautify']
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1
let b:neoformat_basic_format_retab = 0
let g:vista#renderer#enable_icon = 1
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vista 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vista_executive_for = {
  \ 'go': 'ctags',
  \ 'javascript': 'coc',
  \ 'javascript.jsx': 'coc',
  \ 'python': 'ctags',
  \ }
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ALE 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
let g:ale_sign_error = '😡'
let g:ale_sign_warning = '😃'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lintetrs = {
	\'javascript': ['eslint', 'stylelint'],
	\'jsx': ['eslint', 'stylelint'],
	\'less': ['prettier'],
	\ }
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Goyo
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Goyo
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
autocmd! User GoyoEnter
autocmd! User GoyoLeave
autocmd  User GoyoEnter nested call <SID>goyo_enter()
autocmd  User GoyoLeave nested call <SID>goyo_leave()
" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Limelight
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color name (:help cterm-colors) or ANSI code
"let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
"let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#292B2E'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Coc.nvim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
augroup mygroup
  autocmd!
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" To not interfere with coc
let g:UltiSnipsExpandTrigger="s<Tab>"
