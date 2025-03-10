"
" commands for dealing with workspaces in vim
"

const s:session_dir = '~/.vim/sessions'

function! workspaces#completion(lead, cmd, cursor)
  let valid_args = ['ls', 'write', 'pick', 'rm']
  return join(valid_args, "\n")
endfunction

function! workspaces#run(...)
  if a:0
    if a:1 == 'write'
      call s:save_session()
    elseif a:1 == 'pick' || a:1 == 'rm'
      call s:pick_session(a:1)
    elseif a:1 == 'ls'
      call s:list_sessions()
    else
      echo 'invalid arg "' . a:1 . '"'
    endif
  else
    call s:pick_session('pick')
  endif
endfunction

function! s:root_dir()
  let l:full_path = finddir('.git/..', expand('%:p:h') . ';')
  if l:full_path == ''
    let l:full_path = getcwd()
  endif
  let l:root_dir = substitute(l:full_path, '.*/', '', '')
  return l:root_dir
endfunction

function! s:pick_session(arg)
  let l:changes = len(filter(getbufinfo(), 'v:val.changed == 1'))
  if l:changes > 0
    echo 'unsaved changes in current buffers. not switching workspaces'
    return
  endif
  let l:cmd = '<sid>restore_session'
  if a:arg == 'rm'
    let l:cmd = '<sid>delete_session'
  endif
  call fzf#run({
        \ 'source': 'ls ' . s:session_dir,
        \ 'sink': function(l:cmd),
        \ 'tmux': '-p 50%',
        \ 'header': 'workspaces',
        \ 'options': ['--bind', 'alt-bs:execute(rm ' . s:session_dir . '/{})', '--bind', 'alt-bs:+reload-sync(ls ' . s:session_dir . ')'],
        \ })
endfunction

function! s:path(name)
  return s:session_dir . '/' . a:name
endfunction

" bit of a hack to just use fzf to display the workspaces without doing
" anything with the selection
function! s:null(session)
endfunction

function! s:list_sessions()
  call fzf#run({
        \ 'source': 'ls ' . s:session_dir,
        \ 'sink': function('<sid>null'),
        \ 'tmux': '-p 50%',
        \ 'header': 'workspaces',
        \ })
endfunction

function! s:save_session()
  let l:root_dir = s:root_dir()
  if argc() > 0
    exec 'argd'
  endif
  exec 'mks! ' . s:path(l:root_dir)
  echo 'saved workspace ' . l:root_dir
endfunction

function! s:restore_session(session)
  bufdo bd
  exec 'source ' . s:path(a:session)
  echo 'switched to workspace ' . a:session
endfunction

function! s:delete_session(session)
  exec 'silent !rm ' . s:path(a:session)
  exec 'redraw!'
  echo 'deleted workspace ' . a:session
endfunction
