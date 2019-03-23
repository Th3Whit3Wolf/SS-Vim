colorscheme space-vim-dark
let g:eleline_powerline_fonts = 1

execute 'source' fnameescape(resolve(expand($VIMPATH.'/config/plugins/checker.vim')))
let g:ale_linters = {'jsx': ['stylelint', 'eslint']}
