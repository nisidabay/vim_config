" ==============================================================================
" Language-Specific Mappings — SmartRun, run per language, compilers,
" formatters, shebangs.
" ==============================================================================

" --- Smart Compile & Execute ---
augroup SmartRun
    autocmd!
    autocmd FileType go nnoremap <buffer> <leader>r :!go run %<CR>
    autocmd FileType go nnoremap <buffer> <leader>b :!go build %<CR>
    autocmd FileType sh nnoremap <buffer> <leader>r :!bash %<CR>
    autocmd FileType rust nnoremap <buffer> <leader>r :!rustc %<CR>
    autocmd FileType lua nnoremap <buffer> <leader>r :!lua %<CR>
    autocmd FileType nim nnoremap <buffer> <leader>r :!nim -r c %<CR>
    autocmd FileType python nnoremap <buffer> <leader>r :!python3 %<CR>
    autocmd FileType ruby nnoremap <buffer> <leader>r :!ruby %<CR>
    autocmd FileType c nnoremap <buffer> <leader>r :!gcc % -o %< && ./%<<CR>
    " Zig support
    autocmd FileType zig nnoremap <buffer> <leader>r :!zig run %<CR>
augroup END

" --- Language-specific Run, Format, and Build (like Neovim) ---
" The SmartRun above covers <leader>r per filetype.
" These are explicit <leader>r<letter> mappings matching Neovim's scheme.
" NOTE: <leader>rg is FZF Ripgrep, <leader>rn is coc-rename, <leader>re is
" coc-refactor, <leader>rv is source $MYVIMRC, <leader>rw is window-right.
nnoremap <leader>rp :!python3 %<CR>     " Run Python
nnoremap <leader>rc :!ruby %<CR>        " Run Ruby
nnoremap <leader>rr :!rustc %<CR>       " Run Rust
nnoremap <leader>rl :!lua %<CR>         " Run Lua
nnoremap <leader>rz :!zig run %<CR>     " Run Zig
" nim: <leader>rn is coc-rename, so use <leader>rN for nim run
nnoremap <leader>rN :!nim -r c %<CR>    " Run Nim
" bash: use <leader>rB for bash run
nnoremap <leader>rB :!bash %<CR>        " Run Bash

" Compile C (like Neovim <leader>cc)
nnoremap <leader>cc :!gcc % -o %< && ./%<<CR>
" Compile C with Valgrind (like Neovim <leader>cv)
nnoremap <leader>cv :!gcc -g % -o %< && valgrind --leak-check=yes ./%<<CR>
" Nim release (like Neovim <leader>on)
nnoremap <leader>on :!nim c -d:release -r %<CR>

" Language formatters (like Neovim)
nnoremap <leader>pf :!autopep8 --in-place %<CR>       " Python autoformat
nnoremap <leader>is :!isort %<CR>                       " Python sort imports
nnoremap <leader>bf :!shfmt -w %<CR>                    " Bash format
nnoremap <leader>fg :w<Bar>!gofmt -w %<CR>              " Go format
nnoremap <leader>lf :!stylua %<CR>                      " Lua format
nnoremap <leader>rf :!rubocop --auto-correct-all %<CR>   " Ruby format
" Go format visual selection (like Neovim <leader>vg)
xnoremap <leader>vg :!gofmt<CR>

" Black format for Python (legacy, keep for compatibility)
autocmd FileType python setlocal formatprg=black\ - 

" --- Insert shebang (like Neovim — insert at cursor, not new line) ---
nnoremap <leader>il I#!/usr/bin/env lua<Esc>
nnoremap <leader>wb I#!/usr/bin/env bash<Esc>
nnoremap <leader>wp I#!/usr/bin/env python3<Esc>
nnoremap <leader>ir I#!/usr/bin/env ruby<Esc>
