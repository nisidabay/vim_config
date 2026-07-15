" ==============================================================================
" mappings.vim — loader for the mappings/ directory
" Individual mapping files live in ~/.vim/mappings/ (sourced in order).
" ==============================================================================

runtime! mappings/core.vim
runtime! mappings/languages.vim
runtime! mappings/search.vim
runtime! mappings/lsp.vim
runtime! mappings/clipboard.vim
runtime! mappings/plugins.vim
runtime! mappings/abbreviations.vim

" ==============================================================================
" Functions (kept here because they are not mappings themselves)
" ==============================================================================

function! CopytoTab()
    normal! gvy
    let tab_number = -1
    for i in range(tabpagenr('$'))
        if gettabvar(i + 1, 'is_code_tab') == 1
            let tab_number = i + 1
            break
        endif
    endfor

    if tab_number == -1
        tabnew
        let t:is_code_tab = 1
        file C-Code
    else
        execute 'tabnext ' . tab_number
    endif

    %delete _
    normal! P
    setlocal filetype=c
    normal! gg
endfunction

function! SearchInFirefox(type, ...)
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@

    if a:0
        silent exe "normal! `<" . a:type . "`>y"
    elseif a:type == 'line'
        silent exe "normal! '[V']y"
    elseif a:type == 'block'
        silent exe "normal! `[\<C-V>\]y"
    else
        silent exe "normal! `[v`]y"
    endif

    let search = substitute(escape(@@, '"\\'), '[[:space:]]', '+', 'g')
    silent exe "!firefox 'https://www.google.com/search?q=" . search . "' &"

    let &selection = sel_save
    let @@ = reg_save
endfunction
