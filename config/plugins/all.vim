"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Apperance
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set termguicolors
color space-vim-dark
if has('nvim')
  let g:terminal_color_0 = '#262626'
  let g:terminal_color_1 = '#f2241f'
  let g:terminal_color_2 = '#67b11d'
  let g:terminal_color_3 = '#d7af5f'
  let g:terminal_color_4 = '#2aa1ae'
  let g:terminal_color_5 = '#5d4d7a'
  let g:terminal_color_6 = '#0086df'
  let g:terminal_color_7 = '#b2b2b2'

  let g:terminal_color_8 = '#262626'
  let g:terminal_color_9 = '#f2241f'
  let g:terminal_color_10 = '#67b11d'
  let g:terminal_color_11 = '#d7af5f'
  let g:terminal_color_12 = '#2aa1ae'
  let g:terminal_color_13 = '#5d4d7a'
  let g:terminal_color_14 = '#0086df'
  let g:terminal_color_15 = '#b2b2b2'
endif
hi Normal     ctermbg=NONE guibg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
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
    \ 'ash',
    \ 'bash',
    \ 'csh',
    \ 'dash',
    \ 'fish',
    \ 'ksh',
    \ 'ion',
    \ 'mksh',
    \ 'pdksh',
    \ 'sh',
    \ 'tcsh',
    \ 'zsh',
    \ 'none'
    \ ]

  if has('mac')
    let options = ['osascript'] + options
  endif

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
 	autocmd BufNewFile *.escript 0put =\"#!/usr/bin/env escript"
 	autocmd BufNewFile *.fish    0put =\"#!/usr/bin/env fish"
 	autocmd BufNewFile *.ion     0put =\"#!/usr/bin/env ion"
 	autocmd BufNewFile *.lua     0put =\"#!/usr/bin/env lua"
  autocmd BufNewFile *.pl      0put =\"#!/usr/bin/env perl"
	autocmd BufNewFile *.php     0put =\"#!/usr/bin/env php
  autocmd BufNewFile *.py      call <SID>python_shebang()
  autocmd BufNewFile *.rb      0put =\"#!/usr/bin/env ruby"
	autocmd BufNewFile *.sh      call <SID>shell_shebang()
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Change Shebang
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap  <buffer><F6> :call <SID>change_bang()<CR>
function! s:change_bang()
	if &filetype == 'shell'
    if getline(1)[0:1] !=# "#!"
      let shell_options  = [
        \ 'ash',
        \ 'bash',
        \ 'csh',
        \ 'dash',
        \ 'fish',
        \ 'ksh',
        \ 'ion',
        \ 'mksh',
        \ 'pdksh',
        \ 'sh',
        \ 'tcsh',
        \ 'zsh',
        \ 'none'
        \ ]

      if has('mac')
        let shell_options = ['osascript'] + shell_options
      endif

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
if exists("g:neoformat_is_on")
  augroup fmt
    autocmd!
    autocmd BufWritePre * undojoin | Neoformat
  augroup END
endif

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1
let b:neoformat_basic_format_retab = 0
let g:vista#renderer#enable_icon = 1
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vista 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <c-t> :silent! Vista finder coc<CR>
let g:vista_executive_for = {
  \ 'go': 'ctags',
  \ 'javascript': 'coc',
  \ 'javascript.jsx': 'coc',
  \ 'python': 'ctags',
  \ }
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
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
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim Clap
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Lazy Git
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Creates a floating window with a most recent buffer to be used
function! CreateCenteredFloatingWindow()
    let width = float2nr(&columns * 0.6)
    let height = float2nr(&lines * 0.6)
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Pmenu
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction
if executable('lazygit')
  function! OpenTerm(cmd)
      call CreateCenteredFloatingWindow()
      call termopen(a:cmd, { 'on_exit': function('OnTermExit') })
  endfunction

  function! OpenScratchTerm()
      call OpenTerm('bash')
      startinsert
  endfunction

  function! OpenLazyGit()
      call OpenTerm('lazygit')
      startinsert
  endfunction

  function! OnTermExit(job_id, code, event) dict
      if a:code == 0
          bd!
      endif
  endfunction
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => asyncrun
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:asyncrun_open = 6
let g:asynctasks_edit_split = 'auto'
