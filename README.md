# Super Sayain Vim Config

Vim with Super Sayain Performance

Lean mean Neo/vim machine, 31-39ms startup time.

Best with Neovim or Vim 8 with +python3 extensions enabled.

## Features

- Robust, yet light-weight
- Use (neo)vim builtin package manager
- Fast Startup (31-39ms)
    - Lazy Loading 52% of plugins (30/58)
- Watch code execute and automatically disappear (try it out! <kbd>F9</kbd>)
- Modular configuration
- [Intellisense engine autocompletion](https://github.com/neoclide/coc.nvim)
- Ultimate Linting, Code Formating, & Language Support
- Central location for tags
- Awesome Startpage(thanks to [startify](https://github.com/mhinz/vim-startify))
- Markdown Previewer(custom css)
- Auto Shebang
- Code Runner & Compiler

## Screenshots
![](./img/ss-screenshot.png)
![](./img/ss-busy-screenshot.png)
## Pre-requisites

- Python 3
- Python 2
- Rust (curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh)
- Neovim (Recommended) / Vim 8+
- [Just](https://github.com/casey/just)
- yarn (for coc.vim)
- Your Compiler and/or Interpreter
- Your favorite Language Servers, Linters, Code Formatters

## Install

**_1._** Let's clone this repo! Clone to `~/.config/nvim`,
we'll also symlink it for Vim:

```sh
mkdir ~/.config
git clone git://github.com/Th3Whit3Wolf/SS-Vim.git ~/.config/nvim
cd ~/.config/nvim
ln -s ~/.config/nvim ~/.vim  # For Vim8
just install
```

- _Note:_ If your system sets `$XDG_CONFIG_HOME`,
  use that instead of `~/.config` in the code above.
  Nvim follows the XDG base-directories convention.

**_2._** Install extensions from below to get better autocompletion and linting

Enjoy!


## Auto Shebang

When creating a new shell or python (neo)vim will prompt you for what shebang you would like to use. It is automatic for ruby, perl, and php

You can press <kbd>F6</kbd> to change shebangs

### Shebangs

**Shell**

- bash - `#!/usr/bin/env bash`
- csh  - `#!/usr/bin/env csh`
- dash - `#!/usr/bin/env dash`
- fish - `#!/usr/bin/env fish`
- ion  - `#!/usr/bin/env ion`
- ksh  - `#!/usr/bin/env ksh`
- tcsh - `#!/usr/bin/env tcsh`
- zsh  - `#!/usr/bin/env zsh`

**Python**

- python2 - `#!/usr/bin/env python2`
- python3 - `#!/usr/bin/env python2`
- pypy    - `#!/usr/bin/env pypy`
- pypy3   - `#!/usr/bin/env pypy3`
- jython  - `#!/usr/bin/env jython`

**Ruby**

`#!/usr/bin/env ruby`

**Perl**

`#!/usr/bin/env perl`

**PHP**

`#!/usr/bin/env php`

## Compiler

Compiles your code.

Press <kbd>F9</kbd> to use

| Languages  | Compilers            |
| :--------- | :------------------- |
| C          | gcc                  |
| C++        | g++                  |
| Go         | go                   |
| Haskel     | ghc                  |
| Java       | javac                |
| Markdown   | pandoc               |
| Rust       | cargo, rustc         |

**Note** - `README.md`'s will be compiled with github styling

## Code Runner

Runs code in a buffer and then closes buffer after 5 seconds.

Press <kbd>F10</kbd> to use

| Languages  | Compilers/Interpreters |
| :--------- | :--------------------- |
| Bash       | bash                   |
| C          | gcc                    |
| C++        | g++                    |
| Csh        | csh                    |
| Dash       | dash                   |
| Fish       | fish                   |
| Go         | go                     |
| Haskel     | ghc                    |
| Ion        | ion                    |
| Java       | javac                  |
| Javascript | node                   |
| Ksh        | ksh                    |
| Lhaskel    | ghc                    |
| Perl       | perl                   |
| PHP        | php                    |
| Python     | python2, python3, pypy2, pypy3, jython |
| Ruby       | ruby                   |
| Rust       | cargo, rustc           |
| Tcsh       | tcsh                   |
| Tex        | pdflatex               |
| Zsh        | zsh                    |


## Custom Mappings

## Credits
I owe a specail thanks to the following projects:

- [Minpac](https://github.com/k-takata/minpac) - minimal package manager for Vim 8 (and Neovim)
- [Coc](https://github.com/neoclide/coc.nvim) - Intellisense engine for vim8 & neovim, full language server protocol support as VSCode 
    - SS-vim uses coc and a lot of it's extensions (most lazily loaded) to provide great out of the box support for a large variety of languages. Including Code Completion, Jump to Definition, Workspace Symbols, Find Refernces, Diagnostics, Linting, and Code Formatting on Save.
- [Sprint](https://github.com/pedsm/sprint) - Async File Runner
    - Gave me idea to compile markdown `README.md` with github style
    - Gave me github.css
- [Async Run](https://github.com/skywind3000/asyncrun.vim) - 
Run Async Shell Commands in Vim 8.0 / NeoVim and Output to Quickfix Window
    - Powers SS-vim Code Runner and Compiler
- [ALE](https://github.com/dense-analysis/ale) - Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
    - Can lint when Coc can't.
- [Neoformat](https://github.com/sbdchd/neoformat) - A (Neo)vim plugin for formatting code.
    - Provides code formating when Coc can't.
- [Vim Buffet](https://github.com/bagrat/vim-buffet) and [Spaceline](https://github.com/hardcoreplayers/spaceline.vim) - Provide an IDE-like Vim tabline & vim statusline like spacemacs 
    - Provides beautiful UI
- [Vim Clap](https://github.com/liuchengxu/vim-clap) - Modern generic interactive finder and dispatcher for Vim and NeoVim 
    - Extraordinarily fast interactive finder and dispatcher