" ==============================================================================
" Conquer of Completion (CoC) Configuration
" ==============================================================================

" --- Core Behavior ---
" Specify UTF-8 to ensure symbols render correctly
set encoding=utf-8

" Reduce updatetime to 300ms for faster CursorHold events (e.g. highlighting)
set updatetime=300

" Always show the sign column to prevent text shifting as diagnostics load
set signcolumn=yes

" --- Autocompletion UI ---
" Use Tab for navigating completion lists
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Accept completion with Enter, preserving line breaks
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Trigger completion manually
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" --- Language Navigation & Intelligence ---
" Navigate diagnostic issues quickly
nmap <silent> gp <Plug>(coc-diagnostic-prev)
nmap <silent> gP <Plug>(coc-diagnostic-next)

" Go to definitions and references
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" Display documentation in a floating window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if &filetype ==# 'vim' || &filetype ==# 'help'
    execute 'h' expand('<cword>')
  elseif CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    execute 'Man' expand('<cword>')
  endif
endfunction

" Highlight the symbol under the cursor on hover
autocmd CursorHold * silent call CocActionAsync('highlight')

" --- Code Actions & Refactoring ---
" Rename symbol globally
nmap <leader>rn <Plug>(coc-rename)

" Apply selected code actions (e.g. autofixing)
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Quickfix current issue
nmap <leader>qf  <Plug>(coc-fix-current)

" Refactor code broadly
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)

" Code lens actions (execute implicit behaviors)
nmap <leader>cl  <Plug>(coc-codelens-action)

" --- Commands & Lists ---
" Organize imports command
command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')

" Quick access to CoC built-in menus
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<CR>
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<CR>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<CR>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<CR>
nnoremap <silent><nowait> <space>S  :<C-u>CocList -I symbols<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" --- Floating Window Scrolling ---
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
