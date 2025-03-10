"
" Author:       chriskim06
" Description:  Filetype specific settings for markdown
"

function! Render()
  silent execute 'silent !glow ' . expand('%:p')
  redraw!
endfunction
nnoremap <leader>wo :call Render()<cr>
