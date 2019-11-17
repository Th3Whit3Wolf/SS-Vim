if &runtimepath !~# '/minipac.vim'
	let s:minipac_dir = expand('$VARPATH/pack').'/minpac/opt/minpac'
	if ! isdirectory(s:minipac_dir)
		execute '!git clone https://github.com/k-takata/minpac' s:minipac_dir
        execute 'curl -fLo ~/.vim/autoload/plugpac.vim --create-dirs https://raw.githubusercontent.com/bennyyip/plugpac.vim/master/plugpac.vim'
    endif

	execute 'set runtimepath+='.substitute(
		\ fnamemodify(s:minipac_dir, ':p') , '/$', '', '')
    
endif
" Set pathe for minpac
set packpath^=~/.cache/vim/

" For skim
set rtp+=~/.skim

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
	call minpac#add('lotabout/skim', { 'dir': '~/.skim'}, {'do': './install' })

	"Loaded only for specific filetypes on demand. Requires autocommands below.
	call minpac#add('oknozor/illumination', {'dir': '~/.illumination'}, {'do': './install.sh' }, {'type': 'opt'})
	call minpac#add('fatih/vim-go', { 'do': ':GoInstallBinaries'}, {'type': 'opt' })
	call minpac#add('xuhdev/vim-latex-live-preview', {'type': 'opt' })
	call minpac#add('vmchale/ion-vim', {'type': 'opt' })
	call minpac#add('python-mode/python-mode', {'type': 'opt' })
	call minpac#add('junegunn/goyo.vim', {'type': 'opt' })
	call minpac#add('junegunn/limelight.vim', {'type': 'opt' })
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
command! PackUpdate call PackInit() | source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | source $MYVIMRC | call minpac#clean()
command! PackStatus call PackInit() | source $MYVIMRC | call minpac#status()

"Load plugins only for specific filetype
augroup packager_filetype
  autocmd!
  autocmd! FileType go 			packadd vim-go
  autocmd! FileType less		packadd vim-less " ,coc-css
  autocmd! FileType latex		packadd vim-latex-live-preview " ,coc-texlab
  autocmd! FileType ion 		packadd ion-vim
  autocmd! FileType python 		packadd python-mode
  autocmd! FileType markdown	packadd illumination,goyo.vim,limelight.vim " ,coc-markdownlint
  autocmd! FileType c, cpp, java, sh, python		packadd vim-accio
augroup END
