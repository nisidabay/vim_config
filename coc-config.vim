" May need for Vim (not Neovim) since coc.nvim calculates byte offset by count
" utf-8 byte sequence
set encoding=utf-8
set nobackup
set nowritebackup

" Improve performance
set updatetime=300
set signcolumn=yes

" Tab completion
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Accept completion with Enter
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Diagnostic navigation
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" ✅ FIXED: Use K for documentation or man page
function! ShowDocumentation()
  if &filetype ==# 'vim' || &filetype ==# 'help'
    execute 'h' expand('<cword>')
  elseif CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    execute 'Man' expand('<cword>')
  endif
endfunction

" ✅ Remap K to use the fixed ShowDocumentation function
nnoremap <silent> K :call ShowDocumentation()<CR>

" Highlight symbol on hold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Format on save for Shell and Python
augroup sh_py
  autocmd!
  autocmd BufWritePre *.sh,*.py call CocAction('format')
augroup END

" Apply code actions
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Quickfix
nmap <leader>qf  <Plug>(coc-fix-current)

" Refactor actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)

" Code lens action
nmap <leader>cl  <Plug>(coc-codelens-action)

" Scroll float windows
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Formatting command
command! -nargs=0 Format :call CocActionAsync('format')

" Organize imports
command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')

" Statusline integration
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" CoCList mappings
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Commenting for C/C++
xnoremap <leader>c :s/^/\/\//<CR>
xnoremap <leader>u :s/^\/\/<CR>

" Quick header switching for C
nnoremap <leader>h :e %:r.h<CR>
nnoremap <leader>c :e %:r.c<CR>

" Autoformat Ruby code
autocmd BufWritePre *.rb :CocCommand format

