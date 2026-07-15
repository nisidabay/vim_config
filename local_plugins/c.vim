" ~/.vim/ftplugin/c.vim
if exists('b:did_c_ftplugin')
    finish
endif
let b:did_c_ftplugin = 1

" Core settings
setlocal tabstop=8
setlocal shiftwidth=8
setlocal noexpandtab
setlocal softtabstop=8
setlocal textwidth=100
setlocal cindent
setlocal cinoptions=:0,l1,t0,g0,(0
setlocal colorcolumn=101

" Format function — uses .clang-format file in project root (auto-detected)
function! s:FormatCBuffer()
    let l:save_cursor = getpos(".")
    let l:save_window = winsaveview()

    silent execute '%!clang-format'

    call setpos('.', l:save_cursor)
    call winrestview(l:save_window)
endfunction

" Manual format command and mapping
command! -buffer FormatC call s:FormatCBuffer()
nnoremap <buffer> <F3> :FormatC<CR>

" NOTE: Format-on-save is handled by coc.nvim via coc-settings.json.
" The BufWritePre autocmd has been removed to avoid double-formatting.

" Verify settings
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
    \ . 'setlocal tabstop< shiftwidth< expandtab< softtabstop< textwidth< cindent< cinoptions< colorcolumn<'

" Optional: Verify settings when loading the file
call s:VerifySettings()
