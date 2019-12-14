call minpac#add('neoclide/coc.nvim', {'branch': 'release'}, {'do': function('s:coc_cb')})
call minpac#add('neoclide/coc-git', {'do': 'yarn install --frozen-lockfile'})
call minpac#add('neoclide/coc-pairs', {'do': 'yarn install --frozen-lockfile'})
call minpac#add('neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'})
call minpac#add('neoclide/coc-yank', {'do': 'yarn install --frozen-lockfile'})
call minpac#add('neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'})
call minpac#add('weirongxu/coc-explorer', {'do': 'yarn install --frozen-lockfile'})
call minpac#add('junegunn/fzf.vim')
call minpac#add('junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' })
call minpac#add('neoclide/coc-tsserver', {'type': 'opt'}, {'do': 'yarn install --frozen-lockfile'})
call minpac#add('neoclide/coc-html', {'type': 'opt'}, {'do': 'yarn install --frozen-lockfile'})
call minpac#add('neoclide/coc-json', {'type': 'opt'}, {'do': 'yarn install --frozen-lockfile'})
call minpac#add('neoclide/coc-css', {'type': 'opt'}, {'do': 'yarn install --frozen-lockfile'})
call minpac#add('neoclide/coc-vetur', {'type': 'opt'}, {'do': 'yarn install --frozen-lockfile'})
call minpac#add('fannheyward/coc-rust-analyzer', {'type': 'opt'}, {'do': 'yarn install --frozen-lockfile'})
call minpac#add('neoclide/coc-yaml', {'type': 'opt'}, {'do': 'yarn install --frozen-lockfile'})
call minpac#add('neoclide/coc-python', {'type': 'opt'}, {'do': 'yarn install --frozen-lockfile'})
call minpac#add('neoclide/coc-emmet', {'type': 'opt'}, {'do': 'yarn install --frozen-lockfile'})
call minpac#add('fannheyward/coc-markdownlint', {'type': 'opt'}, {'do': 'yarn install --frozen-lockfile'})
call minpac#add('iamcco/coc-flutter', {'type': 'opt'}, {'do': 'yarn install --frozen-lockfile'})
call minpac#add('fannheyward/coc-texlab', {'type': 'opt'}, {'do': 'yarn install --frozen-lockfile'})Z
call minpac#add('neoclide/coc-r-lsp', {'type': 'opt'}, {'do': 'yarn install --frozen-lockfile'})
call minpac#add('neoclide/coc-solargraph', {'type': 'opt' }, {'do': 'yarn install --frozen-lockfile'})
call minpac#add('marlonfan/coc-phpls', {'type': 'opt' }, {'do': 'yarn install --frozen-lockfile'})

function! CocBuildUpdate()
  if has('nvim')
    let g:coc_global_extensions = [
        \ 'coc-eslint', 
		\ 'coc-tsserver', 
		\ 'coc-git', 
		\ 'coc-snippets',
		\ 'coc-html', 
		\ 'coc-python', 
		\ 'coc-pairs',
		\ 'coc-yank',
		\ 'coc-highlight', 
		\ 'coc-json',
		\ 'coc-css',
		\ 'coc-texlab',
		\ 'coc-vetur', 
		\ 'coc-rust-analyzer',
		\ 'coc-yaml',
		\ 'coc-emmet',
		\ 'coc-markdownlint', 
		\ 'coc-flutter',
		\ 'coc-phpls', 
		\ 'coc-solargraph', 
		\ 'coc-r-lsp'
		\ 'coc-explorer'
        \ ]
    call coc#util#install()
    call coc#util#install_extension(g:coc_global_extensions)
  endif
endfunction

function! s:coc_cb(hooktype, name) abort
	execute 'packadd ' . a:name
	call coc#util#build()
	call coc#util#install_extension(g:coc_global_extensions)
endfunction

let s:coc_extensions = [
	\ 'coc-eslint', 
	\ 'coc-tsserver', 
	\ 'coc-git', 
	\ 'coc-snippets',
	\ 'coc-html', 
	\ 'coc-python', 
	\ 'coc-pairs',
	\ 'coc-yank',
	\ 'coc-highlight', 
	\ 'coc-json',
	\ 'coc-css',
	\ 'coc-texlab',
	\ 'coc-vetur', 
	\ 'coc-rust-analyzer',
	\  'coc-yaml',
	\ 'coc-emmet',
	\ 'coc-markdownlint', 
	\ 'coc-flutter',
	\ 'coc-phpls', 
	\ 'coc-solargraph', 
	\ 'coc-r-lsp'
	\ 'coc-explorer'
	\ ]

function! s:coc_plugins() abort
	execute 'packadd ' . a:name
	call coc#util#install() " Throws here
	call coc#util#install_extension(join(get(s:, 'coc_extensions', [])))
endfunction

function! InstallCoc(plugin) abort
  exe '!cd '.a:plugin.dir.' && yarn install'
  call coc#add_extension(
	  \
	  )
endfunction

augroup packager_filetype
  autocmd!
  autocmd! BufRead *.ts			packadd coc-tsserver
  autocmd! FileType go 			packadd vim-go
  autocmd! FileType rs 			packadd coc-rust-analyzer
  autocmd! FileType python 		packadd coc-python
  autocmd! FileType css			packadd coc-css
  autocmd! FileType sass,scss 	packadd coc-css
  autocmd! FileType less		packadd vim-less " ,coc-css
  autocmd! FileType latex		packadd vim-latex-live-preview " ,coc-texlab
  autocmd! FileType php			packadd coc-phpls
  autocmd! FileType ion 		packadd ion-vim
  autocmd! FileType ruby		packadd coc-solargraph
  autocmd! FileType r			packadd coc-r-lsp
  autocmd! FileType html		packadd coc-html,coc-emmet
  autocmd! FileType json		packadd coc-json
  autocmd! FileType yaml		packadd coc-yaml
  autocmd! FileType markdown	packadd illumination,goyo.vim,limelight.vim " ,coc-markdownlint
  autocmd! FileType vetur		packadd coc-vetur
  autocmd! FileType c, cpp, java, sh, python		packadd vim-accio
augroup END