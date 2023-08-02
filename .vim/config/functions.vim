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

function! FindAndReplace(find, replace)
  if a:find != ""
    execute ':%s/'.a:find.'/'.a:replace.'/gI'
  endif
endfunction
command! -nargs=* FR call FindAndReplace(<f-args>)

function RunFZF()
  let l:ignored = system('git check-ignore ' .. shellescape(expand('%:p')))
  if l:ignored != ""
    call fzf#run({'source': 'fd -I', 'sink': 'e', 'window': { 'width': 0.7, 'height': 0.4 }})
  else
    execute 'Files'
  endif
endfunction
