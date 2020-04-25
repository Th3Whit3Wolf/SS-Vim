if &runtimepath !~# '/minpac.vim'
	let s:minpac_dir = expand('$DATA_PATH/pack').'/minpac/opt/minpac'
	if ! isdirectory(s:minpac_dir)
		execute '!git clone https://github.com/k-takata/minpac' s:minpac_dir
    endif

	execute 'set runtimepath+='.substitute(
		\ fnamemodify(s:minpac_dir, ':p') , '/$', '', '')
endif
" Set path for minpac
set packpath^=~/.cache/vim

function! s:clap_hook(hooktype, name) abort
	execute 'packadd ' . a:name
	source $MYVIMRC
	packloadall
	call clap#helper#build_all() 
endfunction
function! PackInit() abort
	packadd minpac
	call minpac#init()
	call minpac#add('liuchengxu/space-vim-dark')
	call minpac#add('lambdalisue/gina.vim')
	call minpac#add('taigacute/spaceline.vim')
	call minpac#add('ryanoasis/vim-devicons')
	call minpac#add('honza/vim-snippets')
	call minpac#add('SirVer/ultisnips')
	call minpac#add('w0rp/ale')
	call minpac#add('sheerun/vim-polyglot')
	call minpac#add('ludovicchabant/vim-gutentags')
	call minpac#add('mhinz/vim-startify')
	call minpac#add('bagrat/vim-buffet')
	call minpac#add('Th3Whit3Wolf/vim-shebang')
	call minpac#add('euclio/vim-markdown-composer', {'do': 'silent !cargo build --release'})
	call minpac#add('liuchengxu/vim-which-key')
	call minpac#add('godlygeek/tabular')
	call minpac#add('skywind3000/asyncrun.vim')
	call minpac#add('skywind3000/asynctasks.vim')
	if executable('cargo')
		call minpac#add('liuchengxu/vim-clap', {'do': 'Clap install-binary!'})
	else
		call minpac#add('liuchengxu/vim-clap')
	endif
	" Loaded only for specific filetypes on demand. Requires autocommands below.
	call minpac#add('k-takata/minpac', {'type': 'opt'})
	call minpac#add('tyru/open-browser.vim', {'type': 'opt'})
	call minpac#add('liuchengxu/vista.vim', {'type': 'opt'})
	call minpac#add('tweekmonster/startuptime.vim', {'type': 'opt'})
	call minpac#add('mhinz/vim-crates', {'type': 'opt'})
	call minpac#add('xuhdev/vim-latex-live-preview', {'type': 'opt' })
	call minpac#add('python-mode/python-mode', {'type': 'opt' })
	call minpac#add('junegunn/goyo.vim', {'type': 'opt'})
	call minpac#add('junegunn/limelight.vim', {'type': 'opt'})
	if executable('go')
		call minpac#add('fatih/vim-go', {'type': 'opt' }, { 'do': 'GoInstallBinaries'})
	endif
	call minpac#add('sbdchd/neoformat', {'type': 'opt'})

	" Coc and Extensions
	call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
endfunction

function! PackList(...)
	call PackInit()
	return join(sort(keys(minpac#getpluglist())), "\n")
endfunction

" Load plugins only for specific filetype
augroup lazy_load_ft
	autocmd!
	autocmd! FileType markdown,mkd				call SetUpMk()
	if executable('go')
		autocmd! FileType go 					packadd vim-go
	endif
	if executable('ion')
		autocmd! FileType ion 					packadd ion-vim
	endif
	if executable('texlab')
		autocmd! FileType latex					packadd vim-latex-live-preview
	else
		autocmd! FileType latex					packadd vim-latex-live-preview
	endif
	if has('nvim')
		autocmd BufRead Cargo.toml 				packadd vim-crates | call crates#toggle()
	endif
	autocmd! FileType arduino,asm,bzl,c,cmake,cpp,crystal,cs,css,csv,d,dart,dhall,dune,elixir,elm,fish,glsl,go,graphql,haskell,html,jade,java,javascript,jinja,json,kotlin,less,lua,markdown,matlab,nim,nix,objc,ocaml,pandoc,pawn,perl,php,proto,pug,purescript,python,r,reason,ruby,rust,sass,sbt,scala,scss,sh,sql,starlark,svelte,swift,terraform,tex,typescript,vala,vue,xhtml,xml,ysml call SetNeoformat()
augroup END

function! SetUpMk()
    " execute `Goyo` if it's not already active
    if !exists('#goyo')
        Goyo
    endif
endfunction

function! SetNeoformat()
	packadd neoformat
	let g:neoformat_is_on = 1
endfunction

let s:coc_extensions = [
	\ 'coc-tag',
	\ 'coc-word',
	\ 'coc-utils',
	\ 'coc-marketplace',
	\ 'coc-diagnostic',
	\ 'coc-git',
	\ 'coc-pairs',
	\ 'coc-snippets',
	\ 'coc-yank',
	\ 'coc-highlight',
	\ 'coc-explorer',
	\ 'coc-python',
	\ 'coc-markdownlint',
	\ 'coc-sh',
	\ 'coc-emmet',
	\ 'coc-html',
	\ 'coc-json',
	\ 'coc-css',
	\ 'coc-yaml',
	\ 'coc-svg',
	\ 'coc-vimlsp',
	\ 'coc-eslint',
	\ 'coc-actions',
	\ 'coc-tasks'
	\]
if executable('clangd')
	let s:coc_extensions += ['coc-clangd']
endif
if executable('docker')
	let s:coc_extensions += ['coc-docker']
endif
if executable('elixir') && executable('mix')
	let s:coc_extensions += ['coc-elixir']
endif
if executable('erlang_ls')
	let s:coc_extensions += ['coc-erlang_ls']
endif
if executable('flutter')
	let s:coc_extensions += ['coc-flutter']
endif
if executable('php')
	let s:coc_extensions += ['coc-phpls']
endif
if executable('ra_lsp_server')
	let s:coc_extensions += ['coc-rust-analyzer']
elseif executable('rls')
	let s:coc_extensions += ['coc-rls']
endif
if executable('r')
	let s:coc_extensions += ['coc-r-lsp']
endif
if executable('ruby')
	let s:coc_extensions += ['coc-solargraph']
endif
if executable('texlab')
	let s:coc_extensions += ['coc-texlab']
endif
if executable('vls')
	let s:coc_extensions += ['coc-vetur']
endif

function! s:uninstall_unused_coc_extensions() abort
    for e in keys(json_decode(join(readfile(expand('~/.config/coc/extensions/package.json')), "\n"))['dependencies'])
        if index(s:coc_extensions, e) < 0
            execute 'CocUninstall ' . e
        endif
    endfor
endfunction
autocmd User CocNvimInit call s:uninstall_unused_coc_extensions()

for e in s:coc_extensions
    silent! call coc#add_extension(e)
endfor

func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		CocCommand flutter.run
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc