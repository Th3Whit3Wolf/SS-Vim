function! s:theme_reload(name)
	let theme_path = $VIMPATH.'/themes/'.a:name.'.vim'
	if filereadable(theme_path)
		execute 'source' fnameescape(theme_path)
		" Persist theme
		call writefile([g:colors_name], s:cache)
	endif
endfunction

" THEME NAME
let g:theme_name = 'spacevim-ele'
autocmd MyAutoCmd ColorScheme * call s:theme_reload(g:theme_name)

" COLORSCHEME NAME
let s:cache = $VARPATH.'/theme.txt'
if ! exists('g:colors_name')
	execute 'colorscheme'
		\ filereadable(s:cache) ? readfile(s:cache)[0] : 'space-vim-dark'
endif

set termguicolors
