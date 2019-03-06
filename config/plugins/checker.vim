function! Lint()
  let fts = ['c', 'cpp', 'cs', 'css', 'cuda', 'clojure', 'd', 'dart', 'dockerfile', 'glsl', 'go', 'elixir', 'erlang', 'fortran', 'haskell', 'html', 'java', 'javascript', 'javascript.jsx', 'julia', 'kotlin', 'less', 'lua', 'nim', 'objc', 'objcpp', 'ocaml', 'php', 'puppet', 'purescript', 'python', 'reason', 'ruby', 'rust', 'sass', 'scss', 'sh', 'typescript', 'vue' ]
  if index(fts, &filetype) == 0
    if &filetype == 'c'
      if executable('ccls')
        let g:LanguageClient_serverCommands = {'c': ['ccls', '--log-file=/tmp/cc.log']}
        call Lsp_on()
      elseif executable('cquery')
        let g:LanguageClient_serverCommands = {'c': ['cquery', '--log-file=/tmp/cq.log']}
        call Lsp_on()
      elseif executable('clangd') || executable('clang') || executable('cppcheck') || executable('flawfinder') || executable('uncrustify')
        let b:ale_linters = {'c': ['clangd', 'clang', 'clang-format', 'clang-tidy', 'cppcheck', 'cpplint', 'gcc', 'flawfinder', 'uncrustify']}
        call Ale_on()
      else
        call All_off()
        echo 'install ccls, cquery, or clang for C linting'
      endif
    elseif &filetype == 'cpp'
      if executable('ccls')
        let g:LanguageClient_serverCommands = {'cpp': ['ccls', '--log-file=/tmp/cc.log']}
        call Lsp_on()
      elseif executable('cquery')
        let g:LanguageClient_serverCommands = {'cpp': ['cquery', '--log-file=/tmp/cq.log']}
        call Lsp_on()
      elseif executable('clangd')
        let g:LanguageClient_serverCommands = {'cpp': ['clangd']}
        call Lsp_on()
      elseif executable('clangd') || executable('clang') || executable('cppcheck') || executable('flawfinder') || executable('uncrustify') || executable('clazy')
        let b:ale_linters = {'c': ['clangd', 'clang', 'clang-format', 'clang-tidy', 'cppcheck', 'cpplint', 'gcc', 'flawfinder', 'uncrustify', 'clazy']}
        call Ale_on()
      else
        call All_off()
        echo 'install ccls, cquery, or clang for C++ linting'
      endif
    elseif &filetype == 'cs'
      if executable('mono') && executable('OmniSharp.exe')
        let g:LanguageClient_serverCommands = {'cs': ['mono', '/opt/omnisharp-roslyn/OmniSharp.exe', '--languageserver']}
        call Lsp_on()
      elseif executable('mcs') || executable('mcsc') || executable('uncrustify')
        let b:ale_linters = {'cs': ['mcs', 'mcsc', 'uncrustify']}
        call Ale_on()
      else
        call All_off()
        echo 'install mcsc, mcs, or uncrustify for C# linting'
      endif
    elseif &filetype == 'css'
      if executable('css-languageserver')
        let g:LanguageClient_serverCommands = {'css': ['css-languageserver', '--stdio']}
        call Lsp_on()
      elseif executable('csslint') || executable('prettier') || executable('stylelint')
        let b:ale_linters = {'css': ['csslint', 'prettier', 'stylelint']}
        call Ale_on()
      else
        call All_off()
        echo 'install css-languageserver, csslint, or prettier for CSS linting'
      endif
    elseif &filetype == 'cuda'
      if executable('ccls')
        let g:LanguageClient_serverCommands = {'cuda': ['ccls', '--log-file=/tmp/cc.log']}
        call Lsp_on()
      elseif executable('nvcc')
        let b:ale_linters = {'cuda': ['nvcc']}
        call Ale_on()
      else
        call All_off()
        echo 'install ccls or nvcc for Cuda linting'
      endif
    elseif &filetype == 'clojure'
      if executable('clojure-lsp')
        let g:LanguageClient_serverCommands = {'clojure': ['clojure-lsp']}
        call Lsp_on()
      elseif executable('joker')
        let b:ale_linters = {'clojure': ['joker']}
        call Ale_on()
      else
        call All_off()
        echo 'install clojure-lsp or joker for Clojure linting'
      endif
    elseif &filetype == 'd'
      if executable('serve-d')
        let g:LanguageClient_serverCommands = {'d': ['serve-d', '--stdio']}
        call Lsp_on()
      elseif executable('dls')
        let g:LanguageClient_serverCommands = {'d': ['dls', '--stdio']}
        call Lsp_on()
      elseif executable('uncrustify') || executable('dmd')
        let b:ale_linters = {'d': ['uncrustify', 'dmd']}
        call Ale_on()
      else
        call All_off()
        echo 'install serv-d, dls, or uncrustify for D linting'
      endif
    elseif &filetype == 'dart'
      if executable('~/.pub-cache/bin/dart_language_server')
        let g:LanguageClient_serverCommands = {'dart': ['~/.pub-cache/bin/dart_language_server']}
        call Lsp_on()
      elseif executable('dartanalyzer') || executable('dartfmt')
        let b:ale_linters = {'dart': ['dartanalyzer', 'dartfmt']}
        call Ale_on()
      else
        call All_off()
        echo 'install dart language server or dartanalyzer for Dart linting'
      endif
    elseif &filetype == 'docker'
      if executable('docker-langserver')
        let g:LanguageClient_serverCommands = {'docker': ['docker-langserver', '--stdio']}
        call Lsp_on()
       elseif executable('hadolint') || executable('dockerfile_lint')
        let b:ale_linters = {'docker': ['hadolint', 'dockerfile_lint']}
        call Ale_on()
      else
        call All_off()
        echo 'install docker langserver, hadolint, or dockerfile-lint for Docker linting'
      endif
    elseif &filetype == 'elixir'
      if executable('elixir-ls')
        let g:LanguageClient_serverCommands = {'elixir': ['mix.exs']}
        call Lsp_on()
      elseif executable('credo') || executable('dogma') || executable('dialyxir') || executable('mix')
        let b:ale_linters = {'elixir': ['credo', 'dogma', 'dialyxir', 'mix']}
        call Ale_on()
      else
        call All_off()
        echo 'install elixir-ls, credo, or dogma for Elixir linting'
      endif
    elseif &filetype == 'erlang'
      if executable('sourcer')
        let g:LanguageClient_serverCommands = {'erlang': ['erlang_ls', '--symbol_skip_mem', '--incrmental_sync', '--autocomplete_no_prefix']}
        call Lsp_on()
      elseif executable('SyntaxErl') || executable('erlc')
        let b:ale_linters = {'erlang': ['SyntaxErl', 'erlc']}
        call Ale_on()
      else
        call All_off()
        echo 'install sourcer, SyntaxErl, or erlc for Erlang linting'
      endif
    elseif &filetype == 'fortran'
      if executable('fortls')
        let g:LanguageClient_serverCommands = {'fortran': ['fortls', '--symbol_skip_mem', '--incrmental_sync', '--autocomplete_no_prefix']}
        call Lsp_on()
      elseif executable('gcc')
        let b:ale_linters = {'fortran': ['gcc']}
        call Ale_on()
      else
        call All_off()
        echo 'pip install fortran-language-server for Fortran linting'
      endif
    elseif &filetype == 'glsl'
      if executable('glslls')
        let g:LanguageClient_serverCommands = {'glsl': ['glslls', '--stdin']}
        call Lsp_on()
      elseif executable('glslang')
        let b:ale_linters = {'glsl': ['glslang']}
        call Ale_on()
      else
        call All_off()
        echo 'pip install glslang for GLSL linting'
      endif
    elseif &filetype == 'go'
      if executable('bingo')
        let g:LanguageClient_serverCommands = {'go': ['bingo']}
        call Lsp_on()
      elseif executable('go-langserver')
        let g:LanguageClient_serverCommands = {'go': ['go-langserver']}
        let g:go_fmt_fail_silently = 1
        call Lsp_on()
      elseif executable('staticcheck') || executable('golint')
        let b:ale_linters = {'go': ['staticcheck', 'gometalinter', 'go vet', 'go build'}
        call Ale_on()
      else
        call All_off()
        echo 'install bingo or staticcheck for GO linting'
      endif
    elseif &filetype == 'haskell'
      if executable('hie-wrapper')
        let g:LanguageClient_serverCommands = {'haskell': ['hie', '--lsp']}
        call Lsp_on()
      elseif executable('stylish-haskell') || executable('hlint') || executable('ghc')
        let b:ale_linters = {'haskell': ['stylish-haskell', 'hlint', 'ghc', 'hfmt', 'brittany']}
        call Ale_on()
      else
        call All_off()
        echo 'install haskell-ide-engine, stylish-haskell, or hlint for Haskell linting'
      endif
    elseif &filetype == 'html'
      if executable('html-languageserver')
        let g:LanguageClient_serverCommands = {'html': ['html-languageserver']}
        call Lsp_on()
      elseif executable('tidy') || executable('alex') || executable('prettier')
        let b:ale_linters = {'html': ['tidy', 'prettier', 'alex', 'proselint', 'write-good']}
        call Ale_on()
      else
        call All_off()
        echo 'install html-langserver, tidy, or prettier for HTML linting'
      endif
    elseif &filetype == 'java'
      if executable('vsce')
        let g:LanguageClient_serverCommands = {'java': ['vsce']}
        call Lsp_on()
      elseif executable('java-language-server')
        let g:LanguageClient_serverCommands = {'java': ['java-language-server', '--quiet']}
        call Lsp_on()
      elseif executable('google-java-format') || executable('uncrustify') || executable('javac')
        let b:ale_linters = {'java': ['javac', 'google-java-format', 'uncrustify', 'checkstyle']}
        call Ale_on()
      else
        call All_off()
        echo 'install vsce, java-language-server, google-java-format, or uncrustify for Java linting'
      endif
    elseif &filetype == 'javascript'
      if executable('flow-language-server')
        let g:LanguageClient_serverCommands = {
          \ 'javascript': ['flow-language-server'],
          \ 'javascript.jsx': ['flow-language-server'],
          \ }
        call Lsp_on()
      elseif executable('typescript-language-server')
        let g:LanguageClient_serverCommands = {
          \ 'javascript': ['javascript-typescript-stdio'],
          \ 'javascript.jsx': ['javascript-typescript-stdio'],
          \ }
        call Lsp_on()
      elseif executable('xo') || executable('eslint') || executable('prettier') || executable('jcsc')
        let b:ale_linters = {'javascript': ['xo', 'eslint', 'prettier', 'jscs']}
        call Ale_on()
      else
        call All_off()
        echo 'install typescript-language-server, xo , eslint, or prettier for Javascript linting'
      endif
    elseif &filetype == 'json'
      if executable('json-language-server')
        let g:LanguageClient_serverCommands = {'json': ['json-language-server', '--stdio']}
        call Lsp_on()
      elseif executable('fixjson') || executable('prettier') || executable('jq')
        let b:ale_linters = {'json': ['fixjson', 'jq', 'prettier']}
        call Ale_on()
      else
        call All_off()
        echo 'install json-language-server, fixjson , jq, or prettier for JSON linting'
        endif
    elseif &filetype == 'julia'
      if executable('julia')
        let g:LanguageClient_serverCommands = {
        \   'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
        \       using LanguageServer;
        \       using Pkg;
        \       import StaticLint;
        \       import SymbolServer;
        \       env_path = dirname(Pkg.Types.Context().env.project_file);
        \       debug = false;
        \
        \       server = LanguageServer.LanguageServerInstance(stdin, stdout, debug, env_path, "", Dict());
        \       server.runlinter = true;
        \       run(server);
        \   ']
        \ }
        call Lsp_on()
      else
        call All_off()
        echo 'install LanguageServer.jl for Julia linting'
      endif
    elseif &filetype == 'kotlin'
      if executable('kotlin-language-server')
          let g:LanguageClient_serverCommands = {'kotlin': ['kotlin-language-server', '--quiet']}
          call Lsp_on()
      elseif executable('ktlint')
        let b:ale_linters = {'kotlin': ['ktlint', 'kotlinc']}
        call Ale_on()
      else
        call All_off()
        echo 'install kotlin-language-server or ktlint for Kotlin linting'
      endif
    elseif &filetype == 'less'
      if executable('css-languageserver')
            let g:LanguageClient_serverCommands = {'less': ['css-languageserver', '--stdio']}
            call Lsp_on()
      elseif executable('prettier') || executable('stylelint') || executable('lessc')
        let b:ale_linters = {'less': ['prettier', 'stylelint', 'lessc']}
        call Ale_on()
      else
        call All_off()
        echo 'install prettier or stylelint for LESS linting'
      endif
    elseif &filetype == 'lua'
      if executable('lua-lsp')
          let g:LanguageClient_serverCommands = {'lua': ['lua-lsp']}
          call Lsp_on()
      elseif executable('luac')
        let b:ale_linters = {'lua': ['luac', 'luacheck']}
        call Ale_on()
      else
        call All_off()
        echo 'install lua-lsp or luacheck for Lua linting'
      endif
    elseif &filetype == 'nim'
      if executable('nimlsp')
        let g:LanguageClient_serverCommands = {'nim': ['nimlsp']}
        call Lsp_on()
       elseif executable('nim')
        let b:ale_linters = {'nim': ['nim check ']}
        call Ale_on()
      else
        call All_off()
        echo 'install nimlsp or nim check for Lua linting'
      endif
    elseif &filetype == 'objc'
      if executable('ccls')
        let g:LanguageClient_serverCommands = {'objc': ['ccls', '--log-file=/tmp/cc.log']}
        call Lsp_on()
      elseif executable('cquery')
        let g:LanguageClient_serverCommands = {'objc': ['cquery', '--log-file=/tmp/cq.log']}
        call Lsp_on()
      elseif executable('clang') || executable('clangd') || executable('uncrustify')
        let b:ale_linters = {'objc': ['clang', 'clangd', 'uncrustify']}
        call Ale_on()
      else
        call All_off()
        echo 'install ccls, cquery, clang, or uncrustify for Objective-C linting'
      endif
    elseif &filetype == 'objcpp'
      if executable('clangd')
        let g:LanguageClient_serverCommands = {'objcpp': ['clangd']}
        call Lsp_on()
      elseif executable('cquery')
        let g:LanguageClient_serverCommands = {'objcpp': ['cquery', '--log-file=/tmp/cq.log']}
        call Lsp_on()
      elseif executable('clang') || executable('clangd') || executable('uncrustify')
        let b:ale_linters = {'objcpp': ['clang', 'clangd', 'uncrustify']}
        call Ale_on()
      else
        call All_off()
        echo 'install ccls, cquery, clang, or uncrustify for Objective-C++ linting'
      endif
    elseif &filetype == 'ocaml'
      if executable('ocaml-language-server')
        let g:LanguageClient_serverCommands = {'ocaml': ['ocaml-language-server', '--stdio']}
        call Lsp_on()
      elseif executable('merlin') || executable('ocamlformat') || executable('ols')
        let b:ale_linters = {'ocaml': ['ols', 'ocamlformat', 'merlin']}
        call Ale_on()
      else
        call All_off()
        echo 'install ocaml-language-server, ocamlformat, or merlin for OCaml linting'
      endif
    elseif &filetype == 'php'
      if executable('php')
        let g:LanguageClient_serverCommands = {'php': ['php vendor/felixfbecker/language-server/bin/php-language-server.php]}
        call Lsp_on()
      elseif executable('phan') || executable('phpcbf') || executable('phpcs') || executable('php-cs-fixer') || executable('php -l') || executable('phpmd') || executable('phpstan') || executable('phpsalm')
        let b:ale_linters = {'ocaml': ['phan', 'phpcbf', 'phpcs', 'php-cs-fixer', 'php -l', 'phpmd', 'phpstan', 'phpsalm']}
        call Ale_on()
      else
        call All_off()
        echo 'install ocaml-language-server, ocamlformat, or merlin for OCaml linting'
      endif
    elseif &filetype == 'puppet'
      if executable('puppet-languageserver')
        let g:LanguageClient_serverCommands = {'puppet': ['puppet-languageserver', '--stdio']}
        call Lsp_on()
      elseif executable('puppet') || executable('puppet-lint') || executable('puppet-languageserver')
        let b:ale_linters = {'puppet': ['puppet', 'puppet-lint', 'puppet-languageserver']}
        call Ale_on()
      else
        call All_off()
        echo 'install puppet-languageserver or puppet-lint for OCaml linting'
      endif
    elseif &filetype == 'purescript'
      if executable('purescript-language-server')
        let g:LanguageClient_serverCommands = {'purescript': ['purescript-language-server', '--stdio']}
        call Lsp_on()
      else
        call All_off()
        echo 'install purescript-language-server for Purescript linting'
      endif
    elseif &filetype == 'python'
      if executable('pyls')
        let g:LanguageClient_serverCommands = {'python': ['/usr/bin/pyls']}
        call Lsp_on()
       " call ncm2#override_source('LanguageClient_python', {'enable': 0})
      elseif executable('autopep8') || executable('black') || executable('yapf') || executable('flake8') || executable('isort') || executable('mypy')
        let b:ale_linters = {'python': ['autopep8', 'black', 'yapf', 'flake8']}
        call Ale_on()
      else
        call All_off()
        echo 'install pyls, autopep8, black, yapf or flake8 for Python linting'
      endif
    elseif &filetype == 'reason'
      if executable('ocaml-language-server')
        let g:LanguageClient_serverCommands = {'reason': ['ocaml-language-server', '--stdio']}
        call Lsp_on()
      elseif executable('merlin') || executable('refmt') || executable('ols')
        let b:ale_linters = {'reason': ['ols', 'refmt', 'merlin']}
        call Ale_on()
      else
        call All_off()
        echo 'install ocaml-language-server, refmt, or merlin for OCaml linting'
      endif
    elseif &filetype == 'ruby'
      if executable('orbaclerun')
        let g:LanguageClient_serverCommands = {'ruby': ['orbaclerun', 'file-server']}
        call Lsp_on()
      elseif executable('solargraph')
        let g:LanguageClient_serverCommands = {'ruby': ['solargraph', 'stdio']}
        call Lsp_on()
      elseif executable('brakeman') || executable('reek') || executable('rubocop')
        let b:ale_linters = {'ruby': ['brakeman', 'reek', 'rubocop', 'ruby', 'rufo', 'standardrb', 'rails_best_practices']}
        call Ale_on()
      else
        call All_off()
        echo 'install solargraph, orbaclerun, or rubocop for Ruby linting'
      endif
    elseif &filetype == 'rust'
      if executable('rls')
        let g:LanguageClient_serverCommands = {'rust': ['rustup', 'run', 'stable', 'rls']}
        call Lsp_on()
      elseif executable('cargo') || executable('rustc') || executable('rustfmt')
        let b:ale_linters = {'rust': ['cargo', 'rustc', 'rustfmt']}
        call Ale_on()
      else
        call All_off()
        echo 'install rls, cargo, or rustfmt for Rust linting'
      endif
    elseif &filetype == 'sass'
      if executable('css-languageserver')
          let g:LanguageClient_serverCommands = {'sass': ['css-languageserver', '--stdio']}
          call Lsp_on()
      elseif executable('sass-lint') || executable('stylelint')
        let b:ale_linters = {'rpmspec': ['sass-lint', 'stylelint']}
        call Ale_on()
      else
        call All_off()
        echo 'install sass-lint or stylelint for SASS linting'
      endif
    elseif &filetype == 'scss'
      if executable('css-languageserver')
          let g:LanguageClient_serverCommands = {'scss': ['css-languageserver', '--stdio']}
          call Lsp_on()
      elseif executable('prettier') || executable('sass-lint') || executable('scss-lint') || executable('style')
        let b:ale_linters = {'scala': ['fsc', 'sbtserver', 'scalac', 'scalastyle', 'scalafmt']}
        call Ale_on()
      else
        call All_off()
        echo 'install prettier, scss-lint, or stylelint for SCSS linting'
      endif
    elseif &filetype == 'sh'
      if executable('bash-language-server')
        let g:LanguageClient_serverCommands = {'sh': ['bash-language-server', 'start']}
        call Lsp_on()
      elseif executable('shfmt')
        let b:ale_linters = {'bash': ['shfmt']}
        call Ale_on()
      else
        call All_off()
        echo 'install https://github.com/mvdan/sh for shell linting'
      endif
    elseif &filetype == 'typescript'
      if executable('typescript-language-server')
        let g:LanguageClient_serverCommands = {
          \ 'typescript': ['typescript-language-server', 'start'],
          \ 'typescript.jsx': ['typescript-language-server', 'start'],
          \}
        call Lsp_on()
      elseif executable('eslint') || executable('prettier') || executable('tslint') || executable('tsserver')
        let b:ale_linters = {'typescript': ['tsserver', 'tslint', 'prettier', 'eslint']}
        call Ale_on()
      else
        call All_off()
        echo 'install typescript-language-server, tsserver, tslint, or prettier for Typescript linting'
      endif
    elseif &filetype == 'vue'
      if executable('vls')
        let g:LanguageClient_serverCommands = {'vue': ['vls']}
        call Lsp_on()
      elseif executable('prettier')
        let b:ale_linters = {'vue': ['prettier']}
        call Ale_on()
      else
        call All_off()
        echo 'install prettier for Vue linting'
      endif
    else
      call Ale_on()
    endif
  elseif &filetype == 'ada'
    if executable('gcc')
      let b:ale_linters = {'ada': ['gcc']}
      call Ale_on()
    else
      call All_off()
      echo 'install proselint, redpin, textlint, vale, or write-good for ADA linting'
    endif
  elseif &filetype == 'ansible'
    if executable('ansible-lint')
      let b:ale_linters = {'ansible': ['ansible-lint']}
      call Ale_on()
    else
      call All_off()
      echo 'pip install ansible-lint for Ansible linting'
    endif
  elseif &filetype == 'apiblueprint'
    if executable('drafter')
      let b:ale_linters = {'apiblueprint': ['drafter']}
      call Ale_on()
    else
      call All_off()
      echo 'install https://github.com/apiaryio/drafter for Apiblueprint linting'
    endif
  elseif &filetype == 'asciidoc'
    if executable('alex')
      let b:ale_linters = {'asciidoc': ['alex']}
      call Ale_on()
    elseif executable('proselint') || executable('redpin') || executable('textlint') || executable('vale') || executable('write-good')
      let b:ale_linters = {'asciidoc': ['proselint', 'redpin', 'textlint', 'vale', 'write-good']}
      call Ale_on()
    else
      call All_off()
      echo 'install proselint, redpin, textlint, vale, or write-good for Asciidoc linting'
    endif
  elseif &filetype == 'asm'
    if executable('gcc')
      let b:ale_linters = {'asm': ['gcc']}
      call Ale_on()
    else
      call All_off()
      echo 'install gcc for Assembly linting'
    endif
  elseif &filetype == 'awk'
    if executable('gawk')
      let b:ale_linters = {'awk': ['gawk']}
      call Ale_on()
    else
      call All_off()
      echo 'install gawk for Awk linting'
    endif
  elseif &filetype == 'bibtex'
    if executable('bibclean')
      let b:ale_linters = {'bibtex': ['bibclean']}
      call Ale_on()
    else
      call All_off()
      echo 'install bibclean for BibTex linting'
    endif
  elseif &filetype == 'chef'
    if executable('foodcritic')
      let b:ale_linters = {'chef': ['foodcritic']}
      call Ale_on()
    else
      call All_off()
      echo 'install foodcritic for Chef linting'
    endif
  " cloud formation
  elseif &filetype == 'aws'
    if executable('cfn-python-lint')
      let b:ale_linters = {'cloudformation': ['cfn-python-lint']}
      call Ale_on()
    else
      call All_off()
      echo 'install foodcritic for Cloudformation linting'
    endif
  elseif &filetype == 'cmake'
    if executable('cmake-format') || executable('cmakelint')
      let b:ale_linters = {'cmake': ['cmake-format', 'cmakelint']}
      call Ale_on()
    else
      call All_off()
      echo 'install cmake-format or cmake-lint for Cmake linting'
    endif
  elseif &filetype == 'coffeescript'
    if executable('coffeelint') || executable('coffee')
      let b:ale_linters = {'coffeescript': ['coffeelint', 'coffee']}
      call Ale_on()
    else
      call All_off()
      echo 'install coffeelint for Coffeescript linting'
    endif
  elseif &filetype == 'crystal'
    if executable('ameba') || executable('crystal')
      let b:ale_linters = {'crystal': ['ameba'], 'crystal'}
      call Ale_on()
    else
      call All_off()
      echo 'install ameba for Crystal linting'
    endif
  elseif &filetype == 'cucumber'
    if executable('cucumber')
      let b:ale_linters = {'cucumber': ['cucumber']}
      call Ale_on()
    else
      call All_off()
      echo 'install cucumber for Cucumber linting'
    endif
  elseif &filetype == 'dafny'
    if executable('dafny')
      let b:ale_linters = {'dafny': ['dafny']}
      call Ale_on()
    else
      call All_off()
      echo 'install dafny for Dafny linting'
    endif
  elseif &filetype == 'elm'
    if executable('elm-format') || executable('elm-make')
      let b:ale_linters = {'elm': ['elm-format', 'elm-make']}
      call Ale_on()
    else
      call All_off()
      echo 'install elm-format or elm-make for Elm linting'
    endif
  elseif &filetype == 'fountain'
    if executable('proselint')
      let b:ale_linters = {'fountain': ['proselint']}
      call Ale_on()
    else
      call All_off()
      echo 'install proselintfor for Fountain linting'
    endif
  elseif &filetype == 'fusionscript'
    if executable('fusion-lint')
      let b:ale_linters = {'fusionscript': ['fusion-lint']}
      call Ale_on()
    else
      call All_off()
      echo 'install fusion-lint for Fusionscript linting'
    endif
  elseif &filetype == 'gitcommit'
    if executable('gitlint')
      let b:ale_linters = {'gitcommit': ['gitlint']}
      call Ale_on()
    else
      call All_off()
      echo 'install gitlint for Git Commit linting'
    endif
  elseif &filetype == 'graphql'
    if executable('gqlint') || executable('eslint') ||
      let b:ale_linters = {'graphql': ['gqlint', 'prettier', 'eslint']}
      call Ale_on()
    else
      call All_off()
      echo 'install gqlint, prettier, or eslint for GraphQL linting'
    endif
  elseif &filetype == 'hack'
    if executable('hhast') || executable('hack')
      let b:ale_linters = {'hack': ['hack', 'hhast']}
    else
      call All_off()
      echo 'install hhast for Hack linting'
    endif
  elseif &filetype == 'haml'
    if executable('haml-lint')
      let b:ale_linters = {'haml': ['haml-lint']}
      call Ale_on()
    else
      call All_off()
      echo 'install haml-lint for HAML linting'
    endif
  elseif &filetype == 'handlebars'
    if executable('ember-template-lint')
      let b:ale_linters = {'handlebars': ['ember-template-lint']}
      call Ale_on()
    else
      call All_off()
      echo 'install haml-lint for HAML linting'
    endif
  elseif &filetype == 'hcl'
    if executable('terraform-fmt')
      let b:ale_linters = {'hcl': ['terraform-fmt']}
      call Ale_on()
    else
      call All_off()
      echo 'install terraform-fmt for HCL linting'
    endif
  elseif &filetype == 'latex'
    if executable('textlint') || executable('proselint') || executable('write-good')
      let b:ale_linters = {'latex': ['textlint', 'proselint', 'write-good']}
      call Ale_on()
    else
      call All_off()
      echo 'install textlint, proselint, write-good for Latex linting'
    endif
  elseif &filetype == 'make'
    if executable('checkmake')
      let b:ale_linters = {'make': ['checkmake']}
      call Ale_on()
    else
      call All_off()
      echo 'install checkmake or stylelint for Make linting'
    endif
  elseif &filetype == 'markdown'
    if executable('prettier') || executable('alex') || executable('mdl') || executable('vale') || executable('redpen') || executable('markdownlint') || executable('write-good')
      let b:ale_linters = {'markdown': ['alex', 'markdownlint', 'mdl', 'prettier', 'proselint', 'redpen', 'remark-lint', 'textlint', 'vale', 'write-good']}
      call Ale_on()
    else
      call All_off()
      echo 'install checkmake or stylelint for Make linting'
    endif
  elseif &filetype == 'matlab'
    if executable('mlint')
      let b:ale_linters = {'matlab': ['mlint']}
      call Ale_on()
    else
      call All_off()
      echo 'install mlint or stylelint for MATLAB linting'
    endif
  elseif &filetype == 'mercury'
    if executable('mmc')
      let b:ale_linters = {'mercury': ['mmc']}
      call Ale_on()
    else
      call All_off()
      echo 'install mmc or stylelint for Mercury linting'
    endif
  elseif &filetype == 'nix'
    if executable('nix-instantiate')
      let b:ale_linters = {'nix': ['nix-instantiate']}
      call Ale_on()
    else
      call All_off()
      echo 'install nix-instantiate for Nix linting'
    endif
  elseif &filetype == 'nroff'
    if executable('alex') || executable('proselint') || executable('write-good')
      let b:ale_linters = {'nroff': ['alex', 'proselint', 'write-good']}
      call Ale_on()
    else
      call All_off()
      echo 'install alex, proselint, or write-good for Nroff linting'
    endif
  elseif &filetype == 'pawn'
    if executable('uncrustify')
      let b:ale_linters = {'pawn': ['uncrustify']}
      call Ale_on()
    else
      call All_off()
      echo 'install uncrustifyfor Pawn linting'
    endif
  elseif &filetype == 'perl'
    if executable('perl') || executable('perl-critic') || executable('perltidy')
      let b:ale_linters = {'perl': ['perl -c', 'perl-critic', 'perltidy']}
      call Ale_on()
    else
      call All_off()
      echo 'install perl-critic or perltidy for Perl linting'
    endif
  elseif &filetype == 'perl6'
    if executable('perl6')
      let b:ale_linters = {'perl': ['perl6 -c']}
      call Ale_on()
    else
      call All_off()
      echo 'install Perl6 for Perl6 linting'
    endif
  elseif &filetype == 'po'
    if executable('alex') || executable('msgfmt') || executable('proselint') || executable('write-good')
      let b:ale_linters = {'po': ['alex', 'msgfmt', 'proselint', 'write-good']}
      call Ale_on()
    else
      call All_off()
      echo 'install msgfmt, proselint, write-good for Po linting'
    endif
  elseif &filetype == 'pony'
    if executable('ponyc')
      let b:ale_linters = {'pony': ['ponyc']}
      call Ale_on()
    else
      call All_off()
      echo 'install Pony for Pony linting'
    endif
  elseif &filetype == 'pod'
    if executable('alex') || executable('proselint') || executable('write-good')
      let b:ale_linters = {'pod': ['alex', 'proselint', 'write-good']}
      call Ale_on()
    else
      call All_off()
      echo 'install alex, proselint, or write-good for Pod linting'
    endif
  elseif &filetype == 'prolog'
    if executable('swipl')
      let b:ale_linters = {'prolog': ['swipl']}
      call Ale_on()
    else
      call All_off()
      echo 'install swipl for Prolog linting'
    endif
  elseif &filetype == 'proto'
    if executable('protoc-gen-lint')
      let b:ale_linters = {'proto': ['protoc-gen-lint']}
      call Ale_on()
    else
      call All_off()
      echo 'install protoc-gen-lint for Proto linting'
    endif
  elseif &filetype == 'proto'
    if executable('protoc-gen-lint')
      let b:ale_linters = {'proto': ['protoc-gen-lint']}
      call Ale_on()
    else
      call All_off()
      echo 'install protoc-gen-lint for Proto linting'
    endif
  elseif &filetype == 'pug'
    if executable('pug-lint')
      let b:ale_linters = {'pug': ['pug-lint']}
      call Ale_on()
    else
      call All_off()
      echo 'install pug-lint for Pug linting'
    endif
  elseif &filetype == 'qml'
    if executable('qmllint') || executable('qmlfmt')
      let b:ale_linters = {'qml': ['qmllint', 'qmlfmt']}
      call Ale_on()
    else
      call All_off()
      echo 'install qmllint or qmlfmt for Pug linting'
    endif
  elseif &filetype == 'r'
    if executable('lintr')
      let b:ale_linters = {'r': ['lintr']}
      call Ale_on()
    else
      call All_off()
      echo 'install lintr for R linting'
    endif
  elseif &filetype == 'racket'
    if executable('raco')
      let b:ale_linters = {'racket': ['raco']}
      call Ale_on()
    else
      call All_off()
      echo 'install raco for Racket linting'
    endif
  elseif &filetype == 'rst'
    if executable('alex') || executable('proselint') || executable('redpen') || executable('rstcheck') || executable('textlint') || executable('vale') || executable('write-good')
      let b:ale_linters = {'rst': ['alex', 'proselint', 'redpen', 'rstcheck', 'textlint', 'vale', 'write-good']}
      call Ale_on()
    else
      call All_off()
      echo 'install proselint, redpen, or rstcheck for reStructuredText linting'
    endif
  elseif &filetype == 'review'
    if executable('redpen')
      let b:ale_linters = {'review': ['redpen']}
      call Ale_on()
    else
      call All_off()
      echo 'install redpen for Re:VIEW  linting'
    endif
  elseif &filetype == 'rpmspec'
    if executable('rpmlint')
      let b:ale_linters = {'rpmspec': ['rpmlint']}
      call Ale_on()
    else
      call All_off()
      echo 'install proselint, redpen, or rstcheck for reStructuredText linting'
    endif
  elseif &filetype == 'scala'
    if executable('fsc') || executable('sbtserver') || executable('scalac') || executable('scalastyle')
      let b:ale_linters = {'scala': ['fsc', 'sbtserver', 'scalac', 'scalastyle', 'scalafmt']}
      call Ale_on()
    else
      call All_off()
      echo 'install fsc, sbtserver, or scalastyle for Scala linting'
    endif

  elseif &filetype == 'slim'
    if executable('slim-lint')
      let b:ale_linters = {'slim': ['slim-lint']}
      call Ale_on()
    else
      call All_off()
      echo 'install slim-lint for Slim linting'
    endif
  elseif &filetype == 'sml'
    if executable('smlnj')
      let b:ale_linters = {'sml': ['smlnj']}
      call Ale_on()
    else
      call All_off()
      echo 'install smlnj for SML linting'
    endif
  elseif &filetype == 'solidity'
    if executable('smlnj')
      let b:ale_linters = {'solidity': ['solhint', 'solium']}
      call Ale_on()
    else
      call All_off()
      echo 'install solhint or solium for Solidity linting'
    endif
  elseif &filetype == 'sql'
    if executable('smlnj')
      let b:ale_linters = {'sql': ['sqlint', 'sqlfmt']}
      call Ale_on()
    else
      call All_off()
      echo 'install sqlint or sqlfmt for SQL linting'
    endif
  elseif &filetype == 'stylus'
    if executable('stylelint')
      let b:ale_linters = {'stylus': ['stylelint']}
      call Ale_on()
    else
      call All_off()
      echo 'install stylelint for Stylus linting'
    endif
  elseif &filetype == 'sugarss'
    if executable('stylus')
      let b:ale_linters = {'sugarss': ['stylelint']}
      call Ale_on()
    else
      call All_off()
      echo 'install stylelint for Sugarss linting'
    endif
  elseif &filetype == 'swift'
    if executable('swiftlint') || executable('swiftformat')
      let b:ale_linters = {'swift': ['swiftlint', 'swiftformat']}
      call Ale_on()
    else
      call All_off()
      echo 'install swiftlint for Swift linting'
    endif
  elseif &filetype == 'tcl'
    if executable('nagelfar')
      let b:ale_linters = {'tcl': ['nagelfar']}
      call Ale_on()
    else
      call All_off()
      echo 'install nagelfar for TCL linting'
    endif
  elseif &filetype == 'texinfo'
    if executable('alex') || executable('proselint') || executable('write-good')
      let b:ale_linters = {'texinfo': ['alex', 'proselint', 'write-good']}
      call Ale_on()
    else
      call All_off()
      echo 'install alex, proselint, or write-good for Texinfo linting'
    endif
  elseif &filetype == 'thrift'
    if executable('thrift')
      let b:ale_linters = {'thrift': ['thrift']}
      call Ale_on()
    else
      call All_off()
      echo 'install Thrift for Thrift linting'
    endif
  elseif &filetype == 'vala'
    if executable('uncrustify')
      let b:ale_linters = {'vala': ['uncrustify']}
      call Ale_on()
    else
      call All_off()
      echo 'install uncrustify for Vala linting'
    endif
  elseif &filetype == 'verilog'
    if executable('iverilog') || executable('verilator') || executable('vlog') || executable('xvlog')
      let b:ale_linters = {'verilog': ['iverilog', 'verilator', 'vlog', 'xvlog']}
      call Ale_on()
    else
      call All_off()
      echo 'install iverilog, verilator, vlog, or xvlog for Verilog linting'
    endif
  elseif &filetype == 'vhdl'
    if executable('ghdl') || executable('vcom') || executable('xvhdl')
      let b:ale_linters = {'vhdl': ['ghdl', 'vcom', 'xvhdl']}
      call Ale_on()
    else
      call All_off()
      echo 'install ghdl, vcom, or xvhdl for VHDL linting'
    endif
  elseif &filetype == 'vim'
    if executable('vint')
      let b:ale_linters = {'vim': ['vint']}
      call Ale_on()
    else
      call All_off()
      echo 'install vint for Vim linting'
    endif
  elseif &filetype == 'xhtml'
    if executable('alex') || executable('proselint') || executable('write-good')
      let b:ale_linters = {'xhtml': ['alex', 'proselint', 'write-good']}
      call Ale_on()
    else
      call All_off()
      echo 'install alex, proselint, or write-good for XHTML linting'
    endif
  elseif &filetype == 'xml'
    if executable('xmllint')
      let b:ale_linters = {'xml': ['xmllint']}
      call Ale_on()
    else
      call All_off()
      echo 'install xmllint for XML linting'
    endif
  elseif &filetype == 'yaml'
    if executable('prettier') || executable('swaglint') || executable('yamllint')
      let b:ale_linters = {'xml': ['prettier', 'swaglint', 'yamllint']}
      call Ale_on()
    else
      call All_off()
      echo 'install prettier, swaglint, or yamllint for YAML linting'
    endif
  else
    call All_off()
  endif
endfunction


function! All_off()
  let g:LanguageClient_autoStart = 0
  let g:airline#extensions#languageclient#enabled = 0
  let g:airline#extensions#ale#enabled = 0
endfunction


function! Lsp_on()
  let g:LanguageClient_autoStart = 1
  let g:airline#extensions#languageclient#enabled = 1
  let g:airline#extensions#ale#enabled = 0
  autocmd BufEnter  *  call ncm2#enable_for_buffer()
  set completeopt=noinsert,menuone,noselect
endfunction

function! Ale_on()
  let g:LanguageClient_autoStart = 0
  let g:airline#extensions#languageclient#enabled = 1
  let g:airline#extensions#ale#enabled = 0
endfunction

let g:LanguageClient_rootMarkers = {
    \ 'cpp':            ['main.cpp', 'build', 'compile_commands.json'],
    \ 'cs':             ['.git', '*.csproj'],
    \ 'go':             ['.git', 'go.mod'],
    \ 'haskell':        ['*.cabal', 'stack.yaml'],
    \ 'javascript':     ['project.json'],
    \ 'rust':           ['Cargo.toml']
\ }

let g:LanguageClient_diagnosticsDisplay = {
    \   1: {
    \        "name": "Error",
    \        "texthl": "ALEError",
    \        "signText": "✖",
    \        "signTexthl": "ALEErrorSign",
    \        "virtualTexthl": "Error",
    \    },
    \        2: {
    \       "name": "Warning",
    \        "texthl": "ALEWarning",
    \        "signText": "⚡",
    \        "signTexthl": "ALEWarningSign",
    \        "virtualTexthl": "Todo",
    \    },
    \    3: {
    \        "name": "Information",
    \        "texthl": "ALEInfo",
    \        "signText": "ℹ",
    \        "signTexthl": "ALEInfoSign",
    \        "virtualTexthl": "Todo",
    \    },
    \    4: {
    \        "name": "Hint",
    \        "texthl": "ALEInfo",
    \        "signText": "➤",
    \        "signTexthl": "ALEInfoSign",
    \        "virtualTexthl": "Todo",
    \   },
\}

let g:ale_sign_error            = '✖'
let g:ale_sign_warning          = '⚡'
let g:ale_echo_msg_error_str    = 'E'
let g:ale_echo_msg_warning_str  = 'W'
let g:ale_echo_msg_format       = '[%linter%] %s [%severity%]'

let g:ale_linter_aliases  = {'jsx': ['css', 'javascript']}
let g:ale_linters         = {'jsx': ['stylelint', 'eslint']}