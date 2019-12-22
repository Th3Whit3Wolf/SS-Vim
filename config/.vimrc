if &compatible
	set nocompatible
endif

" Set main configuration directory, and where cache is stored.
let $VIMPATH = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
let $VARPATH = expand(($XDG_CACHE_HOME ? $XDG_CACHE_HOME : '~/.cache').'/vim')

" Constants
let s:is_sudo = $SUDO_USER !=# '' && $USER !=# $SUDO_USER

function! s:source_file(path, ...) abort
	let use_global = get(a:000, 0, ! has('vim_starting'))
	let abspath = resolve(expand($VIMPATH.'/config/'.a:path))
	if ! use_global
		execute 'source' fnameescape(abspath)
		return
	endif

	let content = map(readfile(abspath),
		\ "substitute(v:val, '^\\W*\\zsset\\ze\\W', 'setglobal', '')")
	let tempfile = tempname()
	try
		call writefile(content, tempfile)
		execute printf('source %s', fnameescape(tempfile))
	finally
		if filereadable(tempfile)
			call delete(tempfile)
		endif
	endtry
endfunction

" Set augroup
augroup MyAutoCmd
	autocmd!
	autocmd CursorHold *? syntax sync minlines=300
augroup END

if s:is_sudo
	set noswapfile
	set nobackup
	set nowritebackup
	set noundofile
	if has('nvim')
		set shada="NONE"
	else
		set viminfo="NONE"
	endif
endif

set secure
filetype plugin indent on
syntax enable

" Initialize base requirements
call s:source_file('init.vim')
call s:source_file('pack.vim')

" Loading plugin specific configuration modules
call s:source_file('plugins/all.vim')
call s:source_file('plugins/coc.vim')
call s:source_file('plugins/ss.vim')

" Loading configuration modules
call s:source_file('general.vim')
call s:source_file('filetype.vim')
call s:source_file('ft.vim')
call s:source_file('mappings.vim')