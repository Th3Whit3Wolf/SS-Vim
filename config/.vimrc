if &compatible
	set nocompatible
endif

" Set main configuration directory, and where cache is stored.
let $VIMPATH = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
" Set data/cache directory as $XDG_CACHE_HOME/vim
let $DATA_PATH =
	\ expand(($XDG_CACHE_HOME ? $XDG_CACHE_HOME : '~/.cache') . '/vim')
if has('nvim') && isdirectory($DATA_PATH . '/venv/neovim2')
	let g:python_host_prog = $DATA_PATH . '/venv/neovim2/bin/python'
endif

if has('nvim') && isdirectory($DATA_PATH . '/venv/neovim3')
	let g:python3_host_prog = $DATA_PATH . '/venv/neovim3/bin/python'
endif

if has('nvim') && filereadable('~/.node_modules/bin/neovim-node-host')
	let g:node_host_prog    = '~/.node_modules/bin/neovim-node-host'
endif

" Ensure cache directory
if ! isdirectory(expand($DATA_PATH))
	" Create missing dirs i.e. cache/{undo,backup}
	call mkdir(expand('$DATA_PATH/undo'), 'p')
	call mkdir(expand('$DATA_PATH/backup'))
endif

" Ensure custom spelling directory
if ! isdirectory(expand('$VIMPATH/spell'))
	call mkdir(expand('$VIMPATH/spell'))
endif

" Load vault settings
if filereadable(expand('$VIMPATH/.vault.vim'))
	execute 'source' expand('$VIMPATH/.vault.vim')
endif

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

" Disable vim distribution plugins
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_logiPat = 1
let g:loaded_matchit = 1
let g:loaded_matchparen = 1
let g:netrw_nogx = 1 " disable netrw's gx mapping.
let g:loaded_rrhelper = 1  " ?
let g:loaded_shada_plugin = 1  " ?
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1

if ! has('nvim') && has('pythonx')
	if has('python3')
		set pyxversion=3
	elseif has('python')
		set pyxversion=2
	endif
endif

" If sudo, disable vim swap/backup/undo/shada/viminfo writing
if $SUDO_USER !=# '' && $USER !=# $SUDO_USER
		\ && $HOME !=# expand('~'.$USER)
		\ && $HOME ==# expand('~'.$SUDO_USER)

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
call s:source_file('general.vim')
call s:source_file('pack.vim')
call s:source_file('filetype.vim')

" Loading plugin specific configuration modules
call s:source_file('plugins/ss.vim')
call s:source_file('plugins/all.vim')

call s:source_file('commands.vim')
call s:source_file('mappings.vim')
call s:source_file('plugins/coc.vim')
