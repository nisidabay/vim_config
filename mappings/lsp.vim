" ==============================================================================
" LSP Mappings (coc.nvim)
" ==============================================================================

nmap gd <Plug>(coc-definition)
nmap gr <Plug>(coc-references)
" K is overridden by coc-config.vim -> ShowDocumentation() (hover/docs)
" coc-config.vim is sourced after this file, so the nnoremap wins.
" The line below is left for reference but does NOT take effect:
" nmap K <Plug>(coc-codeaction)
nmap gD <Plug>(coc-declaration)
nmap <space>D <Plug>(coc-type-definition)
nmap <leader>f <Plug>(coc-format)

nmap <silent> gp <Plug>(coc-diagnostic-prev)
nmap <silent> gP <Plug>(coc-diagnostic-next)
