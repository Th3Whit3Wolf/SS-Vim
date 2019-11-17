# Super Sayain Vim Config

Vim with Super Sayain Performance

Lean mean Neo/vim machine, 35-45ms startup time.

Best with Neovim or Vim 8 with +python3 extensions enabled.

## Features

- Fast startup time
- Robust, yet light-weight
- Use vim/neovim builtin package manager
- Lazy loading 36% of plugins (14/22)
- Watch code execute and automatically disappear (try it out! <kbd>F9</kbd>)
- Modular configuration
-  [Intellisense engine autocompletion](https://github.com/neoclide/coc.nvim)
- Excellent linting and language support
- Central location for tags

## Pre-requisites

- Python 3
- Python 2
- Neovim (Recommended)
- [Just](https://github.com/casey/just)
- yarn (for coc.vim)


## Install

**_1._** Let's clone this repo! Clone to `~/.config/nvim`,
we'll also symlink it for Vim:

```sh
mkdir ~/.config
git clone git://github.com/Th3Whit3Wolf/SS-Vim.git ~/.config/nvim
ln -s ~/.config/nvim ~/.vim
cd ~/.config/nvim 
just install
```

- _Note:_ If your system sets `$XDG_CONFIG_HOME`,
  use that instead of `~/.config` in the code above.
  Nvim follows the XDG base-directories convention.

**_2._** Install completion sources from below

Enjoy!

## Preinstalled Completion Sources
###### These are installed with `just install`

Install what you need by command `:CocInstall {name}`

- coc-dictionary

Words from files in `&dictionary`.

```vim
:CocInstall coc-dictionary
```

- coc-tag

Words from `tagfiles()`

```vim
:CocInstall coc-tag
```

- coc-word

Words from google 10000 english repo.

```vim
:CocInstall coc-word
```

- coc-syntax

Words from syntax list, see `:help ft-syntax-omni` in your vim.

```vim
:CocInstall coc-syntax
```

- coc-snippets

Load many different snippets

```vim
:CocInstall coc-snippets
```

- coc-git

Offers async git integration
Required for statusline to function properly

```vim
:CocInstall coc-git
```

- coc-pairs

Auto pair extension for coc.nvim

```vim
:CocInstall coc-pairs
```

- coc-explorer

File explorer extension for coc.nvim

```vim
:CocInstall coc-explorer
```

## Coc Extensions
You can find available coc extensions by searching[ coc.nvim on npm](https://www.npmjs.com/search?q=keywords%3Acoc.nvim), or use [coc-marketplace](https://github.com/fannheyward/coc-marketplace), which can search and install extensions in coc.nvim directly.

* **[coc-json](https://github.com/neoclide/coc-json)** for `json`.
* **[coc-tsserver](https://github.com/neoclide/coc-tsserver)** for `javascript` and `typescript`.
* **[coc-html](https://github.com/neoclide/coc-html)** for `html`, `handlebars` and `razor`.
* **[coc-css](https://github.com/neoclide/coc-css)** for `css`, `scss` and `less`.
* **[coc-ember](https://github.com/NullVoxPopuli/coc-ember)** for ember projects.
* **[coc-vetur](https://github.com/neoclide/coc-vetur)** for `vue`, use [vetur](https://github.com/vuejs/vetur).
* **[coc-phpls](https://github.com/marlonfan/coc-phpls)** for `php`, use [intelephense-docs](https://github.com/bmewburn/intelephense-docs).
* **[coc-java](https://github.com/neoclide/coc-java)** for `java`, use [eclipse.jdt.ls](https://github.com/eclipse/eclipse.jdt.ls).
* **[coc-solargraph](https://github.com/neoclide/coc-solargraph)** for `ruby`, use [solargraph](http://solargraph.org/).
* **[coc-rls](https://github.com/neoclide/coc-rls)** for `rust`, use [Rust Language Server](https://github.com/rust-lang/rls)
* **[coc-rust-analyzer](https://github.com/fannheyward/coc-rust-analyzer)** for `rust`, use [rust-analyzer](https://github.com/rust-analyzer/rust-analyzer)
* **[coc-r-lsp](https://github.com/neoclide/coc-r-lsp)** for `r`, use [R languageserver](https://github.com/REditorSupport/languageserver).
* **[coc-yaml](https://github.com/neoclide/coc-yaml)** for `yaml`
* **[coc-python](https://github.com/neoclide/coc-python)** for `python`, extension forked from [vscode-python](https://github.com/Microsoft/vscode-python).
* **[coc-highlight](https://github.com/neoclide/coc-highlight)** provides default document symbol highlighting and color support.
* **[coc-emmet](https://github.com/neoclide/coc-emmet)** provides emmet suggestions in completion list.
* **[coc-lists](https://github.com/neoclide/coc-lists)** provides some basic lists like fzf.vim.
* **[coc-yank](https://github.com/neoclide/coc-yank)** provides yank highlights & history.
* **[coc-fsharp](https://github.com/yatli/coc-fsharp)** for `fsharp`.
* **[coc-svg](https://github.com/iamcco/coc-svg)** for `svg`.
* **[coc-tailwindcss](https://github.com/iamcco/coc-tailwindcss)** for `tailwindcss`.
* **[coc-angular](https://github.com/iamcco/coc-angular)** for `angular`.
* **[coc-vimlsp](https://github.com/iamcco/coc-vimlsp)** for `viml`.
* **[coc-xml](https://github.com/fannheyward/coc-xml)** for `xml`, use [lsp4xml](https://github.com/angelozerr/lsp4xml).
* **[coc-elixir](https://github.com/amiralies/coc-elixir)** for `elixir`, based on [elixir-ls](https://github.com/JakeBecker/elixir-ls/).
* **[coc-erlang_ls](https://github.com/hyhugh/coc-erlang_ls)** for `erlang`, based on [erlang_ls](https://github.com/erlang-ls/erlang_ls)
* **[coc-tabnine](https://github.com/neoclide/coc-tabnine)** for [tabnine](https://tabnine.com/).
* **[coc-powershell](https://github.com/yatli/coc-powershell)** for PowerShellEditorService integration.
* **[coc-omnisharp](https://github.com/yatli/coc-omnisharp)** for `csharp` and `visualbasic`.
* **[coc-texlab](https://github.com/fannheyward/coc-texlab)** for `LaTex` using [TexLab](https://texlab.netlify.com/).
* **[coc-lsp-wl](https://github.com/voldikss/coc-lsp-wl)** for `wolfram mathematica`, fork of [vscode-lsp-wl](https://github.com/kenkangxgwe/vscode-lsp-wl).
* **[coc-flow](https://github.com/amiralies/coc-flow)** for [`flow`](https://flow.org)
* **[coc-reason](https://github.com/jaredly/reason-language-server/tree/master/editor-extensions/coc.nvim)** for [`reasonml`](https://reasonml.github.io/)
* **[coc-svelte](https://github.com/coc-extensions/coc-svelte)** for [`svelte`](https://github.com/sveltejs/svelte)
* **[coc-flutter](https://github.com/iamcco/coc-flutter)** for [`flutter`](https://github.com/flutter/flutter)
* **[coc-pyright](https://github.com/fannheyward/coc-pyright)** [Pyright](https://github.com/microsoft/pyright) extension
* **[coc-markdownlint](https://github.com/fannheyward/coc-markdownlint)** for markdown lintting
* **[coc-ecdict](https://github.com/fannheyward/coc-ecdict)** ECDICT extension

**Tips:** use `:CocConfig` to edit the configuration file. Completion & validation are supported after `coc-json` is installed.