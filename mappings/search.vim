" ==============================================================================
" Search Mappings — FZF and Telescope-style aliases
" ==============================================================================

" FZF / Search — see plugins.vim for the canonical f-prefix set.
" Additional Telescope-style aliases:
nnoremap <silent> <leader>sf :FzfFiles<CR>
nnoremap <silent> <leader>sb :FzfBuffers<CR>
nnoremap <silent> <leader>sg :FzfRg<CR>
nnoremap <silent> <leader>so :FzfHistory:<CR>
nnoremap <silent> <leader>sm :call FzfManPages()<CR>
" <leader>sk and <leader>sM are aliases for FzfMaps (same as <leader>fM)
nnoremap <silent> <leader>sk :FzfMaps<CR>
nnoremap <silent> <leader>sM :FzfMaps<CR>

" FZF insert mode completions
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
