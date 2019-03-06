" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

" Only display message if there's an error
let g:neoformat_only_msg_on_error = 1

let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++17",
            \ "BreakBeforeBraces" : "Stroustrup"}

let g:neoformat_enabled_cpp = ['clang-format', 'uncrustify', 'astyle']