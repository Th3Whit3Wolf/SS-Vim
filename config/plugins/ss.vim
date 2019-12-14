let g:vegeta = [
\ '                                 ,',
\ '                              ,   ,`|',
\ '                            ,/|.-`   \.',
\ '                         .-`  `       |.',
\ '                   ,  .-`              |',
\ '                  /|,`                 |`',
\ '                 / `                    |  ,',
\ '                /                       ,`/',
\ '             .  |          _              /',
\ '              \`` .-.    ,` `.           |',
\ '               \ /   \ /      \          /',
\ '                \|    V        |        |  ,',
\ '                 (           ) /.--.   ``"/',
\ '                 "b.`. ,` _.ee`` 6)|   ,-`',
\ '                   \"= --""  )   ` /.-`',
\ '                    \ / `---"   ."|`',
\ '                     \"..-    .`  |.',
\ '                      `-__..-`,`   |',
\ '                   __.) ` .-`/    /\._',
\ '              _.--`/----..--------. _.-""-._',
\ '           .-`_)   \.   /     __..-`     _.-`--.',
\ '          / -`/      """""""""         ,`-.   . `.',
\ '         | ` /                        /    `   `. \',
\ '         |   |                        |         | |',
\ '          \ . \                       |     \     |',
\ '         / `  | ,`               . -  \`.    |  / /',
\ '        / /   | |                      `/"--. -  /\',
\ '       | |     \ \                     /     \     |',
\ '       | \      | \                  .-|      |    |'
\ ]

let g:startify_custom_header = 'startify#pad(g:vegeta + startify#fortune#boxed())'

let g:startify_session_dir =  $VARPATH.'/session'
let g:startify_files_number = 4

let g:startify_bookmarks = [{'z': '~/.zshrc'}]

let g:startify_lists = [
    \ { 'type' : 'dir',         'header' : ['   My most recently used files in the current directory:']},
    \ { 'type' : 'files',       'header' : ['   My most recently used files:']},
    \ { 'type' : 'sessions',    'header' : ['   These are my sessions:']},
    \ { 'type' : 'bookmarks',   'header' : ['   These are my bookmarks:']},
\ ]

let g:startify_skiplist = [
      \ 'COMMIT_EDITMSG',
      \ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') .'doc',
      \ 'bundle/.*/doc',
\ ]