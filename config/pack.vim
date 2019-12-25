if &runtimepath !~# '/minpac.vim'
	let s:minpac_dir = expand('$DATA_PATH/pack').'/minpac/opt/minpac'
	if ! isdirectory(s:minpac_dir)
		execute '!git clone https://github.com/k-takata/minpac' s:minpac_dir
    endif

	execute 'set runtimepath+='.substitute(
		\ fnamemodify(s:minpac_dir, ':p') , '/$', '', '')
    
endif
" Set path for minpac
set packpath^=~/.cache/vim/

function! PackInit() abort
	packadd minpac
	call minpac#init()
	call minpac#add('liuchengxu/space-vim-dark')
	call minpac#add('lambdalisue/gina.vim')
	call minpac#add('taigacute/spaceline.vim')
	call minpac#add('ryanoasis/vim-devicons')
	call minpac#add('tyru/open-browser.vim')
	call minpac#add('honza/vim-snippets')
	call minpac#add('SirVer/ultisnips')
	call minpac#add('w0rp/ale')
	call minpac#add('sheerun/vim-polyglot')
	call minpac#add('ludovicchabant/vim-gutentags')
	call minpac#add('mhinz/vim-startify')
	call minpac#add('sbdchd/neoformat')
	call minpac#add('junegunn/goyo.vim')
	call minpac#add('junegunn/limelight.vim')
	call minpac#add('liuchengxu/vista.vim')
	call minpac#add('bagrat/vim-buffet')
	call minpac#add('Th3Whit3Wolf/vim-shebang')
	call minpac#add('euclio/vim-markdown-composer', {'do': 'silent !cargo build --release'})
	call minpac#add('liuchengxu/vim-clap', {'do': 'silent !cargo build --release'})

	" Loaded only for specific filetypes on demand. Requires autocommands below.
	call minpac#add('k-takata/minpac', {'type': 'opt'})
	call minpac#add('majutsushi/tagbar', {'type': 'opt'})
	call minpac#add('skywind3000/asyncrun.vim', {'type': 'opt'})
	call minpac#add('tweekmonster/startuptime.vim', {'type': 'opt'})
	call minpac#add('mhinz/vim-crates', {'type': 'opt'})
	call minpac#add('xuhdev/vim-latex-live-preview', {'type': 'opt' })
	call minpac#add('python-mode/python-mode', {'type': 'opt' })
	if executable('go')
		call minpac#add('fatih/vim-go', {'type': 'opt' }, { 'do': ':GoInstallBinaries'})
	endif

	" Coc and Extensions
	call minpac#add('neoclide/coc.nvim', {'do': {-> system('yarn install --frozen-lockfile') }})
	call minpac#add('coc-extensions/coc-utils', {'do': {-> system('yarn install --frozen-lockfile') }})
	call minpac#add('fannheyward/coc-marketplace', {'do': {-> system('yarn install --frozen-lockfile') }})
	call minpac#add('iamcco/coc-diagnostic', {'do': {-> system('yarn install --frozen-lockfile') }})
	call minpac#add('neoclide/coc-git', {'do': {-> system('yarn install --frozen-lockfile') }})
	call minpac#add('neoclide/coc-pairs', {'do': {-> system('yarn install --frozen-lockfile') }})
	call minpac#add('neoclide/coc-snippets', {'do': {-> system('yarn install --frozen-lockfile') }})
	call minpac#add('neoclide/coc-yank', {'do': {-> system('yarn install --frozen-lockfile') }})
	call minpac#add('neoclide/coc-highlight', {'do': {-> system('yarn install --frozen-lockfile') }})
	call minpac#add('weirongxu/coc-explorer', {'do': {-> system('yarn install --frozen-lockfile') }})

	" Language Specific Coc Extensions
	call minpac#add('neoclide/coc-tsserver', {'type': 'opt'}, {'do': {-> system('yarn install --frozen-lockfile') }})
	call minpac#add('neoclide/coc-html', {'type': 'opt'}, {'do': {-> system('yarn install --frozen-lockfile') }})
	call minpac#add('neoclide/coc-json', {'type': 'opt'}, {'do': {-> system('yarn install --frozen-lockfile') }})
	call minpac#add('neoclide/coc-css', {'type': 'opt'}, {'do': {-> system('yarn install --frozen-lockfile') }})
	call minpac#add('neoclide/coc-yaml', {'type': 'opt'}, {'do': {-> system('yarn install --frozen-lockfile') }})
	call minpac#add('neoclide/coc-emmet', {'type': 'opt'}, {'do': {-> system('yarn install --frozen-lockfile') }})
	call minpac#add('fannheyward/coc-markdownlint', {'type': 'opt'}, {'do': {-> system('yarn install --frozen-lockfile') }})
	call minpac#add('neoclide/coc-python', {'type': 'opt'}, {'do': {-> system('yarn install --frozen-lockfile') }})
	call minpac#add('josa42/coc-sh', {'type': 'opt'}, {'do': {-> system('yarn install --frozen-lockfile') }})
	call minpac#add('iamcco/coc-vimlsp', {'type': 'opt'}, {'do': {-> system('yarn install --frozen-lockfile') }})
	call minpac#add('iamcco/coc-svg', {'type': 'opt'}, {'do': {-> system('yarn install --frozen-lockfile') }})

	if executable('flutter')
		call minpac#add('iamcco/coc-flutter', {'type': 'opt'}, {'do': {-> system('yarn install --frozen-lockfile') }})
	endif
	if executable('erlang_ls')
		call minpac#add('hyhugh/coc-erlang_ls', {'type': 'opt'}, {'do': {-> system('yarn install --frozen-lockfile') }})
	endif
	if executable('elixir') && executable('mix')
		call minpac#add('amiralies/coc-elixir', {'type': 'opt'}, {'do': {-> system('yarn install --frozen-lockfile') }})
	endif
	if executable('php')
		call minpac#add('marlonfan/coc-phpls', {'type': 'opt' }, {'do': {-> system('yarn install --frozen-lockfile') }})
	endif
	if executable('ra_lsp_server')
		call minpac#add('fannheyward/coc-rust-analyzer', {'type': 'opt'}, {'do': {-> system('yarn install --frozen-lockfile') }})
	elseif executable('rls')
		call minpac#add('neoclide/coc-rls', {'type': 'opt'}, {'do': {-> system('yarn install --frozen-lockfile') }})
	endif
	if executable('r')
		call minpac#add('neoclide/coc-r-lsp', {'type': 'opt'}, {'do': {-> system('yarn install --frozen-lockfile') }})
	endif
	if executable('ruby')
		call minpac#add('neoclide/coc-solargraph', {'type': 'opt' }, {'do': {-> system('yarn install --frozen-lockfile') }})
	endif
	if executable('texlab')
		call minpac#add('fannheyward/coc-texlab', {'type': 'opt'}, {'do': {-> system('yarn install --frozen-lockfile') }})
	endif
	if executable('vls')
		call minpac#add('neoclide/coc-vetur', {'type': 'opt'}, {'do': {-> system('yarn install --frozen-lockfile') }})
	endif
endfunction

function! PackList(...)
	call PackInit()
	return join(sort(keys(minpac#getpluglist())), "\n")
endfunction

" Load plugins only for specific filetype
augroup lazy_load_coc_ft
	autocmd!
	autocmd! FileType javascript,typescript		packadd coc-tsserver | silent CocRestart 
	autocmd! FileType sass,scss,css 			packadd coc-css | silent CocRestart 
	autocmd! FileType less						packadd vim-less,coc-css | silent CocRestart 
	autocmd! FileType python 					packadd python-mode,coc-python | silent CocRestart 
	autocmd! FileType json						packadd coc-json | silent CocRestart 
	autocmd! FileType yaml						packadd coc-yaml | silent CocRestart 
	autocmd! FileType markdown,mkd				call SetUpMk()
	autocmd! FileType html						packadd coc-html,coc-emmet  | silent CocRestart 
	autocmd! FileType sh						packadd coc-sh | silent CocRestart 
	autocmd! FileType vim						packadd coc-vimlsp | silent CocRestart 
	autocmd! FileType svg						packadd coc-svg | silent CocRestart 

	if executable('flutter')
		autocmd! FileType dart					packadd coc-flutter | silent CocRestart 
	endif
	if executable('erlang_ls')
		autocmd! FileType erlang				packadd coc-erlang_ls | silent CocRestart 
	endif
	if executable('go')
		autocmd! FileType go 					packadd vim-go
	endif
	if executable('ion')
		autocmd! FileType ion 					packadd ion-vim
	endif
	if executable('texlab')
		autocmd! FileType latex					packadd vim-latex-live-preview,coc-texlab | silent CocRestart 
	else
		autocmd! FileType latex					packadd vim-latex-live-preview
	endif
	if executable('php')
		autocmd! FileType php					packadd coc-phpls | silent CocRestart 
	endif
	if executable('r')
		autocmd! FileType r						packadd coc-r-lsp | silent CocRestart 
	endif
	if executable('ruby')
		autocmd! FileType ruby					packadd coc-solargraph | silent CocRestart 
	endif
	if executable('ra_lsp_server')
		autocmd! FileType rust					packadd coc-rust-analyzer | silent CocRestart 
	elseif executable('rls')
		autocmd! FileType rust					packadd coc-rls | silent CocRestart 
	endif
	if executable('vls')
		autocmd! FileType vue					packadd coc-vetur | silent CocRestart 
	endif
	if has('nvim')
		autocmd BufRead Cargo.toml 				packadd vim-crates | call crates#toggle()
	endif
	autocmd! FileType bash,c,cpp,csh,dash,fish,go,haskell,ion,java,javascript,ksh,lhaskell,markdown,perl,php,python,ruby,rust,sh,tcsh,tex,zsh	packadd asyncrun.vim
augroup END

function! SetUpMk()
    " execute `Goyo` if it's not already active
    if !exists('#goyo')
        Goyo
    endif
	packadd coc-markdownlint  | silent CocRestart 
endfunction
