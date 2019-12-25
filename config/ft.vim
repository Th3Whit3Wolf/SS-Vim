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
augroup END
=" Reload vim config automatically
execute 'autocmd MyAutoCmd BufWritePost '.$VIMPATH.'/config/*,vimrc nested'
	\ .' source $MYVIMRC | redraw'

augroup MyAutoCmd

	" Highlight current line only on focused window
	autocmd WinEnter,InsertLeave * set cursorline
	autocmd WinLeave,InsertEnter * set nocursorline

	" Automatically set read-only for files being edited elsewhere
	autocmd SwapExists * nested let v:swapchoice = 'o'

	" Check if file changed when its window is focus, more eager than 'autoread'
	autocmd WinEnter,FocusGained * checktime

	autocmd Syntax * if 5000 < line('$') | syntax sync minlines=200 | endif

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
		\ if &ft !~ '^git\c' && ! &diff && line("'\"") > 0 && line("'\"") <= line("$")
		\|   execute 'normal! g`"zvzz'
		\| endif

	autocmd TabLeave * let g:lasttab = tabpagenr()

	autocmd FileType crontab setlocal nobackup nowritebackup

	autocmd FileType css setlocal equalprg=csstidy\ -\ --silent=true

	autocmd FileType yaml.docker-compose setlocal expandtab

	autocmd FileType gitcommit setlocal spell

	autocmd FileType gitcommit,qfreplace setlocal nofoldenable

	" https://webpack.github.io/docs/webpack-dev-server.html#working-with-editors-ides-supporting-safe-write
	autocmd FileType css,javascript,jsx,javascript.jsx
		\ setlocal backupcopy=yes
		\| setlocal equalprg=jslint

	autocmd FileType zsh setlocal foldenable foldmethod=marker

	autocmd FileType html
		\ setlocal path+=./;/
		\ | setlocal equalprg=tidy\ -i\ -q

	autocmd FileType json setlocal equalprg=python\ -c\ json.tool

	"autocmd FileType markdown
	"	\ set expandtab
	"	\ | setlocal spell autoindent formatoptions=tcroqn2 comments=n:>

	autocmd FileType apache setlocal path+=./;/

	autocmd FileType cam setlocal nonumber synmaxcol=10000

	autocmd FileType go highlight default link goErr WarningMsg |
		\ match goErr /\<err\>/

	autocmd FileType xml
		\ setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

augroup END " }}}

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

autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
autocmd BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!
