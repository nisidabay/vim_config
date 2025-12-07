" ~/.vim/ftplugin/c.vim
" This file provides settings specific to C files.

if exists('b:did_c_ftplugin')
    finish
endif
let b:did_c_ftplugin = 1

" NOTE: tabstop, shiftwidth, etc., are now set globally for C files in your main plugin config.
" NOTE: Format-on-save is now handled by coc.nvim via coc-settings.json.
" The custom formatting function and mapping have been removed to avoid conflicts.

" C-specific indentation settings
setlocal textwidth=80
setlocal cindent
setlocal cinoptions=:0,l1,t0,g0,(0
setlocal colorcolumn=81

" Verification function to check for Linux kernel style compliance
function! s:VerifySettings()
    let l:issues = []
    
    if &l:shiftwidth != 8
        call add(l:issues, "shiftwidth is " . &l:shiftwidth . " (should be 8)")
    endif
    if &l:tabstop != 8
        call add(l:issues, "tabstop is " . &l:tabstop . " (should be 8)")
    endif
    if &l:expandtab
        call add(l:issues, "expandtab is on (should be off)")
    endif
    
    if !empty(l:issues)
        echohl WarningMsg
        echo "Linux kernel style issues found:"
        for issue in l:issues
            echo "- " . issue
        endfor
        echohl None
    else
        echo "Linux kernel style settings are correct"
    endif
endfunction

" Create verification command
command! -buffer VerifyCSettings call s:VerifySettings()

" Setup undo_ftplugin
let b:undo_ftplugin = (exists('b:undo_ftplugin') ? b:undo_ftplugin . '|' : '')
    \ . 'setlocal textwidth< cindent< cinoptions< colorcolumn<'

" Optional: Verify settings when loading the file
call s:VerifySettings()
