" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

command! -nargs=1 -complete=custom,PackList
	\ PackOpenUrl call PackInit() | packadd open-browser.vim | call openbrowser#open(
	\    minpac#getpluginfo(<q-args>).url)

command! -nargs=1 -complete=custom,PackList
	\ PackOpenDir call PackInit() | call term_start(&shell,
	\    {'cwd': minpac#getpluginfo(<q-args>).dir,
	\     'term_finish': 'close'})

" Define user commands for updating/cleaning the plugins.
" information of plugins, then performs the task.
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()
command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})

command! Goyo packadd goyo.vim | packadd limelight.vim | Goyo