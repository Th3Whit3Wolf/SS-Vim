augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1
let b:neoformat_basic_format_retab = 0