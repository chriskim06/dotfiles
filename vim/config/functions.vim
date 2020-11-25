"
" Author:      Chris Kim
" Description: Custom functions
"

function CloseBuffer()
  if &ft == "help"
    execute 'bd'
  elseif len(getbufinfo({'buflisted':1})) == 1
    execute 'q'
  else
    execute 'bw'
  endif
endfunction
