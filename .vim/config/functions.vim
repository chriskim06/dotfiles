"
" Author:      Chris Kim
" Description: Custom functions
"

function FullPathToFile()
  echo expand('%:p')
endfunction
command Path call FullPathToFile()

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
  let ignored = system('git check-ignore ' .. shellescape(expand('%:p')))
  if ignored != ""
    call fzf#run({'source': 'fd -I', 'sink': 'e', 'window': { 'width': 0.9, 'height': 0.6 }})
  else
    exec 'Files'
  endif
endfunction
