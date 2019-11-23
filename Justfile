# Install Super Sayain Vim
install:
	#!/bin/bash
	mkdir -vp {{env_var_or_default('XDG_CACHE_HOME', '$HOME/.cache')}}/vim/backup
	mkdir -vp {{env_var_or_default('XDG_CACHE_HOME', '$HOME/.cache')}}/vim/session
	mkdir -vp {{env_var_or_default('XDG_CACHE_HOME', '$HOME/.cache')}}/vim/swap
	mkdir -vp {{env_var_or_default('XDG_CACHE_HOME', '$HOME/.cache')}}/vim/tags
	mkdir -vp {{env_var_or_default('XDG_CACHE_HOME', '$HOME/.cache')}}/vim/undo
	VIM=$(basename $(which nvim || which vim))
	if [ $VIM = "nvim" ]; then
		git clone https://github.com/k-takata/minpac.git \
    		~/.config/nvim/pack/minpac/opt/minpac
		nvim --cmd c 'CocInstall -sync coc-snippets coc-pairs coc-git coc-highlight coc-yank coc-explorer coc-word coc-syntax coc-dictionary coc-tag|q'
	elif [ $VIM = "vim" ]; then
		git clone https://github.com/k-takata/minpac.git \
    		~/.vim/pack/minpac/opt/minpac
		vim --cmd c 'CocInstall -sync coc-snippets coc-pairs coc-git coc-highlight coc-yank coc-explorer coc-word coc-syntax coc-dictionary coc-tag|q'
	fi

# Update Super Sayain Vim
update:
    @git pull --ff --ff-only;

# Same as Update
@upgrade: update

# Unistall Super Sayain Vim
uninstall:
	rm -rf {{env_var_or_default('XDG_CACHE_HOME', '$HOME/.cache')}}/vim
