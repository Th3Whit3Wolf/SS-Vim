VIM := `which nvim || which vim`

# Install Super Sayain Vim
install: venv initialize
	echo "Super Saiyan Vim Installed Sucessfully"

initialize: 
	mkdir -vp {{env_var_or_default('XDG_CACHE_HOME', '$HOME/.cache')}}/vim/backup
	mkdir -vp {{env_var_or_default('XDG_CACHE_HOME', '$HOME/.cache')}}/vim/session
	mkdir -vp {{env_var_or_default('XDG_CACHE_HOME', '$HOME/.cache')}}/vim/swap
	mkdir -vp {{env_var_or_default('XDG_CACHE_HOME', '$HOME/.cache')}}/vim/tags
	mkdir -vp {{env_var_or_default('XDG_CACHE_HOME', '$HOME/.cache')}}/vim/undo
	mkdir -vp {{env_var_or_default('XDG_CACHE_HOME', '$HOME/.cache')}}/vim/venv
	{{VIM}} -c 'PackUpdate'

# Update Super Sayain Vim
update:
    @git pull --ff --ff-only;

# Same as Update
@upgrade: update

# Unistall Super Sayain Vim
uninstall:
	rm -rf {{env_var_or_default('XDG_CACHE_HOME', '$HOME/.cache')}}/vim

# Create Python Virtual Environment
venv:
	#!/usr/bin/env bash
	venv="${XDG_CACHE_HOME:-$HOME/.cache}/vim/venv"
	# Try to detect python2/3 executables
	if ! hash python2 2>/dev/null; then
		echo "Python2 installation not found."
		exit 1
	elif ! hash python3 2>/dev/null; then
		echo "Python3 installation not found."
		exit 1
	fi
	# Ensure python 2/3 virtual environments
	[ -d "$venv" ] || mkdir -p "$venv"
	if hash pyenv 2>/dev/null && [ -d "$(pyenv root)/versions/neovim2" ] && [ -d "$(pyenv root)/versions/neovim3" ]; then
		# pyenv environments are setup so use them
		[ -d "$venv/neovim2" ] || ln -s "$(pyenv root)/versions/neovim2" "$venv/neovim2"
		[ -d "$venv/neovim3" ] || ln -s "$(pyenv root)/versions/neovim3" "$venv/neovim3"
	else
		[ -d "$venv/neovim2" ] || python2 -m virtualenv "$venv/neovim2"
		[ -d "$venv/neovim3" ] || python3 -m venv "$venv/neovim3"
	fi
	echo ":: PYTHON 2"
	"$venv/neovim2/bin/pip" install -U pynvim yapf autopep8 pylint prospector flake8 pylama
	echo -e '\n:: PYTHON 3'
	"$venv/neovim3/bin/pip" install -U pynvim yapf autopep8 pylint prospector flake8 pylama mypy

vimclap:
	#!/usr/bin/env bash
	fzy=$(which fzy)
	sk=$(which sk)
	if [ -z $fzy && -z $sk ]
	then
		echo "Install fzy and sk for even better fuzzing"
		{{VIM}} -c 'call clap#helper#build_rust_ext()|q'
	else
		echo "sk :" $sk
		echo "fzy:" $fzy
		{{VIM}} -c 'call clap#helper#build_all()|q'
	fi