let s:vegeta = [
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

let g:startify_custom_header = s:vegeta
let g:startify_custom_footer = startify#fortune#boxed()

let g:startify_session_dir =  $VARPATH.'/session'
let g:startify_files_number = 4
let g:startify_list_order = [
      \ ['   My most recently used files in the current directory:'],
      \ 'dir',
      \ ['   My most recently used files:'],
      \ 'files',
      \ ['   These are my sessions:'],
      \ 'sessions',
      \ ['   These are my bookmarks:'],
      \ 'bookmarks',
\ ]


let g:startify_skiplist = [
      \ 'COMMIT_EDITMSG',
      \ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') .'doc',
      \ 'bundle/.*/doc',
\ ]
