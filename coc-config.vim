" ===========================
" === General Settings ===
" ===========================

" Encoding for UTF-8 support
set encoding=utf-8

" Disable backup files to improve performance
set nobackup
set nowritebackup

" Faster updates for CursorHold events
set updatetime=300

" Always show the sign column to prevent text shifting
set signcolumn=yes

" ===========================
" === Completion Settings ===
" ===========================

" Tab completion
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Accept completion with Enter
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Check for backspace to handle tab behavior
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Trigger completion with Ctrl+Space (compatible with Vim and Neovim)
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" ===========================
" === Navigation Mappings ===
" ===========================

" Navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Go to definition and references
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" Show documentation
function! ShowDocumentation()
  if &filetype ==# 'vim' || &filetype ==# 'help'
    execute 'h' expand('<cword>')
  elseif CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    execute 'Man' expand('<cword>')
  endif
endfunction

nnoremap <silent> K :call ShowDocumentation()<CR>

" Highlight symbol on cursor hold
autocmd CursorHold * silent call CocActionAsync('highlight')

" ===========================
" === Code Actions ===
" ===========================

" Rename symbol
nmap <leader>rn <Plug>(coc-rename)

" Apply selected code actions
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Quickfix current issue
nmap <leader>qf  <Plug>(coc-fix-current)

" Refactor code
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)

" Code lens actions
nmap <leader>cl  <Plug>(coc-codelens-action)

" ===========================
" === Formatting ===
" ===========================

augroup coc_formatting
  autocmd!
  autocmd BufWritePre *.sh,*.rb,*.go,*.cpp,*.c,*.kt :silent! CocCommand editor.action.formatDocument
augroup END

" Organize imports
command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')

" ===========================
" === CoCList Mappings ===
" ===========================

" Quick access to diagnostics, extensions, etc.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<CR>
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<CR>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<CR>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<CR>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" ===========================
" === Scrolling in Floating Windows ===
" ===========================

if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" ===========================
" === Statusline Integration ===
" ===========================

" Show Coc status in statusline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" ===========================
" === File Type Specific ===
" ===========================

" Comment/uncomment C/C++ code
xnoremap <leader>c :s/^/\/\//<CR>
xnoremap <leader>u :s/^\/\/<CR>

" Quick header switching for C/C++
nnoremap <leader>h :e %:r.h<CR>
nnoremap <leader>c :e %:r.c<CR>
