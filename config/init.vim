let g:mapleader="\<Space>"

" Release keymappings prefixes, evict entirely for use of plug-ins.
nnoremap <Space>  <Nop>
xnoremap <Space>  <Nop>
nnoremap ,        <Nop>
xnoremap ,        <Nop>
nnoremap ;        <Nop>
xnoremap ;        <Nop>
nnoremap m        <Nop>
xnoremap m        <Nop>

" Ensure cache directory "{{{
if ! isdirectory(expand($VARPATH))
	" Create missing dirs i.e. cache/{undo,backup}
	call mkdir(expand('$VARPATH/undo'), 'p')
	call mkdir(expand('$VARPATH/backup'))
endif

" Ensure custom spelling directory
if ! isdirectory(expand('$VIMPATH/spell'))
	call mkdir(expand('$VIMPATH/spell'))
endif

" Load vault settings "{{{
if filereadable(expand('$VIMPATH/.vault.vim'))
	execute 'source' expand('$VIMPATH/.vault.vim')
endif

" Setup dein {{{
if &runtimepath !~# '/dein.vim'
	let s:dein_dir = expand('$VARPATH/dein').'/repos/github.com/Shougo/dein.vim'
	if ! isdirectory(s:dein_dir)
		execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
	endif

	execute 'set runtimepath+='.substitute(
		\ fnamemodify(s:dein_dir, ':p') , '/$', '', '')
endif

" Disable pre-bundled plugins
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_logiPat = 1
let g:loaded_matchit = 1
let g:loaded_matchparen = 1
let g:netrw_nogx = 1 " disable netrw's gx mapping.
let g:loaded_rrhelper = 1
let g:loaded_ruby_provider = 1
let g:loaded_shada_plugin = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let did_install_default_menus = 1
let did_install_syntax_menu = 1
