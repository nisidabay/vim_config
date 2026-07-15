" ==============================================================================
" vim-which-key Configuration
" ==============================================================================

" --- Leader Triggers ---
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

" --- Description Dictionary ---
let g:which_key_map = {}

" Group: f → Find / FZF (old prefix, backward compat)
let g:which_key_map.f = {
      \ 'name': '+find/fzf',
      \ 'f': 'files',
      \ 'b': 'buffers',
      \ 'g': 'git-files',
      \ 'h': 'command-history',
      \ 'k': 'man-pages',
      \ 'm': 'marks',
      \ 'M': 'all-mappings',
      \ 't': 'tags',
      \ 'T': 'buffer-tags',
      \ 'y': 'startify-home',
      \ }

" Group: s → Telescope-style search / Spell / Session
let g:which_key_map.s = {
      \ 'name': '+search',
      \ 'b': 'buffers (FZF)',
      \ 'e': 'spell-english',
      \ 'f': 'files (FZF)',
      \ 'g': 'grep (FZF ripgrep)',
      \ 'k': 'keymaps',
      \ 'l': 'load-session',
      \ 'm': 'man-pages',
      \ 'o': 'old-files / history',
      \ 'p': 'spell-spanish',
      \ 's': 'save-session',
      \ 'w': 'search-web-firefox',
      \ }

" Group: t → Tabs / Terminal / Trouble
let g:which_key_map.t = {
      \ 'name': '+tabs',
      \ 'c': 'close-tab',
      \ 'f': 'first-tab',
      \ 'j': 'prev-tab',
      \ 'k': 'next-tab',
      \ 'l': 'last-tab',
      \ 'n': 'new-tab',
      \ 's': 'list-tabs',
      \ }

" Group: d → Diff / Delete
let g:which_key_map.d = {
      \ 'name': '+diff/delete',
      \ 'd': 'delete-line-blackhole',
      \ 'G': 'delete-to-end-blackhole',
      \ 'N': 'prev-hunk',
      \ 'P': 'next-hunk',
      \ 'g': 'diff-get',
      \ 'p': 'diff-put',
      \ }

" Group: w → Windows / Shebangs
let g:which_key_map.w = {
      \ 'name': '+windows/shebangs',
      \ 'b': 'shebang-bash',
      \ 'l': 'shebang-lua',
      \ 'p': 'shebang-python3',
      \ 'r': 'shebang-ruby',
      \ 'v': 'split-vertical',
      \ '_': 'split-horizontal',
      \ 'e': 'equalize-splits',
      \ 'x': 'close-split',
      \ }

" Group: r → Run / Refactor (keeping existing coc actions)
let g:which_key_map.r = {
      \ 'name': '+run/refactor',
      \ 'e': 'refactor (coc)',
      \ 'g': 'ripgrep (FZF)',
      \ 'n': 'rename (coc)',
      \ 'v': 'reload-vimrc',
      \ 'w': 'vimwiki-rename',
      \ 'p': 'run-python',
      \ 'c': 'run-ruby',
      \ 'r': 'run-rust',
      \ 'l': 'run-lua',
      \ 'z': 'run-zig',
      \ 'N': 'run-nim',
      \ 'B': 'run-bash',
      \ }

" Group: p → Python tools
let g:which_key_map.p = {
      \ 'name': '+python',
      \ 'f': 'autopep8-format',
      \ 's': 'isort-sort-imports',
      \ }

" Group: c → Compile / Config
let g:which_key_map.c = {
      \ 'name': '+compile/config',
      \ 'c': 'compile-c',
      \ 'v': 'valgrind-c',
      \ 'a': {
      \   'name': '+all',
      \   'b': 'close-all-buffers',
      \   },
      \ 'd': 'cd-to-file-dir',
      \ 'l': 'codelens (coc)',
      \ 'r': 'clear-registers',
      \ 'b': 'backup-vimrc',
      \ }

" Group: n → Nim / Neovim-like not found
let g:which_key_map.n = {
      \ 'name': '+nim/toggles',
      \ 'h': 'clear-search',
      \ 'r': 'toggle-relativenumber',
      \ 't': 'nerdtree-toggle',
      \ }

" Group: k → Knowledge / Help
let g:which_key_map.k = {
      \ 'name': '+knowledge',
      \ 'a': {
      \   'name': '+all',
      \   'l': 'calendar',
      \   },
      \ }

" Group: u → Undo
let g:which_key_map.u = {
      \ 'name': '+undo',
      \ 't': 'undotree-toggle',
      \ }

" Group: i → Insert
let g:which_key_map.i = {
      \ 'name': '+insert',
      \ 'e': 'emoji',
      \ 'l': 'shebang-lua',
      \ 'r': 'shebang-ruby',
      \ }

" Group: m → Vim
let g:which_key_map.m = {
      \ 'name': '+vim',
      \ 'v': 'edit-vimrc',
      \ }

" Group: l → Lua / Window left
let g:which_key_map.l = {
      \ 'name': '+lua',
      \ 'e': 'spell-english',
      \ 'f': 'stylua-format',
      \ 's': 'spell-spanish',
      \ 'w': 'window-left',
      \ }

" Group: a → Adate / Actions
let g:which_key_map.a = {
      \ 'name': '+date/actions',
      \ 'd': 'insert-date',
      \ }

" Group: b → Buffer / Bash
let g:which_key_map.b = {
      \ 'name': '+buffer/bash',
      \ 'c': 'close-other-buffers',
      \ 'f': 'shfmt-format',
      \ 'h': 'bash-help',
      \ 'x': 'box-word',
      \ }

" Group: o → Options
let g:which_key_map.o = {
      \ 'name': '+options',
      \ 'n': 'nim-release',
      \ }

" Standalone leaf mappings
let g:which_key_map['.']  = 'set-local-dir'
let g:which_key_map['b']  = 'list-buffers'
let g:which_key_map['M']  = 'man-page'
let g:which_key_map['q']  = {
      \ 'name': '+quickfix',
      \ 'f': 'fix-current (coc)',
      \ }
let g:which_key_map['x']  = 'make-executable'
let g:which_key_map['R']  = 'run-neovim-like-rust'  " Actually rr, but which-key catches it
let g:which_key_map['z']  = 'zig-run'

" --- Register with vim-which-key ---
call which_key#register('<Space>', 'g:which_key_map')

" --- Hide statusline in which-key window (cleaner look) ---
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
