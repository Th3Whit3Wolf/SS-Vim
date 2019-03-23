set showbreak=↪
set fillchars=vert:│,fold:─
set listchars=tab:\▏\ ,extends:⟫,precedes:⟪,nbsp:␣,trail:·

colorscheme space-vim-dark

let g:airline_theme='violet'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.maxlinenr = ''

execute 'source' fnameescape(resolve(expand($VIMPATH.'/config/plugins/checker.vim')))
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: Tagbar icons {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tagbar_width = 28
let g:tagbar_iconchars = ['↠', '↡']
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: GitGutter icons {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '▎'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▋'
""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin: vim-gitgutter {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight! GitGutterAdd ctermfg=22 guifg=#006000 ctermbg=NONE guibg=NONE
highlight! GitGutterChange ctermfg=58 guifg=#5F6000 ctermbg=NONE guibg=NONE
highlight! GitGutterDelete ctermfg=52 guifg=#600000 ctermbg=NONE guibg=NONE
highlight! GitGutterChangeDelete ctermfg=52 guifg=#600000 ctermbg=NONE guibg=NONE
