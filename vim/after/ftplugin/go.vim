"
" Author:       Chris Kim
" Description:  Filetype specific settings for go
"

setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
autocmd FileType go nmap <silent> <leader>gd <plug>(go-def-tab)

