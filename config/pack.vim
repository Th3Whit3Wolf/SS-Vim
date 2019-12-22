if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif


if &runtimepath !~# '/minipac.vim'
	let s:minipac_dir = expand('$VARPATH/pack').'/minpac/opt/minpac'
	if ! isdirectory(s:minipac_dir)
		execute '!git clone https://github.com/k-takata/minpac' s:minipac_dir
    endif

	execute 'set runtimepath+='.substitute(
		\ fnamemodify(s:minipac_dir, ':p') , '/$', '', '')
    
endif
" Set pathe for minpac
set packpath^=~/.cache/vim/

function! PackInit() abort
	packadd minpac
	call minpac#init()
	call minpac#add('k-takata/minpac', {'type': 'opt'})
	call minpac#add('liuchengxu/space-vim-dark')
	call minpac#add('lambdalisue/gina.vim')
	call minpac#add('taigacute/spaceline.vim')
	call minpac#add('ryanoasis/vim-devicons')
	call minpac#add('tyru/open-browser.vim')
	call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
	call minpac#add('honza/vim-snippets')
	call minpac#add('SirVer/ultisnips')
	call minpac#add('w0rp/ale')
	call minpac#add('sheerun/vim-polyglot')
	call minpac#add('ludovicchabant/vim-gutentags')
	call minpac#add('mhinz/vim-startify')
	call minpac#add('sbdchd/neoformat')

	if executable('fzy') && executable('sk')
		call minpac#add('liuchengxu/vim-clap', { 'do': ':call clap#helper#build_maple()'})
	else
		call minpac#add('liuchengxu/vim-clap', { 'do': ':call clap#helper#build_rust_ext()'})
	endif

	"Loaded only for specific filetypes on demand. Requires autocommands below.
	if has('nvim')
		call minpac#add('euclio/vim-markdown-composer', {'do': ':!cargo build --release --locked'}, {'type': 'opt' })
	else 
		call minpac#add('euclio/vim-markdown-composer', {'do': ':!cargo build --release --locked --no-default-features --features json-rpc'}, {'type': 'opt' })
	endif
	"call minpac#add('oknozor/illumination', {'dir': '~/.illumination'}, {'do': './install.sh' }, {'type': 'opt'})
	call minpac#add('fatih/vim-go', { 'do': ':GoInstallBinaries'}, {'type': 'opt' })
	call minpac#add('xuhdev/vim-latex-live-preview', {'type': 'opt' })
	call minpac#add('vmchale/ion-vim', {'type': 'opt' })
	call minpac#add('python-mode/python-mode', {'type': 'opt' })
	call minpac#add('junegunn/goyo.vim')
	call minpac#add('junegunn/limelight.vim')
	call minpac#add('skywind3000/asyncrun.vim', {'type': 'opt' })
endfunction

function! PackList(...)
  call PackInit()
  return join(sort(keys(minpac#getpluglist())), "\n")
endfunction

command! -nargs=1 -complete=custom,PackList
      \ PackOpenUrl call PackInit() | call openbrowser#open(
      \    minpac#getpluginfo(<q-args>).url)

command! -nargs=1 -complete=custom,PackList
      \ PackOpenDir call PackInit() | call term_start(&shell,
      \    {'cwd': minpac#getpluginfo(<q-args>).dir,
      \     'term_finish': 'close'})

" Define user commands for updating/cleaning the plugins.
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
command! PackUpdate call PackInit() | source $HOME/.config/nvim/config/pack.vim | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | source $HOME/.config/nvim/config/pack.vim | call minpac#clean()
command! PackStatus call PackInit() | source $HOME/.config/nvim/config/pack.vim | call minpac#status()

"Load plugins only for specific filetype
augroup packager_filetype
  autocmd!
  autocmd! FileType go 							packadd vim-go
  autocmd! FileType less						packadd vim-less 
  autocmd! FileType latex						packadd vim-latex-live-preview 
  autocmd! FileType ion 						packadd ion-vim
  autocmd! FileType python 						packadd python-mode
  autocmd! FileType markdown					packadd vim-markdown-composer,goyo.vim,limelight.vim
  autocmd! FileType c, cpp, java, sh, python	packadd vim-asyncrun
augroup END