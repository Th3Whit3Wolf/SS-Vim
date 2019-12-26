if exists('did_load_filetypes')
	finish
endif

augroup filetypedetect
	autocmd BufNewFile,BufRead */playbooks/*.{yml,yaml} setfiletype yaml.ansible
	autocmd BufNewFile,BufRead */inventory/*            setfiletype ansible_hosts
	autocmd BufNewFile,BufRead */templates/*.{yaml,tpl} setfiletype yaml.gotexttmpl
	autocmd BufNewFile,BufRead yarn.lock                setfiletype yaml
	autocmd BufNewFile,BufRead */.kube/config           setfiletype yaml
	autocmd BufNewFile,BufRead *.postman_collection     setfiletype json
	autocmd BufNewFile,BufRead .tern-{project,port}     setfiletype json
	autocmd BufNewFile,BufRead *.lock                   setfiletype json
	autocmd BufNewFile,BufRead *.js.map                 setfiletype json
	autocmd BufNewFile,BufRead .jsbeautifyrc            setfiletype json
	autocmd BufNewFile,BufRead .eslintrc                setfiletype json
	autocmd BufNewFile,BufRead .jscsrc                  setfiletype json
	autocmd BufNewFile,BufRead .babelrc                 setfiletype json
	autocmd BufNewFile,BufRead .watchmanconfig          setfiletype json
	autocmd BufNewFile,BufRead .buckconfig              setfiletype toml
	autocmd BufNewFile,BufRead .flowconfig              setfiletype ini
	autocmd BufNewFile,BufRead *.{feature,story}        setfiletype cucumber
	autocmd BufNewFile,BufRead Jenkinsfile              setfiletype groovy
	autocmd BufNewFile,BufRead Tmuxfile,tmux/config     setfiletype tmux
	autocmd BufNewFile,BufRead Brewfile                 setfiletype ruby
	autocmd BufNewFile,BufRead Justfile,justfile        setfiletype make
	autocmd BufNewFile,BufRead *.ion                    setfiletype ion
	autocmd BufRead 			*.rs :setlocal tags=./rusty-tags.vi;/
	autocmd BufWritePost 		*.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
augroup END

=" Reload vim config automatically
execute 'autocmd MyAutoCmd BufWritePost '.$VIMPATH.'/config/*,vimrc nested'
	\ .' source $MYVIMRC | redraw'

augroup MyAutoCmd
	autocmd!
	" Highlight current line only on focused window
	autocmd WinEnter,InsertLeave * set cursorline
	autocmd WinLeave,InsertEnter * set nocursorline

	" Automatically set read-only for files being edited elsewhere
	autocmd SwapExists * nested let v:swapchoice = 'o'

	" Equalize window dimensions when resizing vim window
	autocmd VimResized * tabdo wincmd =

		" Force write shada on leaving nvim
	autocmd VimLeave * if has('nvim') | wshada! | else | wviminfo! | endif

	" Check if file changed when its window is focus, more eager than 'autoread'
	autocmd WinEnter,FocusGained * checktime

	autocmd Syntax * if line('$') > 5000 | syntax sync minlines=200 | endif

	" Update filetype on save if empty
	autocmd BufWritePost * nested
		\ if &l:filetype ==# '' || exists('b:ftdetect')
		\ |   unlet! b:ftdetect
		\ |   filetype detect
		\ | endif

	" Reload Vim script automatically if setlocal autoread
	autocmd BufWritePost,FileWritePost *.vim nested
		\ if &l:autoread > 0 | source <afile> |
		\   echo 'source '.bufname('%') |
		\ endif

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	autocmd BufReadPost *
		\ if &ft !~# 'commit' && ! &diff &&
		\      line("'\"") >= 1 && line("'\"") <= line("$")
		\|   execute 'normal! g`"zvzz'
		\| endif

	autocmd FileType crontab setlocal nobackup nowritebackup

	autocmd FileType css setlocal equalprg=csstidy\ -\ --silent=true

	autocmd FileType yaml.docker-compose setlocal expandtab

	autocmd FileType gitcommit setlocal spell

	autocmd FileType gitcommit,qfreplace setlocal nofoldenable

	" https://webpack.github.io/docs/webpack-dev-server.html#working-with-editors-ides-supporting-safe-write
	autocmd FileType css,javascript,javascriptreact setlocal backupcopy=yes

	autocmd FileType php
		\ setlocal matchpairs-=<:> iskeyword+=\\ path+=/usr/local/share/pear

	autocmd FileType python
		\ setlocal foldmethod=indent expandtab smarttab nosmartindent
		\ | setlocal tabstop=4 softtabstop=4 shiftwidth=4 textwidth=80

	autocmd FileType zsh setlocal foldenable foldmethod=marker

	autocmd FileType html setlocal path+=./;/

	autocmd FileType json setlocal equalprg=python\ -c\ json.tool

	autocmd FileType apache setlocal path+=./;/

	autocmd FileType cam setlocal nonumber synmaxcol=10000

	autocmd FileType go highlight default link goErr WarningMsg |
		\ match goErr /\<err\>/

	autocmd FileType xml
		\ setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

augroup END

let g:markdown_fenced_languages = [
	\  'css',
	\  'javascript',
	\  'js=javascript',
	\  'json=javascript',
	\  'python',
	\  'py=python',
	\  'docker=Dockerfile',
	\  'makefile=make',
	\  'sh',
	\  'sass',
	\  'xml',
	\  'yaml',
	\  'vim'
	\]

" Internal Plugin Settings  
" ------------------------

" PHP 
let g:PHP_removeCRwhenUnix = 0

" Python 
let g:python_highlight_all = 1

" Vim 
let g:vimsyntax_noerror = 1
let g:vim_indent_cont = &shiftwidth

" Bash 
let g:is_bash = 1

" Java
let g:java_highlight_functions = 'style'
let g:java_highlight_all = 1
let g:java_highlight_debug = 1
let g:java_allow_cpp_keywords = 1
let g:java_space_errors = 1
let g:java_highlight_functions = 1

" JavaScript
let g:SimpleJsIndenter_BriefMode = 1
let g:SimpleJsIndenter_CaseIndentLevel = -1

" Ruby
let g:ruby_no_expensive = 1

" Folding
" augroup: a
" function: f
let g:vimsyn_folding = 'af'
let g:tex_fold_enabled = 1
let g:xml_syntax_folding = 1
let g:php_folding = 2
let g:php_phpdoc_folding = 1
let g:perl_fold = 1

