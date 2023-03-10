"
" commands for dealing with workspaces in vim
"

let g:session_dir = '~/.vim/sessions'

function! workspaces#root_dir()
  let l:full_path = finddir('.git/..', expand('%:p:h').';')
  let l:root_dir = substitute(l:full_path, ".*/", "", "")
  return l:root_dir
endfunction

function! workspaces#save_session()
  let l:root_dir = workspaces#root_dir()
  exec 'mks! ' . g:session_dir . '/' . l:root_dir
  echo 'saved workspace ' . l:root_dir
endfunction

function! workspaces#pick_session()
  let l:changes = len(filter(getbufinfo(), 'v:val.changed == 1'))
  if l:changes > 0
    echo 'unsaved changes in current buffers. not switching workspaces'
    return
  endif
  call fzf#run({
        \ 'source': 'ls ' . g:session_dir,
        \ 'sink': function('workspaces#restore_session'),
        \ 'down': '30%'
        \ })
endfunction

function! workspaces#restore_session(session)
  bufdo bd
  exec 'source ' . g:session_dir . '/' . a:session
  echo 'switched to workspace ' . a:session
endfunction
