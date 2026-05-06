" ==============================================================================
" vim-which-key Configuration
" ==============================================================================

" --- Leader Triggers ---
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

" --- Description Dictionary ---
let g:which_key_map = {}

" Group: f → Find / FZF
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

" Group: t → Tabs / Terminal
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

" Group: s → Session / Spell / Search
let g:which_key_map.s = {
      \ 'name': '+session/spell/search',
      \ 'e': 'spell-english',
      \ 'l': 'load-session',
      \ 'p': 'spell-spanish',
      \ 'r': 'sudo-save-as',
      \ 's': 'save-session',
      \ 'w': 'search-firefox',
      \ }

" Group: d → Diff
let g:which_key_map.d = {
      \ 'name': '+diff',
      \ 'N': 'prev-hunk',
      \ 'P': 'next-hunk',
      \ 'g': 'diff-get',
      \ 'p': 'diff-put',
      \ }

" Group: w → Shebangs
let g:which_key_map.w = {
      \ 'name': '+shebangs',
      \ 'b': 'bash',
      \ 'l': 'lua',
      \ 'p': 'python3',
      \ 'r': 'ruby',
      \ }

" Group: g → Git / Translate
let g:which_key_map.g = {
      \ 'name': '+git/translate',
      \ 't': 'translate',
      \ }

" Group: r → Run / Refactor / Ripgrep
let g:which_key_map.r = {
      \ 'name': '+run/refactor',
      \ 'e': 'refactor (coc)',
      \ 'g': 'ripgrep',
      \ 'n': 'rename (coc)',
      \ 'v': 'reload-vimrc',
      \ 'w': 'vimwiki-rename',
      \ }

" Group: c → Config / Vim
let g:which_key_map.c = {
      \ 'name': '+vim/config',
      \ 'a': {
      \   'name': '+all',
      \   'b': 'close-all-buffers',
      \   },
      \ 'd': 'cd-to-file-dir',
      \ 'l': 'codelens (coc)',
      \ 'v': 'backup-vimrc',
      \ }

" Group: n → Trees / Clear
let g:which_key_map.n = {
      \ 'name': '+trees/highlights',
      \ 'h': 'clear-search',
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
      \ }

" Group: m → Vim
let g:which_key_map.m = {
      \ 'name': '+vim',
      \ 'v': 'edit-vimrc',
      \ }

" Group: l → Window left
let g:which_key_map.l = {
      \ 'name': '+window-left',
      \ 'w': 'move-left',
      \ }

" Group: a → Code actions (coc)
let g:which_key_map.a = {
      \ 'name': '+code-action',
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

" --- Register with vim-which-key ---
call which_key#register('<Space>', 'g:which_key_map')

" --- Hide statusline in which-key window (cleaner look) ---
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
