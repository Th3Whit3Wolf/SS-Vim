let g:mapleader="\<Space>"
"""""""""""""""""""""""
" Terminal Function
"""""""""""""""""""""""
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

" Toggle terminal on/off (neovim)
nnoremap <A-t> :call TermToggle(10)<CR>
inoremap <A-t> <Esc>:call TermToggle(10)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(10)<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>

" Window-control prefix
nnoremap  [Window]   <Nop>
nmap      s [Window]

" Fix keybind name for Ctrl+Spacebar
map <Nul> <C-Space>
map! <Nul> <C-Space>

" Change current word in a repeatable manner
nnoremap <leader>cn *``cgn
nnoremap <leader>cN *``cgN

" Change selected word in a repeatable manner
vnoremap <expr> <leader>cn "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgn"
vnoremap <expr> <leader>cN "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgN"

nnoremap <leader>cp yap<S-}>p
nnoremap <leader>a =ip
"""""""""""""""""""""""
" Global niceties
"""""""""""""""""""""""

" Start an external command with a single bang
nnoremap ! :!

" Allow misspellings
cnoreabbrev Qa qa
cnoreabbrev Bd bd
cnoreabbrev bD bd
cnoreabbrev qw wq
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!

" Start new line from any cursor position
inoremap <S-Return> <C-o>o

" Quick substitute within selected area
xnoremap s :s//g<Left><Left>

nnoremap zl z5l
nnoremap zh z5h

" Improve scroll, credits: https://github.com/Shougo
nnoremap <expr> zz (winline() == (winheight(0)+1) / 2) ?
	\ 'zt' : (winline() == 1) ? 'zb' : 'zz'
noremap <expr> <C-f> max([winheight(0) - 2, 1])
	\ ."\<C-d>".(line('w$') >= line('$') ? "L" : "M")
noremap <expr> <C-b> max([winheight(0) - 2, 1])
	\ ."\<C-u>".(line('w0') <= 1 ? "H" : "M")
noremap <expr> <C-e> (line("w$") >= line('$') ? "j" : "3\<C-e>")
noremap <expr> <C-y> (line("w0") <= 1         ? "k" : "3\<C-y>")

" Window control
nnoremap <C-q> <C-w>
nnoremap <C-x>  :bd<CR>   " delete buffer
nnoremap <silent><C-w>z :vert resize<CR>:resize<CR>:normal! ze<CR>

"switch windw
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

"smart move
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Select blocks after indenting
xnoremap < <gv
xnoremap > >gv|

" Use tab for indenting
vnoremap <Tab> >gv|
vnoremap <S-Tab> <gv
nmap <Tab>   >>_
nmap <S-Tab> <<_

" Select last paste
nnoremap <expr> gp '`['.strpart(getregtype(), 0, 1).'`]'

" Navigation in command line
cnoremap <C-h> <Home>
cnoremap <C-l> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-d> <C-w>

" Switch history search pairs, matching my bash shell
cnoremap <C-p>  <Up>
cnoremap <C-n>  <Down>
cnoremap <Up>   <C-p>
cnoremap <Down> <C-n>
""""""""""""""""""""""
" File operations
""""""""""""""""""""""
" Fast saving
if exists("g:neoformat_is_on")
	nnoremap <silent><C-s> :<C-u>write \| Neoformat \| write<CR>
	vnoremap <silent><C-s> :<C-u>write \| Neoformat \| write<CR>
	cnoremap <silent><C-s> <C-u>write  \| Neoformat \| write<CR>
else
	nnoremap <silent><C-s> :<C-u>write \| write<CR>
	vnoremap <silent><C-s> :<C-u>write \| write<CR>
	cnoremap <silent><C-s> <C-u>write  \| write<CR>
endif

" I like to :quit with 'q', shrug.
nnoremap <silent> q :<C-u>:quit<CR>
autocmd MyAutoCmd FileType man nnoremap <silent><buffer> q :<C-u>:quit<CR>

" Macros
nnoremap Q q
nnoremap gQ @q

" Show highlight names under cursor
nmap <silent> gh :echo 'hi<'.synIDattr(synID(line('.'), col('.'), 1), 'name')
	\.'> trans<'.synIDattr(synID(line('.'), col('.'), 0), 'name').'> lo<'
	\.synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name').'>'<CR>

" Toggle editor visuals
nmap <silent> <Leader>ts :setlocal spell!<cr>
nmap <silent> <Leader>tn :setlocal nonumber!<CR>
nmap <silent> <Leader>tl :setlocal nolist!<CR>
nmap <silent> <Leader>th :nohlsearch<CR>
nmap <silent> <Leader>tw :setlocal wrap! breakindent!<CR>

" Tabs
"nnoremap <silent> g0 :<C-u>tabfirst<CR>
"nnoremap <silent> g$ :<C-u>tablast<CR>
"nnoremap <silent> gr :<C-u>tabprevious<CR>
"nnoremap <silent> <A-j> :<C-U>tabnext<CR>
"nnoremap <silent> <A-k> :<C-U>tabprevious<CR>
"nnoremap <silent> <C-Tab> :<C-U>tabnext<CR>
"nnoremap <silent> <C-S-Tab> :<C-U>tabprevious<CR>

" Remove spaces at the end of lines
nnoremap <silent> ,<Space> :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

" C-r: Easier search and replace
xnoremap <C-r> :<C-u>call <SID>get_selection('/')<CR>:%s/\V<C-R>=@/<CR>//gc<Left><Left><Left>

" Returns visually selected text
function! s:get_selection(cmdtype) "{{{
	let temp = @s
	normal! gv"sy
	let @/ = substitute(escape(@s, '\'.a:cmdtype), '\n', '\\n', 'g')
	let @s = temp
endfunction "}}}

" Location list movement
nmap <Leader>j :lnext<CR>
nmap <Leader>k :lprev<CR>

" Duplicate lines
nnoremap <Leader>d m`YP``
vnoremap <Leader>d YPgv

" Source line and selection in vim
vnoremap <Leader>S y:execute @@<CR>:echo 'Sourced selection.'<CR>
nnoremap <Leader>S ^vg_y:execute @@<CR>:echo 'Sourced line.'<CR>

" Yank buffer's absolute path to X11 clipboard
nnoremap <Leader>y :let @+=expand("%")<CR>:echo 'Relative path copied to clipboard.'<CR>
nnoremap <Leader>Y :let @+=expand("%:p")<CR>:echo 'Absolute path copied to clipboard.'<CR>

" Drag current line/s vertically and auto-indent
vnoremap mk :m-2<CR>gv=gv
vnoremap mj :m'>+<CR>gv=gv
noremap  mk :m-2<CR>
noremap  mj :m+<CR>

" Session management shortcuts
nmap <silent> <Leader>se :<C-u>execute 'SessionSave' fnamemodify(resolve(getcwd()), ':p:gs?/?_?')<CR>
nmap <silent> <Leader>os :<C-u>execute 'source '.g:session_directory.'/'.fnamemodify(resolve(getcwd()), ':p:gs?/?_?').'.vim'<CR>

if has('mac')
	" Open the macOS dictionary on current word
	nmap <Leader>? :!open dict://<cword><CR><CR>

	" Use Marked for real-time Markdown preview
	if executable('/Applications/Marked 2.app/Contents/MacOS/Marked 2')
		autocmd MyAutoCmd FileType markdown
			\ nmap <buffer><Leader>P :silent !open -a Marked\ 2.app '%:p'<CR>
	endif

	" Use Dash on Mac, for context help
	if executable('/Applications/Dash.app/Contents/MacOS/Dash')
		autocmd MyAutoCmd FileType yaml.ansible,php,css,less,html,markdown
			\ nmap <silent><buffer> K :!open -g dash://"<C-R>=split(&ft, '\.')[0]<CR>:<cword>"&<CR><CR>
		autocmd MyAutoCmd FileType javascript,javascript.jsx,sql,ruby,conf,sh
			\ nmap <silent><buffer> K :!open -g dash://"<cword>"&<CR><CR>
	endif

" Use Zeal on Linux for context help
elseif executable('zeal')
	autocmd MyAutoCmd FileType yaml.ansible,php,css,less,html,markdown
		\ nmap <silent><buffer> K :!zeal --query "<C-R>=split(&ft, '\.')[0]<CR>:<cword>"&<CR><CR>
	autocmd MyAutoCmd FileType javascript,javascript.jsx,sql,ruby,conf,sh
		\ nmap <silent><buffer> K :!zeal --query "<cword>"&<CR><CR>
endif

" Append modeline to EOF
nnoremap <silent> <Leader>ml :call <SID>append_modeline()<CR>

" Append modeline after last line in buffer
" See: http://vim.wikia.com/wiki/Modeline_magic
function! s:append_modeline() "{{{
	let l:modeline = printf(' vim: set ts=%d sw=%d tw=%d %set :',
				\ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
	let l:modeline = substitute(&commentstring, '%s', l:modeline, '')
	call append(line('$'), l:modeline)
endfunction "}}}

" s: Windows and buffers
nnoremap <silent> [Window]v  :<C-u>split<CR>
nnoremap <silent> [Window]g  :<C-u>vsplit<CR>
nnoremap <silent> [Window]t  :tabnew<CR>
nnoremap <silent> [Window]o  :<C-u>only<CR>
nnoremap <silent> [Window]b  :b#<CR>
nnoremap <silent> [Window]c  :close<CR>
nnoremap <silent> [Window]x  :<C-u>call <SID>BufferEmpty()<CR>

" Split current buffer, go to previous window and previous buffer
nnoremap <silent> [Window]sv :split<CR>:wincmd p<CR>:e#<CR>
nnoremap <silent> [Window]sg :vsplit<CR>:wincmd p<CR>:e#<CR>

function! WipeHiddenBuffers()
	let tpbl=[]
	call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
	for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
		silent execute 'bwipeout' buf
	endfor
endfunction

function! s:BufferEmpty()
	let l:current = bufnr('%')
	if ! getbufvar(l:current, '&modified')
		enew
		silent! execute 'bdelete '.l:current
	endif
endfunction

function! s:SweepBuffers()
	let bufs = range(1, bufnr('$'))
	let hidden = filter(bufs, 'buflisted(v:val) && !bufloaded(v:val)')
	if ! empty(hidden)
		execute 'silent bdelete' join(hidden)
	endif
endfunction

" OpenChangedFiles COMMAND
" Open a split for each dirty file in git
function! OpenChangedFiles()
	only " Close all windows, unless they're modified
	let status =
		\ system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
	let filenames = split(status, "\n")
	exec 'edit ' . filenames[0]
	for filename in filenames[1:]
		exec 'sp ' . filename
	endfor
endfunction

" allows you to align characters in multiple highlighted rows.
nnoremap <Leader>= :Tabularize assignment<CR>
vnoremap <Leader>= :Tabularize assignment<CR>
nnoremap <Leader>: :Tabularize symbol<CR>
vnoremap <Leader>: :Tabularize symbol<CR>
nnoremap <Leader>, :Tabularize comma<CR>
vnoremap <Leader>, :Tabularize comma<CR>

nnoremap <C-z> :PackUpdate<CR>           " Update Plugins
nnoremap <C-x> :qa!<CR>                 " Exit
nnoremap <silent> <leader><leader> <leader>ot<leader>of
"""""""""""""""""""""""
" Vim Buffet
"""""""""""""""""""""""
noremap <C-t> :tabnew split<CR>
nmap <leader>1 <Plug>BuffetSwitch(1)
nmap <leader>2 <Plug>BuffetSwitch(2)
nmap <leader>3 <Plug>BuffetSwitch(3)
nmap <leader>4 <Plug>BuffetSwitch(4)
nmap <leader>5 <Plug>BuffetSwitch(5)
nmap <leader>6 <Plug>BuffetSwitch(6)
nmap <leader>7 <Plug>BuffetSwitch(7)
nmap <leader>8 <Plug>BuffetSwitch(8)
nmap <leader>9 <Plug>BuffetSwitch(9)
nmap <leader>0 <Plug>BuffetSwitch(10)
"""""""""""""""""""""""
" Vim Go
"""""""""""""""""""""""
nnoremap <silent> <LocalLeader>gi :GoImpl<CR>
nnoremap <silent> <LocalLeader>gd :GoDescribe<CR>
nnoremap <silent> <LocalLeader>gc :GoCallees<CR>
nnoremap <silent> <LocalLeader>gC :GoCallers<CR>
nnoremap <silent> <LocalLeader>gs :GoCallstack<CR>
"""""""""""""""""""""""
" Gina
"""""""""""""""""""""""
nnoremap <silent><Leader>gp :Gina push<CR>
"""""""""""""""""""""""
" Goyo
"""""""""""""""""""""""
nnoremap <Leader>G :Goyo<CR>
"""""""""""""""""""""""
" git lists
"""""""""""""""""""""""
nnoremap <Leader>gs  :<C-u>CocList --normal gstatus<CR>
nnoremap <Leader>gi  :<C-u>CocList --normal issues<CR>
nnoremap <Leader>gb  :<C-u>CocList --normal branches<CR>
nnoremap <Leader>gc  :<C-u>CocList --normal commits<CR>
nnoremap <Leader>gf  :<C-u>CocList --normal gfiles<CR>
"""""""""""""""""""""""
" Vim Startify
"""""""""""""""""""""""
nnoremap <silent> <leader>s :Startify<CR>
"""""""""""""""""""""""
" ALE
"""""""""""""""""""""""
nmap [a <Plug>(ale_next_wrap)
nmap ]a <Plug>(ale_previous_wrap)
" toggle line numbers
nnoremap <silent> <leader>n :set number! number?<CR>
"""""""""""""""""""""""
" Better Tagbar
"""""""""""""""""""""""
function! TapTagbar() abort
    if exists("g:loaded_tagbar")
        Vista!!
    else
        packadd vista.vim
        let g:loaded_tagbar = 1
        Vista!!
    endif 
endfunction
function! VistaCoc() abort
    if exists("g:loaded_tagbar")
        Vista finder coc
    else
        packadd vista.vim
        let g:loaded_tagbar = 1
        Vista finder coc
    endif 
endfunction
" toggle tagbar
nnoremap <silent> <leader>ot :call TapTagbar() <CR>
nnoremap <silent> <leader>fv  :call VistaCoc()<CR>

nnoremap <silent> <leader>a :WhichKey '<Space>'<CR>

if executable('lazygit')
	nnoremap <silent> <leader>lg :call OpenLazyGit()<CR>
endif