" ==============================================================================
" Plugin Mappings — vimwiki, Codeium, translator, NERDTree, etc.
" LSP mappings are in mappings/lsp.vim.
" ==============================================================================

" --- Spell Check (like Neovim: ls/le) ---
nnoremap <silent> ls :setlocal spell spelllang=es_es<CR>
nnoremap <silent> le :setlocal spell spelllang=en_us<CR>
" Keep old sp/se for backward compat
nnoremap <leader>sp :setlocal spell spelllang=es<CR>
nnoremap <leader>se :setlocal spell spelllang=en_us<CR>

" --- Diff mappings ---
nnoremap <silent> <leader>dN [c " Previous difference
nnoremap <silent> <leader>dP ]c " Next difference
nnoremap <silent> <leader>dg :diffget<CR> " Get diff
nnoremap <silent> <leader>dp :diffput<CR> " Put diff

" --- Vim Configuration Management ---
" Edit and reload .vimrc easily
nnoremap <leader>mv :tabnew $MYVIMRC<CR> 
nnoremap <leader>rv :source $MYVIMRC<CR> 
nnoremap <leader>cv :!cp ~/.vimrc vimrc_copy<CR> 

" --- Plugin Toggle Shortcuts ---
" NERDTree matched to Neovim's <leader>e for explorer
nnoremap <leader>e :NERDTreeToggle<CR>
" Keep old nt for backward compat
nnoremap <leader>nt :NERDTreeToggle<CR>
nnoremap <leader>ut :UndotreeToggle<CR>

" Startify / Home screen
nnoremap <silent> <leader>fy :Startify<CR>

" --- Vimwiki ---
nnoremap <leader>di :VimwikiDiaryIndex<CR>
nnoremap <leader>kal :Calendar<CR>
" VimwikiRenameFile moved to <leader>rR to free <leader>rw for window-right
nnoremap <leader>rR :VimwikiRenameFile<ESC>
nnoremap <leader>ww :VimwikiIndex<CR>
nnoremap <Leader>w1 :VimwikiIndex 1<CR>
nnoremap <Leader>w2 :VimwikiIndex 2<CR>
nnoremap <Leader>ws :VimwikiUISelect<CR>
nnoremap <C-N> :call ToggleMarkdown()<CR>

" Toggle between vimwiki and markdown filetypes
function! ToggleMarkdown()
  if &filetype == 'vimwiki'
    set ft=markdown
  elseif &filetype == 'markdown'
    set ft=vimwiki
  endif
endfunction

" Miscellaneous utilities
noremap <leader>ie :!emoji_insert.sh<CR>

" --- Floating Copilot/Codeium Mappings ---
" NOTE: <C-G> may not arrive in terminal/tmux — Codeium recommends <C-]> 
" if <C-G> stops working. <C-h>/<C-j> can conflict with other mappings
" (window navigation, quickfix list) — adjust if needed.
imap <script><silent><nowait><expr> <C-G> codeium#Accept()
imap <script><silent><nowait><expr> <C-h> codeium#AcceptNextWord()
imap <script><silent><nowait><expr> <C-j> codeium#AcceptNextLine()
imap <C-;>   <Cmd>call codeium#CycleCompletions(1)<CR>
imap <C-,>   <Cmd>call codeium#CycleCompletions(-1)<CR>
imap <C-x>   <Cmd>call codeium#Clear()<CR>

" --- Web Search Integration ---
" Open browser smart search
vmap <silent> gx <Plug>(openbrowser-smart-search)

" Search Firefox for visual selection or word under cursor
vnoremap <silent> <Leader>sw :<C-U>call SearchInFirefox(visualmode(), 1)<CR>
nnoremap <silent> <Leader>sw :set opfunc=SearchInFirefox<CR>g@

" --- Bash help (like Neovim <leader>bh) ---
command! BashHelp !man bash | less
nnoremap <leader>bh :BashHelp<CR>

" --- Get python help for word under cursor (keep legacy) ---
nnoremap <leader>k :<c-u>let save_isk = &iskeyword \| set iskeyword+=. \| execute "!pydoc3 " . expand("<cword>") \| let &iskeyword = save_isk<cr>

" --- Open man pages for word under cursor ---
nnoremap <leader>M :Man <C-R><C-W><CR>
