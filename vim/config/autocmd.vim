"
" Author:      Chris Kim
" Description: autocmd settings
"

if has('autocmd')
  augroup Files
    au BufNewFile,BufRead Dockerfile.* set ft=dockerfile
    au FileType yaml set foldmethod=indent
  augroup END
  augroup Buffer
    au BufWritePost,BufWinLeave,BufLeave,WinLeave ?* if &ft != 'help' && &ft != 'fzf' | mkview! | endif
    au BufWinEnter,BufEnter ?* if &ft != 'help' && &ft != 'fzf' | silent! loadview | execute "AirlineRefresh" | endif
    au BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  augroup END
  augroup Folding
    au InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
    au InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
  augroup END
endif
