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
setlocal textwidth=80
setlocal cindent
setlocal cinoptions=:0,l1,t0,g0,(0
setlocal colorcolumn=81

" Format function
function! s:FormatCBuffer()
    let l:save_cursor = getpos(".")
    let l:save_window = winsaveview()
    
    " Format using the Linux kernel style
    let l:style = g:linux_kernel_style
    silent execute '%!clang-format --style=' . shellescape(l:style)
    
    " Restore cursor position
    call setpos('.', l:save_cursor)
    call winrestview(l:save_window)
endfunction

" Create commands
command! -buffer FormatC call s:FormatCBuffer()

" Key mapping for formatting
nnoremap <buffer> <F3> :FormatC<CR>

" Format on save
augroup c_format_on_save
    autocmd!
    autocmd BufWritePre <buffer> call s:FormatCBuffer()
augroup END

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
