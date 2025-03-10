"
" Author:      Chris Kim
" Description: autocmd settings
"

if has('autocmd')
  augroup Files
    au BufNewFile,BufRead Dockerfile.* set ft=dockerfile
    au FileType yaml set foldmethod=indent
    au BufWritePre *.go :silent! call CocAction('organizeImport')
  augroup END
  augroup Buffer
    au BufWritePost,BufWinLeave,BufLeave,WinLeave ?* if &ft != 'help' && &ft != 'fzf' | mkview! | endif
    au BufWinEnter,BufEnter ?* if &ft != 'help' && &ft != 'fzf' | silent! loadview | execute "AirlineRefresh" | endif
    au BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    au BufWritePost * GitGutter
    au BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif
    au User VimagitUpdateFile call gitgutter#all(1)
    au User CocStatusChange AirlineRefresh
  augroup END
  augroup Folding
    au InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
    au InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
  augroup END
endif
