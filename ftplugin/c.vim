" ~/.vim/ftplugin/c.vim
" This file provides settings specific to C files.
" NOTE: The primary C ftplugin is in local_plugins/c.vim (tabstop, shiftwidth,
" format command, etc.). This file only sets options NOT covered there.

" C-specific indentation overrides not set in local_plugins
setlocal cindent
setlocal cinoptions=:0,l1,t0,g0,(0

" Setup undo_ftplugin
let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin . '|' : '')
    \ . 'setlocal cindent< cinoptions<'
