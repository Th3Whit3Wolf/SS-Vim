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
