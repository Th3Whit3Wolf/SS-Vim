if exists('did_load_filetypes')
	finish
endif

function! s:python_version()
	if getline(1) == '#!/usr/bin/env python3'
        let g:pymode_python = 'python3'
	elseif getline(1) == '#!/usr/bin/env pypy3'
        let g:pymode_python = 'python3'
    endif
endfunction

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
	autocmd BufNewFile,BufRead *.py                     setfiletype python call <SID>python_version()
augroup END
