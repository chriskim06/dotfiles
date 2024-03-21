"
" Author:      Chris Kim
" Description: Custom functions
"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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
    call fzf#run({
          \ 'source': 'fd -I',
          \ 'sink': 'e',
          \ 'dir': expand('%:p:h'),
          \ 'options': '--preview "bat --style=numbers --color=always --line-range :500 {} 2>/dev/null"',
          \ 'window': { 'width': 0.8, 'height': 0.8 }
          \ })
  else
    execute 'Files'
  endif
endfunction
