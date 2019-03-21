# Super Sayain Vim Config

Vim with Super Sayain Performance

Lean mean Neo/vim machine, 30-45ms startup time.

Best with Neovim or Vim 8 with +python3 extensions enabled.

## Features

- Fast startup time
- Robust, yet light-weight
- Lazy-load 95% of plugins with [Shougo/dein.vim]
- Watch code execute and automatically disappear (try it out! <kbd>F9</kbd>)
- Modular configuration
- Native autocompletion with Mucomplete and LanguageClient-neovim
- Lightweight simple status/tabline
- Easy customizable theme
- Premium color-schemes
- Central location for tags

## Screenshot

#### Coming Soon

## Pre-requisites

- Python 3 (`brew install python`)
- Python 2 (`brew install python@2`)
- Neovim (Optional, `brew install neovim`)
- virtualenv for both python3 and python2:
  ```
  pip2 install virtualenv
  pip3 install virtualenv
  ```

## Install

**_1._** Let's clone this repo! Clone to `~/.config/nvim`,
we'll also symlink it for Vim:

```sh
mkdir ~/.config
git clone git://github.com/TheWhiteWolf1337/SS-Vim.git ~/.config/nvim
ln -s ~/.config/nvim ~/.vim
```

- _Note:_ If your system sets `$XDG_CONFIG_HOME`,
  use that instead of `~/.config` in the code above.
  Nvim follows the XDG base-directories convention.

**_2._** If you are a _first-time Neovim user_, you need the pynvim
packages. Don't worry, run the script provided:

```sh
cd ~/.config/nvim
./venv.sh
```

**_3._** Run `make test` to test your nvim/vim version and compatibility.

**_4._** Run `make` to install all plugins.

Enjoy!

### Recommended Linters

#### - C/C++/Objective-C linters:
install [ccls](https://github.com/MaskRay/ccls) and clang
[cquery](https://github.com/cquery-project/cquery) also work but not as well as [ccls]([ccls](https://github.com/MaskRay/ccls))

#### - D linters:
```sh
dub build
```
or
```sh
dub fetch dls
dub run dls:bootstrap
```

#### - Dart based linters:
```sh
pub global activate dart_language_server
```

#### - Go based linters:
```sh
git clone https://github.com/saibing/bingo.git
cd bingo
GO111MODULE=on go install
```
or
```sh
go get -u github.com/sourcegraph/go-langserver
```

### - Haskell
[haskell-ide-engine](https://github.com/haskell/haskell-ide-engine)

#### - PHP linters:
install impose
```sh
composer require felixfbecker/language-server
composer run-script --working-dir=vendor/felixfbecker/language-server parse-stubs
```

#### - Puppet
```sh
git clone https://github.com/lingua-pupuli/puppet-editor-services.git
cd puppet-editor-services
bundle install
```

#### - Python based linters:
```sh
sudo pip3 install -U setuptools
sudo pip3 install fortran-language-server pyflakes mccabe pycodestyle  pydocstyle autopep8 yapf isort 'python-language-server[all]' pyls-mypy pyls-black
```

#### - Lua
```sh
luarocks install --server=http://luarocks.org/dev lua-lsp
```

#### - Nim
```sh
nimble install nimlsp
```

#### - Node.js based linters:
```sh
sudo npm i -g bash-language-server typescript-language-server vsce purescript-language-server vue-language-server vscode-css-languageserver-bin json-language-server dockerfile-language-server-nodejs ocaml-language-server
```

#### - Ruby based linters:
```sh
gem install solargraph
```
or
```sh
gem install orbacle
```

#### - Rust
```sh
rustup update
rustup component add rls rust-analysis rust-src
```

### Side Note
 If you are using Arch Linux or and other Linux Distribution that uses Ncurses 6+ instead it may be necessary to link it to the Ncurses 5 library
 ```sh
sudo ln -s /usr/lib/libtinfo.so.6 /usr/lib/libtinfo.so.5
 ```

### Recommended Tools

- Universal ctags: [ctags.io](https://ctags.io/)
- Fuzzy file finders: [fzf](https://github.com/junegunn/fzf), [fzy](https://github.com/jhawthorn/fzy), or [peco](https://github.com/peco/peco)

## Upgrade

Run `make update`

## Structure

- [config/](./config) - Configuration
  - [plugins/](./config/plugins) - Plugin configurations
  - [plugins.yaml](./config/plugins.yaml) - _**Plugins!**_
  - [vimrc](./config/vimrc) - Initialization
  - [init.vim](./config/init.vim) - `runtimepath` initialization
  - [general.vim](./config/general.vim) - General configuration
  - [neovim.vim](./config/neovim.vim) - Neovim specific setup
  - [mappings.vim](./config/mappings.vim) - Key-mappings
  - [theme.vim](./config/theme.vim) - Color-scheme and theme setup
  - [filetype.vim](./config/filetype.vim) - Language behavior
- [ftplugin/](./ftplugin) - Language specific custom settings
- [plugin/](./plugin) - Customized small plugins
- [themes/](./themes) - Themes! Combination of styles and color-scheme
- [filetype.vim](./filetype.vim) - Custom filetype detection

## Plugin Highlights

- Package management with caching enabled and lazy loading
- Project-aware tabs and label
- Support for nearlly all Language Servers
- Statusline depends on the set theme
- Linting will switch between LanguageClient-neovim & ALE, depending on if Language Servers are installed
- Fastest possible autocompletion with LanguageClient-neovim and Mucomplete
- Formats code on save
- Languages: Basically all of them

_Note_ that 95% of the plugins are **[lazy-loaded]**.

## Non Lazy-Loaded Plugins

| Name                        | Description                                                        |
| --------------------------- | ------------------------------------------------------------------ |
| [Shougo/dein.vim]           | Dark powered Vim/Neovim plugin manager                             |
| [liuchengxu/space-vim-dark] | Space-vim-dark colorscheme inspired by Spacemacs                   |
| [w0rp/ale]                  | Asynchronous linting/fixing                                        |
| [ryanoasis/vim-devicons]    | Adds file type glyphs to popular vim plugins                       |
| [SirVer/ultisnips]          | Ultimate Solution for snippets in vim                              |
| [lifepillar/vim-mucomplete] | Minimalistic autocompletor for vim                                 |
| [tpope/vim-fugitive]        | A Git wrapper so awesome, it should be illegal                     |
| [Yggdroot/indentLine]       | Display the indention levels with thin vertical lines              |
| [jiangmiao/auto-pairs]      | Insert or delete brackets, parens, quotes in pairs                 |
| [chrisbra/Colorizer]        | Highlight color names & codes in the color they represent          |
| [roxma/nvim-yarp]           | Remote Plugin Framework for Neovim (Loads in Vim8 only)            |
| [roxma/vim-hug-neovim-rpc]  | Vim8 compatibility layer for neovim rpc client(Loads in Vim8 only) |
| [mhinz/vim-startify]        | Fancy Start screen for vim                                         |

## Lazy-Loaded Plugins

### Theme

| Name                               | Description                                   |
| ---------------------------------- | --------------------------------------------- |
| [FriedPandaFries/Lightline-Extras] | A few extra lightline themes                  |
| [itchyny/lightline.vim]            | A light and configurable plugin for Vim       |
| [vim-airline/vim-airline]          | Lean and mean statusline that's light as air. |
| [vim-airline/vim-airline-themes]   | A collection of themes for vim-airline        |

### Linters

| Name                             | Description                              |
| -------------------------------- | ---------------------------------------- |
| [autozimu/LanguageClient-neovim] | Language Client support for vim & neovim |
| [w0rp/ale]                       | Asynchronous Linting Engine              |

### Formatter

| Name               | Description                            |
| ------------------ | -------------------------------------- |
| [sbdchd/neoformat] | A (Neo)vim plugin for formatting code. |


### Language

| Name                                 | Description                                                          |
| ------------------------------------ | -------------------------------------------------------------------- |
| [othree/html5.vim]                   | HTML5 omnicomplete and syntax                                        |
| [mustache/vim-mustache-handlebars]   | Mustache and handlebars syntax                                       |
| [pearofducks/ansible-vim]            | Improved YAML support for Ansible                                    |
| [groenewege/vim-less]                | Syntax for LESS                                                      |
| [hail2u/vim-css3-syntax]             | CSS3 syntax support to vim's  `syntax/css.vim`                       |
| [othree/csscomplete.vim]             | Updated  CSS complete with latest standards                          |
| [cakebaker/scss-syntax.vim]          | Syntax file for scss (Sassy CSS)                                     |
| [ap/vim-css-color]                   | Preview colors in source-code while editing                          |
| [plasticboy/vim-markdown]            | Markdown syntax highlighting                                         |
| [rhysd/vim-gfm-syntax]               | GitHub Flavored Markdown syntax highlighting                         |
| [pangloss/vim-javascript]            | Enhanced Javascript syntax                                           |
| [othree/jspc.vim]                    | JavaScript Parameter Complete                                        |
| [posva/vim-vue]                      | Syntax Highlight for Vue.js components                               |
| [heavenshell/vim-jsdoc]              | Generate JSDoc to your JavaScript code                               |
| [jparise/vim-graphql]                | GraphQL detection, syntax highlighting, & indentation                |
| [moll/vim-node]                      | Superb development with Node.js                                      |
| [elzr/vim-json]                      | Better JSON support                                                  |
| [Quramy/vison]                       | Plugin for writing JSON with JSON Schema                             |
| [digitaltoad/vim-pug]                | Vim syntax highlighting for Pug templates                            |
| [dNitro/vim-pug-complete]            | Vim omni-completion support for pug template engine                  |
| [ElmCast/elm-vim]                    | Elm syntax-hl, completion, formatting, linting, etc                  |
| [mrk21/yaml-vim]                     | YAML syntax/indent plugin                                            |
| [kchmck/vim-coffee-script]           | Coffescript syntax, identing, compiling, and more support            |
| [Quramy/tsuquyomi]                   | Typescript TSServer client                                           |
| [ianks/vim-tsx]                      | Syntax highlighting and indenting for tsx                            |
| [leafgarland/typescript-vim]         | Syntax file and other settings for Typescript                        |
| [aklt/plantuml-syntax]               | Syntax file for PlantUML                                             |
| [vim-ruby/vim-ruby]                  | Syntax, indention, and compiler for ruby                             |
| [neoclide/vim-jsx-improve]           | Syntax and indent plugin for React JSX                               |
| [xuhdev/vim-latex-live-preview]      | Vim plugin for live previewing LaTeX PDF Output                      |
| [skywind3000/asyncrun.vim]           | Run Async Shell Commands in (Neo)vim                                 |
| [euclio/vim-markdown-composer]       | An Asynchronous markdown preview plugin for (Neo)vim                 |
| [bazelbuild/vim-bazel]               | Plugin for invoking bazel and interacting with bazel artifacts       |
| [google/vim-maktaba]                 | Vimscript plugin library                                             |
| [Shirk/vim-gas]                      | Syntax highlighting for GNU Assmebly                                 |
| [OmniSharp/omnisharp-vim]            | Vim Omnicompletion(intellisense) and more for C#                     |
| [bfrg/vim-cpp-modern]                | Additional Vim syntax highlighting for C++                           |
| [vim-jp/vim-cpp]                     | C/C++ Syntax Highlighting                                            |
| [pboettch/vim-cmake-syntax]          | Vim syntax highlighting rules for modern CMake                       |
| [rust-lang/rust.vim]                 | Rust lang Syntax highlighting, formatting, and file detection        |
| [racer-rust/vim-racer]               | Rust Racer autocompletion support                                    |
| [keith/swift.vim]                    | Swift syntax and indenting support                                   |
| [guns/vim-clojure-highlight]         | Extend builtin syntax highlighting for Closure                       |
| [guns/vim-clojure-static]            | Meikel Brandmeyer's excellent Clojure runtime files                  |
| [guns/vim-slamhound]                 | Slamhound integration for vim                                        |
| [kovisoft/paredit]                   | Maintains balanced state for matched characters(parens, quotes, etc) |
| [tpope/vim-fireplace]                | Clojure REPL Support                                                 |
| [venantius/vim-cljfmt]               | Vim plugin for Clojure formatting tool                               |
| [elixir-lang/vim-elixir]             | Elixir file detectiong, automatic indentation, syntax highlighting   |
| [slashmili/alchemist.vim]            | Elixir completion, Doc lookups, jump to def, etc                     |
| [vim-erlang/erlang-motions.vim]      |                                                                      |
| [vim-erlang/vim-erlang-compiler]     |                                                                      |
| [vim-erlang/vim-erlang-omnicomplete] | Erlang omnicomplete plugin for (Neo)vim                              |
| [vim-erlang/vim-erlang-skeletons]    |                                                                      |
| [vim-erlang/vim-erlang-tags]         |                                                                      |
| [derekwyatt/vim-scala]               |                                                                      |
| [udalov/kotlin-vim]                  |                                                                      |
| [rhysd/vim-clang-format]             |                                                                      |
| [eagletmt/ghcmod-vim]                |                                                                      |
| [dan-t/vim-hsimport]                 |                                                                      |
| [neovimhaskell/haskell-vim]          |                                                                      |
| [parsonsmatt/intero-neovim]          |                                                                      |
| [tclh123/vim-thrift]                 |                                                                      |
| [MaxMEllon/vim-jsx-pretty]           | React JSX syntax pretty highlighting                                 |
| [fatih/vim-go]                       | Go development                                                       |
| [timothycrosley/isort]               |                                                                      |
| [vim-python/python-syntax]           | Enhanced version of the original Python syntax                       |
| [Vimjas/vim-python-pep8-indent]      | A nicer Python indentation style                                     |
| [vim-scripts/python_match.vim]       | Extend the % motion for Python files                                 |
| [tmhedberg/SimpylFold]               | No-BS Python code folding                                            |
| [raimon49/requirements.txt.vim]      | Python requirements file format                                      |
| [StanAngeloff/php.vim]               | Up-to-date PHP syntax file (5.3 – 7.1 support)                       |
| [shawncplus/phpcomplete.vim]         | PHP completion                                                       |
| [osyo-manga/vim-monster]             | Ruby code completion                                                 |
| [tbastos/vim-lua]                    | Improved Lua 5.3 syntax and indentation support                      |
| [toyamarinyon/vim-swift]             | Swift support                                                        |
| [vim-jp/syntax-vim-ex]               | Improved Vim syntax highlighting                                     |
| [chrisbra/csv.vim]                   | Handling column separated data                                       |
| [tpope/vim-git]                      | Git runtime files                                                    |
| [ekalinin/Dockerfile.vim]            | syntax and snippets for Dockerfile                                   |
| [tmux-plugins/vim-tmux]              | vim plugin for tmux.conf                                             |
| [andreshazard/vim-logreview]         | Bueatify log viewing                                                 |
| [hashivim/vim-terraform]             | Base Terraform integration                                           |
| [cespare/vim-toml]                   | Syntax for TOML                                                      |
| [mboughaba/i3config.vim]             | i3 window manager config syntax                                      |
| [dag/vim-fish]                       | Fish shell edit support                                              |
| [jstrater/mpvim]                     | Macports portfile configuration files                                |
| [robbles/logstash.vim]               | Highlights logstash configuration files                              |
| [exu/pgsql.vim]                      | PostgreSQL syntax                                                    |
| [othree/nginx-contrib-vim]           | Fork official vim nginx                                              |
| [IN3D/vim-raml]                      | Syntax and language settings for RAML                                |
| [kylef/apiblueprint.vim]             |                                                                      |
| [vmchale/ion-vim]                    | Syntax highlighting for ion shell                                    |
| [liuchengxu/graphviz.vim]            |                                                                      |

### Commands

| Name                              | Description                                              |
| --------------------------------- | -------------------------------------------------------- |
| [Shougo/defx.nvim]                | Dark powered file explorer implementation                |
| [kristijanhusak/defx-git]         | Git status implementation for Defx                       |
| [kristijanhusak/defx-icons]       | Filetype icons for Defx                                  |
| [t9md/vim-choosewin]              | Choose window to use, like tmux's 'display-pane'         |
| [kana/vim-niceblock]              | Make blockwise Visual mode more useful                   |
| [guns/xterm-color-table.vim]      | Display 256 xterm colors with their RGB equivalents      |
| [mbbill/undotree]                 | Ultimate undo history visualizer                         |
| [metakirby5/codi.vim]             | The interactive scratchpad for hackers                   |
| [Shougo/vimproc.vim]              | Interactive command execution                            |
| [reedes/vim-wordy]                | Uncover usage problems in your writing                   |
| [brooth/far.vim]                  | Fast find and replace plugin                             |
| [jreybert/vimagit]                | Ease your git work-flow within Vim                       |
| [tweekmonster/helpful.vim]        | Display vim version numbers in docs                      |
| [lambdalisue/gina.vim]            | Asynchronously control git repositories                  |
| [cocopon/colorswatch.vim]         | Generate a beautiful color swatch for the current buffer |
| [kana/vim-altr]                   | Switch to the alternate file without interaction         |
| [lambdalisue/suda.vim]            | An alternative sudo.vim for Vim and Neovim               |
| [tyru/open-browser.vim]           | Open URI with your favorite browser                      |
| [tyru/open-browser-unicode.vim]   | Open info page about character on current cursor         |
| [tyru/open-browser-github.vim]    | Open GitHub URL of current file                          |
| [tyru/caw.vim]                    | Robust comment plugin with operator support              |
| [Shougo/vinarise.vim]             | Hex editor                                               |
| [mzlogin/vim-markdown-toc]        | Generate table of contents for Markdown files            |
| [easymotion/vim-easymotion]       | Vim motions on speed                                     |
| [chemzqm/vim-easygit]             | Git wrapper focus on simplity and usability              |
| [majutsushi/tagbar]               | Displays tags in a window, ordered by scope              |
| [beloglazov/vim-online-thesaurus] | Look up words in an online thesaurus                     |

### Interface

| Name                                      | Description                                                           |
| ----------------------------------------- | --------------------------------------------------------------------- |
| [t9md/vim-quickhl]                        | Quickly highlight words                                               |
| [airblade/vim-gitgutter]                  | Show git changes at Vim gutter and un/stages hunks                    |
| [nathanaelkane/vim-indent-guides]         | Visually display indent levels in code                                |
| [lambdalisue/vim-improve-diff]            | Improve diff experience                                               |
| [junegunn/goyo]                           | Distraction-free writing                                              |
| [junegunn/limelight]                      | Hyperfocus-writing                                                    |
| [vimwiki/vimwiki]                         | Personal Wiki for Vim                                                 |
| [wsdjeg/dein-ui.vim]                      |                                                                       |
| [FriedPandaFries/nerdtree]                | Nerd Tree where <kbd>ctrl</kbd> `+` <kbd>h</kbd> toggles hidden files |
| [Xuyuanp/nerdtree-git-plugin]             |                                                                       |
| [tiagofumo/vim-nerdtree-syntax-highlight] |                                                                       |


### Completion

| Name                                    | Description                                            |
| --------------------------------------- | ------------------------------------------------------ |
| [ludovicchabant/vim-gutentags]          | Manages your tag files                                 |
| [mattn/emmet-vim]                       | Provides support for expanding abbreviations alá emmet |
| [juliosueiras/vim-terraform-completion] | Autocompletion and linter for Terraform                |



[Shougo/dein.vim]: https://github.com/Shougo/dein.vim
[liuchengxu/space-vim-dark]:https://github.com/liuchengxu/space-vim-dark
[w0rp/ale]:https://github.com/w0rp/ale
[thinca/vim-localrc]: https://github.com/thinca/vim-localrc
[tpope/vim-fugitive]:https://github.com/tpope/vim-fugitive
[Yggdroot/indentLine]:https://github.com/Yggdroot/indentLine
[jiangmiao/auto-pairs]:https://github.com/jiangmiao/auto-pairs
[chrisbra/Colorizer]:https://github.com/chrisbra/Colorizer
[FriedPandaFries/Lightline-Extras]:https://github.com/FriedPandaFries/Lightline-Extras
[christoomey/tmux-navigator]: https://github.com/christoomey/vim-tmux-navigator
[junegunn/vim-peekaboo]: https://github.com/junegunn/vim-peekaboo
[tpope/vim-sleuth]: https://github.com/tpope/vim-sleuth
[sgur/vim-editorconfig]: https://github.com/sgur/vim-editorconfig
[itchyny/lightline.vim]: https://github.com/itchyny/lightline.vim
[itchyny/vim-parenmatch]: https://github.com/itchyny/vim-parenmatch
[itchyny/cursorword]: https://github.com/itchyny/vim-cursorword
[roxma/nvim-yarp]: https://github.com/roxma/nvim-yarp
[roxma/vim-hug-neovim-rpc]: https://github.com/roxma/vim-hug-neovim-rpc

[othree/html5.vim]: https://github.com/othree/html5.vim
[mustache/vim-mustache-handlebars]: https://github.com/mustache/vim-mustache-handlebars
[pearofducks/ansible-vim]: https://github.com/pearofducks/ansible-vim
[groenewege/vim-less]: https://github.com/groenewege/vim-less
[hail2u/vim-css3-syntax]: https://github.com/hail2u/vim-css3-syntax
[othree/csscomplete.vim]: https://github.com/othree/csscomplete.vim
[cakebaker/scss-syntax.vim]: https://github.com/cakebaker/scss-syntax.vim
[ap/vim-css-color]: https://github.com/ap/vim-css-color
[plasticboy/vim-markdown]: https://github.com/plasticboy/vim-markdown
[rhysd/vim-gfm-syntax]: https://github.com/rhysd/vim-gfm-syntax
[pangloss/vim-javascript]: https://github.com/pangloss/vim-javascript
[othree/jspc.vim]: https://github.com/othree/jspc.vim
[posva/vim-vue]: https://github.com/posva/vim-vue
[heavenshell/vim-jsdoc]: https://github.com/heavenshell/vim-jsdoc
[jparise/vim-graphql]: https://github.com/jparise/vim-graphql
[moll/vim-node]: https://github.com/moll/vim-node
[elzr/vim-json]: https://github.com/elzr/vim-json
[MaxMEllon/vim-jsx-pretty]: https://github.com/MaxMEllon/vim-jsx-pretty
[fatih/vim-go]: https://github.com/fatih/vim-go
[vim-python/python-syntax]: https://github.com/vim-python/python-syntax
[Vimjas/vim-python-pep8-indent]: https://github.com/Vimjas/vim-python-pep8-indent
[vim-scripts/python_match.vim]: https://github.com/vim-scripts/python_match.vim
[tmhedberg/SimpylFold]: https://github.com/tmhedberg/SimpylFold
[raimon49/requirements.txt.vim]: https://github.com/raimon49/requirements.txt.vim
[StanAngeloff/php.vim]: https://github.com/StanAngeloff/php.vim
[shawncplus/phpcomplete.vim]: https://github.com/shawncplus/phpcomplete.vim
[osyo-manga/vim-monster]: https://github.com/osyo-manga/vim-monster
[tbastos/vim-lua]: https://github.com/tbastos/vim-lua
[toyamarinyon/vim-swift]: https://github.com/toyamarinyon/vim-swift
[vim-jp/syntax-vim-ex]: https://github.com/vim-jp/syntax-vim-ex
[chrisbra/csv.vim]: https://github.com/chrisbra/csv.vim
[tpope/vim-git]: https://github.com/tpope/vim-git
[ekalinin/Dockerfile.vim]: https://github.com/ekalinin/Dockerfile.vim
[tmux-plugins/vim-tmux]: https://github.com/tmux-plugins/vim-tmux
[andreshazard/vim-logreview]: https://github.com/andreshazard/vim-logreview
[hashivim/vim-terraform]: https://github.com/hashivim/vim-terraform
[cespare/vim-toml]: https://github.com/cespare/vim-toml
[mboughaba/i3config.vim]: https://github.com/mboughaba/i3config.vim
[dag/vim-fish]: https://github.com/dag/vim-fish
[jstrater/mpvim]: https://github.com/jstrater/mpvim
[robbles/logstash.vim]: https://github.com/robbles/logstash.vim
[exu/pgsql.vim]: https://github.com/exu/pgsql.vim
[othree/nginx-contrib-vim]: https://github.com/othree/nginx-contrib-vim
[IN3D/vim-raml]: https://github.com/IN3D/vim-raml

[Shougo/defx.nvim]: https://github.com/Shougo/defx.nvim
[kristijanhusak/defx-git]: https://github.com/kristijanhusak/defx-git
[kristijanhusak/defx-icons]: https://github.com/kristijanhusak/defx-icons
[t9md/vim-choosewin]: https://github.com/t9md/vim-choosewin
[kana/vim-niceblock]: https://github.com/kana/vim-niceblock
[guns/xterm-color-table.vim]: https://github.com/guns/xterm-color-table.vim
[mbbill/undotree]: https://github.com/mbbill/undotree
[metakirby5/codi.vim]: https://github.com/metakirby5/codi.vim
[Shougo/vimproc.vim]: https://github.com/Shougo/vimproc.vim
[reedes/vim-wordy]: https://github.com/reedes/vim-wordy
[brooth/far.vim]: https://github.com/brooth/far.vim
[jreybert/vimagit]: https://github.com/jreybert/vimagit
[tweekmonster/helpful.vim]: https://github.com/tweekmonster/helpful.vim
[lambdalisue/gina.vim]: https://github.com/lambdalisue/gina.vim
[cocopon/colorswatch.vim]: https://github.com/cocopon/colorswatch.vim
[kana/vim-altr]: https://github.com/kana/vim-altr
[lambdalisue/suda.vim]: https://github.com/lambdalisue/suda.vim
[tyru/open-browser.vim]: https://github.com/tyru/open-browser.vim
[tyru/open-browser-unicode.vim]: https://github.com/tyru/open-browser-unicode.vim
[tyru/open-browser-github.vim]: https://github.com/tyru/open-browser-github.vim
[tyru/caw.vim]: https://github.com/tyru/caw.vim
[Shougo/vinarise.vim]: https://github.com/Shougo/vinarise.vim
[mzlogin/vim-markdown-toc]: https://github.com/mzlogin/vim-markdown-toc
[easymotion/vim-easymotion]: https://github.com/easymotion/vim-easymotion
[chemzqm/vim-easygit]: https://github.com/chemzqm/vim-easygit
[majutsushi/tagbar]: https://github.com/majutsushi/tagbar
[beloglazov/vim-online-thesaurus]: https://github.com/beloglazov/vim-online-thesaurus

[haya14busa/vim-asterisk]: https://github.com/haya14busa/vim-asterisk
[rhysd/accelerated-jk]: https://github.com/rhysd/accelerated-jk
[haya14busa/vim-edgemotion]: https://github.com/haya14busa/vim-edgemotion
[t9md/vim-quickhl]: https://github.com/t9md/vim-quickhl
[rafi/vim-sidemenu]: https://github.com/rafi/vim-sidemenu
[airblade/vim-gitgutter]: https://github.com/airblade/vim-gitgutter
[nathanaelkane/vim-indent-guides]: https://github.com/nathanaelkane/vim-indent-guides
[MattesGroeger/vim-bookmarks]: https://github.com/MattesGroeger/vim-bookmarks
[hotwatermorning/auto-git-diff]: https://github.com/hotwatermorning/auto-git-diff
[rhysd/committia.vim]: https://github.com/rhysd/committia.vim
[benekastah/neomake]: https://github.com/neomake/neomake
[lambdalisue/vim-improve-diff]: https://github.com/lambdalisue/vim-improve-diff
[junegunn/goyo]: https://github.com/junegunn/goyo.vim
[junegunn/limelight]: https://github.com/junegunn/limelight.vim
[itchyny/calendar.vim]: https://github.com/itchyny/calendar.vim
[vimwiki/vimwiki]: https://github.com/vimwiki/vimwiki

[Shougo/deoplete.nvim]: https://github.com/Shougo/deoplete.nvim
[Shougo/neosnippet.vim]: https://github.com/Shougo/neosnippet.vim
[ludovicchabant/vim-gutentags]: https://github.com/ludovicchabant/vim-gutentags
[mattn/emmet-vim]: https://github.com/mattn/emmet-vim
[Shougo/echodoc.vim]: https://github.com/Shougo/echodoc.vim
[Raimondi/delimitMate]: https://github.com/Raimondi/delimitMate
[Shougo/neosnippet-snippets]: https://github.com/Shougo/neosnippet-snippets
[Shougo/context_filetype.vim]: https://github.com/Shougo/context_filetype.vim
[Shougo/neco-vim]: https://github.com/Shougo/neco-vim
[Shougo/neoinclude.vim]: https://github.com/Shougo/neoinclude.vim
[Shougo/neco-syntax]: https://github.com/Shougo/neco-syntax
[davidhalter/jedi-vim]: https://github.com/davidhalter/jedi-vim
[zchee/deoplete-go]: https://github.com/zchee/deoplete-go
[zchee/deoplete-jedi]: https://github.com/zchee/deoplete-jedi
[carlitux/deoplete-ternjs]: https://github.com/carlitux/deoplete-ternjs
[wellle/tmux-complete.vim]: https://github.com/wellle/tmux-complete.vim
[fszymanski/deoplete-emoji]: https://github.com/fszymanski/deoplete-emoji
[juliosueiras/vim-terraform-completion]: https://github.com/juliosueiras/vim-terraform-completion
[ternjs/tern_for_vim]: https://github.com/ternjs/tern_for_vim

[Shougo/denite.nvim]: https://github.com/Shougo/denite.nvim
[nixprime/cpsm]: https://github.com/nixprime/cpsm
[Shougo/neoyank.vim]: https://github.com/Shougo/neoyank.vim
[Shougo/junkfile.vim]: https://github.com/Shougo/junkfile.vim
[chemzqm/unite-location]: https://github.com/chemzqm/unite-location
[chemzqm/denite-git]: https://github.com/chemzqm/denite-git
[rafi/vim-denite-z]: https://github.com/rafi/vim-denite-z
[rafi/vim-denite-session]: https://github.com/rafi/vim-denite-session
[rafi/vim-denite-mpc]: https://github.com/rafi/vim-denite-mpc

[kana/vim-operator-user]: https://github.com/kana/vim-operator-user
[kana/vim-operator-replace]: https://github.com/kana/vim-operator-replace
[rhysd/vim-operator-surround]: https://github.com/rhysd/vim-operator-surround
[haya14busa/vim-operator-flashy]: https://github.com/haya14busa/vim-operator-flashy
[kana/vim-textobj-user]: https://github.com/kana/vim-textobj-user
[terryma/vim-expand-region]: https://github.com/terryma/vim-expand-region
[AndrewRadev/sideways.vim]: https://github.com/AndrewRadev/sideways.vim
[AndrewRadev/splitjoin.vim]: https://github.com/AndrewRadev/splitjoin.vim
[AndrewRadev/linediff.vim]: https://github.com/AndrewRadev/linediff.vim
[AndrewRadev/dsf.vim]: https://github.com/AndrewRadev/dsf.vim
[osyo-manga/vim-textobj-multiblock]: https://github.com/osyo-manga/vim-textobj-multiblock
[kana/vim-textobj-function]: https://github.com/kana/vim-textobj-function

## Custom Key-mappings

Note that,

- Leader key is set as <kbd>Space</kbd>

| Key                   |     Mode      | Action                                                          |
| --------------------- | :-----------: | --------------------------------------------------------------- |
| `Space`               |     _All_     | **Leader**                                                      |
| Arrows                |    Normal     | Resize splits (* Enable `g:elite_mode` in `.vault.vim`)         |
| `Backspace`           |    Normal     | Match bracket (%)                                               |
| `K`                   |    Normal     | Open Zeal or Dash on some file types (except Python+Vim script) |
| `Y`                   |    Normal     | Yank to the end of line (y$)                                    |
| `<Return>`            |    Normal     | Toggle fold (za)                                                |
| `S`+`<Return>`        |    Normal     | Focus the current fold by closing all others (zMza)             |
| `S`+`<Return>`        |    Insert     | Start new line from any cursor position (\<C-o>o)               |
| `hjkl`                |    Normal     | Smart cursor movements (g/hjkl)                                 |
| `Ctrl`+`f`            |    Normal     | Smart page forward (C-f/C-d)                                    |
| `Ctrl`+`b`            |    Normal     | Smart page backwards (C-b/C-u)                                  |
| `Ctrl`+`e`            |    Normal     | Smart scroll down (3C-e/j)                                      |
| `Ctrl`+`y`            |    Normal     | Smart scroll up (3C-y/k)                                        |
| `Ctrl`+`q`            |    Normal     | Remap to `Ctrl`+`w`                                             |
| `Ctrl`+`x`            |    Normal     | Rotate window placement                                         |
| `!`                   |    Normal     | Shortcut for `:!`                                               |
| `}`                   |    Normal     | After paragraph motion go to first non-blank char (}^)          |
| `<`                   | Visual/Normal | Indent to left and re-select                                    |
| `>`                   | Visual/Normal | Indent to right and re-select                                   |
| `Tab`                 | Visual/Normal | Indent to right and re-select                                   |
| `Shift`+`Tab`         | Visual/Normal | Indent to left and re-select                                    |
| `gh`                  |    Normal     | Show highlight group that matches current cursor                |
| `gp`                  |    Normal     | Select last paste                                               |
| `Q`                   |    Normal     | Start/stop macro recording                                      |
| `gQ`                  |    Normal     | Play macro 'q'                                                  |
| `mj`/`mk`             | Normal/Visual | Move lines down/up                                              |
| `<leader>`+`cp`       |    Normal     | Duplicate paragraph                                             |
| `<leader>`+`cn`/`cN`  | Normal/Visual | Change current word in a repeatable manner                      |
| `s`                   |    Visual     | Replace within selected area                                    |
| `Ctrl`+`a`            |    Command    | Navigation in command line                                      |
| `Ctrl`+`b`            |    Command    | Move cursor backward in command line                            |
| `Ctrl`+`f`            |    Command    | Move cursor forward in command line                             |
| `Ctrl`+`r`            |    Visual     | Replace selection with step-by-step confirmation                |
| `<leader>`+`<leader>` |    Normal     | Enter visual line-mode                                          |
| `<leader>`+`a`        |    Normal     | Align paragraph                                                 |
| `<leader>`+`os`       |    Normal     | Load last session                                               |
| `<leader>`+`se`       |    Normal     | Save current workspace as last session                          |
| `<leader>`+`d`        | Normal/Visual | Duplicate line or selection                                     |
| `<leader>`+`S`        | Normal/Visual | Source selection                                                |
| `<leader>`+`ml`       |    Normal     | Append modeline                                                 |

### File Operations

| Key                             |     Mode      | Action                                                |
| ------------------------------- | :-----------: | ----------------------------------------------------- |
| `<leader>`+`cd`                 |    Normal     | Switch to the directory of opened buffer (:lcd %:p:h) |
| `<leader>`+`w`                  | Normal/visual | Write (:w)                                            |
| `<leader>`+`y` / `<leader>`+`Y` |    Normal     | Copy (relative / absolute) file-path to clipboard     |
| `Ctrl`+`s`                      |     _All_     | Write (:w)                                            |
| `W!!`                           |    Command    | Write as root                                         |

### Editor UI

| Key             |  Mode  | Action                                          |
| --------------- | :----: | ----------------------------------------------- |
| `<leader>`+`ti` | Normal | Toggle indentation lines                        |
| `<leader>`+`ts` | Normal | Toggle spell-checker (:setlocal spell!)         |
| `<leader>`+`tn` | Normal | Toggle line numbers (:setlocal nonumber!)       |
| `<leader>`+`tl` | Normal | Toggle hidden characters (:setlocal nolist!)    |
| `<leader>`+`th` | Normal | Toggle highlighted search (:set hlsearch!)      |
| `<leader>`+`tw` | Normal | Toggle wrap (:setlocal wrap! breakindent!)      |
| `g0`            | Normal | Go to first tab (:tabfirst)                     |
| `g$`            | Normal | Go to last tab (:tablast)                       |
| `gr`            | Normal | Go to previous tab (:tabprevious)               |
| `Ctrl`+`j`      | Normal | Move to split below (\<C-w>j)                   |
| `Ctrl`+`k`      | Normal | Move to upper split (\<C-w>k)                   |
| `Ctrl`+`h`      | Normal | Move to left split (\<C-w>h)                    |
| `Ctrl`+`l`      | Normal | Move to right split (\<C-w>l)                   |
| `*`             | Visual | Search selection forwards                       |
| `#`             | Visual | Search selection backwards                      |
| `<leader>`+`j`  | Normal | Next on location list                           |
| `<leader>`+`k`  | Normal | Previous on location list                       |
| `<leader>`+`b`  | Normal | Toggle colorscheme background dark/light        |
| `s`+`-`         | Normal | Lower colorscheme contrast (Support solarized8) |
| `s`+`=`         | Normal | Raise colorscheme contrast (Support solarized8) |

### Window Management

| Key                  |  Mode  | Action                                |
| -------------------- | :----: | ------------------------------------- |
| `q`                  | Normal | Quit window (and Vim, if last window) |
| `Ctrl`+`Tab`         | Normal | Next tab                              |
| `Ctrl`+`Shift`+`Tab` | Normal | Previous tab                          |
| `\`+`\`              | Normal | Jump to last tab                      |
| `s`+`v`              | Normal | Horizontal split (:split)             |
| `s`+`g`              | Normal | Vertical split (:vsplit)              |
| `s`+`t`              | Normal | Open new tab (:tabnew)                |
| `s`+`o`              | Normal | Close other windows (:only)           |
| `s`+`x`              | Normal | Remove buffer, leave blank window     |
| `s`+`q`              | Normal | Closes current buffer (:close)        |
| `s`+`Q`              | Normal | Removes current buffer (:bdelete)     |
| `<leader>`+`sv`      | Normal | Split with previous buffer            |
| `<leader>`+`sg`      | Normal | Vertical split with previous buffer   |


### Plugin:  Emmet

| Key                  |  Mode  | Action                            |
| -------------------- | :----: | --------------------------------- |
| `Ctrl`+`j/k/f/b/d/u` | Insert | Movement in completion pop-up     |
| `Ctrl`+`<Return>`    | Insert | Expand Emmet sequence             |
| `Ctrl`+`o`           | Insert | Expand snippet                    |
| `Ctrl`+`g`           | Insert | Refresh candidates                |
| `Ctrl`+`l`           | Insert | Complete common string            |
| `Ctrl`+`e`           | Insert | Cancel selection and close pop-up |

### Plugin: Caw (comments)

| Key            |     Mode      | Action                      |
| -------------- | :-----------: | --------------------------- |
| `gc`           | Normal/visual | Prefix                      |
| `gcc`          | Normal/visual | Toggle comments             |
| `<leader>`+`v` | Normal/visual | Toggle single-line comments |
| `<leader>`+`V` | Normal/visual | Toggle comment block        |

### Plugin: QuickHL

| Key            |     Mode      | Action                  |
| -------------- | :-----------: | ----------------------- |
| `<leader>`+`,` | Normal/Visual | Toggle highlighted word |

### Plugin: Easymotion

| Key     |      Mode       | Action                            |
| ------- | :-------------: | --------------------------------- |
| `s`+`s` |     Normal      | Jump to two characters from input |
| `s`+`d` |     Normal      | Jump to a character from input    |
| `s`+`f` |     Normal      | Jump over-windows                 |
| `s`+`h` |     Normal      | Jump backwards in-line            |
| `s`+`l` |     Normal      | Jump forwards in-line             |
| `s`+`j` |     Normal      | Jump downwards                    |
| `s`+`k` |     Normal      | Jump upwards                      |
| `s`+`/` | Normal/operator | Jump to free-search               |
| `s`+`n` |     Normal      | Smart next occurrence             |
| `s`+`p` |     Normal      | Smart previous occurrence         |

### Plugin: Easygit

| Key             |  Mode  | Action               |
| --------------- | :----: | -------------------- |
| `<leader>`+`ga` | Normal | Git add current file |
| `<leader>`+`gS` | Normal | Git status           |
| `<leader>`+`gd` | Normal | Git diff             |
| `<leader>`+`gD` | Normal | Close diff           |
| `<leader>`+`gc` | Normal | Git commit           |
| `<leader>`+`gb` | Normal | Git blame            |
| `<leader>`+`gB` | Normal | Open in browser      |
| `<leader>`+`gp` | Normal | Git push             |

### Plugin: GitGutter

| Key             |  Mode  | Action                |
| --------------- | :----: | --------------------- |
| `<leader>`+`hj` | Normal | Jump to next hunk     |
| `<leader>`+`hk` | Normal | Jump to previous hunk |
| `<leader>`+`hs` | Normal | Stage hunk            |
| `<leader>`+`hr` | Normal | Revert hunk           |
| `<leader>`+`hp` | Normal | Preview hunk          |


## Credits & Contribution

Big thanks to the dark knight [Shougo].

[Shougo]: https://github.com/Shougo
[yaml2json]: https://github.com/bronze1man/yaml2json
