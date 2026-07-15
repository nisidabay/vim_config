" ==============================================================================
" Custom Mappings and Abbreviations
" ==============================================================================

" --- Core Paradigms ---
let mapleader = "\<Space>"

" Remap 'jk' and 'kj' to escape in insert and visual modes
inoremap jk <Esc> 
inoremap kj <Esc> 
vnoremap jk <Esc> 
vnoremap kj <Esc> 
cnoremap kj <Esc> 
cnoremap jk <Esc> 

" Also jj/kk like Neovim
inoremap jj <Esc>
inoremap kk <Esc>
cnoremap jj <Esc>
cnoremap kk <Esc>

" Disable arrow keys to enforce hjkl
nnoremap <down> <Nop>
nnoremap <up> <Nop>
nnoremap <left> <Nop>
nnoremap <right> <Nop>
inoremap <down> <Nop>
inoremap <up> <Nop>
inoremap <left> <Nop>
inoremap <right> <Nop>
vnoremap <down> <Nop>
vnoremap <up> <Nop>
vnoremap <left> <Nop>
vnoremap <right> <Nop>

" --- Line Navigation ---
" j/k move by visual lines (like Neovim)
nnoremap j gj
nnoremap k gk

" --- Editing & Utility ---
" Swap char with next (like Neovim xp)
nnoremap xp xp

" Clear search highlights
nnoremap <leader>nh :nohl<CR>

" Maintain visual selection after shifting indentation
vnoremap < <gv
vnoremap > >gv

" Make current file executable
nnoremap <leader>x :!chmod +x %<CR>

" Save visually selected text to a new file
vnoremap <leader>s :w <C-R>=input("Save to file: ")<CR><Esc>

" Save file as root (sudo)
nnoremap <leader>sr :w !sudo tee <C-R>=input("Save to file: ")<CR> > /dev/null<Esc>

" --- Black Hole Deletes (like Neovim) ---
" Delete line to black hole register (don't clobber clipboard)
nnoremap <leader>dd "_dd
" Delete to end of file (black hole)
nnoremap <leader>dG "_dG

" Yank entire file to system clipboard — defined inside conditional block below
" (Wayland vs X11), only the active branch defines it at runtime.

" --- Visual Mode Line Moves (like Neovim) ---
" Move selected lines down
xnoremap J :m'>+1<CR>gv=gv
" Move selected lines up
xnoremap K :m'<-2<CR>gv=gv

" --- Toggle Relative Number (like Neovim nr) ---
nnoremap nr :call <SID>toggle_relativenumber()<CR>
function! s:toggle_relativenumber()
    if &relativenumber
        set norelativenumber
    else
        set relativenumber
    endif
endfunction

" --- Insert date (like Neovim <leader>ad) ---
nnoremap <leader>ad :.!date<CR>I# Date:<Esc>

" --- Box word around visual/current word (like Neovim <leader>bx) ---
nnoremap <leader>bx yyp<c-v>$r-A<Esc>yy1kP<Esc>

" --- Format buffer to line length (like Neovim <leader>wa) ---
nnoremap <leader>wa gqip

" --- Close all other unmodified buffers (like Neovim <leader>bc) ---
nnoremap <silent> <leader>bc :%bd\|e#\|bd#<CR>

" --- Clear registers (like Neovim <leader>cr) ---
nnoremap <silent> <leader>cr :call setreg('', '')<Bar>for i in range(97,122)\|call setreg(nr2char(i), '')\|endfor<Bar>for i in range(48,57)\|call setreg(nr2char(i), '')\|endfor<Bar>call setreg('+', '')\|call setreg('*', '')\|call setreg('-', '')<CR>

" --- Window & Buffer Management ---
" Move between windows
nnoremap <leader>lw <C-w>h
nnoremap <leader>rw <C-w>l

" Window sizes (like Neovim Alt+letter)
nnoremap <A-d> <C-w>5<
nnoremap <A-i> <C-w>>5
nnoremap <A-k> <C-w>5+
nnoremap <A-j> <C-w>5-

" Split operations (like Neovim)
nnoremap <leader>wv <C-w>v           " Split vertical
nnoremap <leader>w_ <C-w>s           " Split horizontal
nnoremap <leader>we <C-w>=           " Equalize splits
nnoremap <leader>wx :close<CR>       " Close split

" Show and manage buffers
nnoremap <leader>b :set nomore <Bar> :ls <Bar> :set more <CR>:b<leader>
" Delete all buffers except the current one
nnoremap <silent> <leader>cab :update <bar> %bd <bar> e# <bar> bd# <CR><CR>

" --- Tab Management ---
nnoremap <leader>tc :tabclose<CR> 
nnoremap <leader>tf :tabfirst<CR> 
nnoremap <leader>tj :tabprev<CR> 
nnoremap <leader>tk :tabnext<CR> 
nnoremap <leader>tl :tablast<CR> 
nnoremap <leader>tn :tabnew <Space> 
nnoremap <leader>ts :tabs<CR> 

" --- File & Directory Navigation ---
" Easy expansion of the active file directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%' 

" Show working directory
nnoremap <leader>. :lcd %:p:h<CR>:pwd<CR>
" Change directory to the current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR> 

" --- Sessions ---
if !isdirectory($HOME . '/.vim/sessions')
  call mkdir($HOME . '/.vim/sessions', 'p')
endif

function! s:save_session()
  let l:name = input('Session name: ', '')
  if !empty(l:name)
    execute 'mksession! ~/.vim/sessions/'.l:name
    echo "\nSession saved: ".l:name
  endif
endfunction

function! s:load_session()
 let l:sessions = split(globpath('~/.vim/sessions', '*'), '\n')
 call fzf#run({
       \ 'source': map(l:sessions, 'fnamemodify(v:val, ":t")'),
       \ 'sink': {s -> execute('source ~/.vim/sessions/'.s)},
       \ 'dir': '~/.vim/sessions',
       \ 'options': '+m --prompt="Sessions> "',
       \ })
endfunction

nnoremap <leader>ss :call <SID>save_session()<CR>
nnoremap <leader>sl :call <SID>load_session()<CR>

" --- Terminal Integration ---
" Move from terminal to window using C-t k
set termwinkey=<C-T>
" Open term
nnoremap <leader>t :term<CR> 
" Switch from terminal mode to normal mode
tnoremap <C-x> <C-\><C-n> 

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
    " Zig support (like Neovim <leader>rz)
    autocmd FileType zig nnoremap <buffer> <leader>r :!zig run %<CR>
augroup END

" --- Language-specific Run, Format, and Build (like Neovim) ---
" The SmartRun above covers <leader>r per filetype.
" These are explicit <leader>r<letter> mappings matching Neovim's scheme.
" NOTE: <leader>rg is FZF Ripgrep, <leader>rn is coc-rename, <leader>re is
" coc-refactor, <leader>rw is move-window-right and VimwikiRenameFile,
" <leader>rv is source $MYVIMRC — those stay as-is.
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

" FZF / Search — all FZF mappings are in plugins.vim (s-prefix primary,
" f-prefix legacy aliases). This section intentionally left empty
" to avoid duplicate definitions before fzf.vim loads.

" FZF insert mode completions
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" LSP mappings are in coc-config.vim (gd, gr, gp, gP, K, etc.) —
" this section intentionally left empty to avoid duplicate definitions.

" --- Clipboard Integration (Wayland + X11) ---
" Copy yanked content to clipboard
function! s:copy_to_clipboard(type, ...)
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@
  let already_yanked = a:0 > 0 ? a:1 : 0

  if !already_yanked
    if a:type == 'line'
      silent exe "normal! '[V']y"
    elseif a:type == 'block'
      silent exe "normal! `[\<C-V>`]y"
    else
      silent exe "normal! `[v`]y"
    endif
  endif

  if !empty($WAYLAND_DISPLAY) || $XDG_SESSION_TYPE ==? 'wayland'
    call system('wl-copy', @@)
  else
    call system('xclip -selection clipboard', @@)
  endif

  let &selection = sel_save
  let @@ = reg_save
endfunction

" Detect visual mode type for proper clipboard handling
function! s:visual_yank_to_clipboard() abort
  let type = mode() ==# 'V' ? 'line' : mode() ==# "\<C-V>" ? 'block' : 'char'
  call s:copy_to_clipboard(type, 1)
endfunction

" Copy entire buffer to clipboard
function! s:yank_all_to_clipboard() abort
  let reg_save = @@
  silent %y
  call s:copy_to_clipboard('line', 1)
  let @@ = reg_save
endfunction

function! s:yank_with_clipboardfunc(type)
  if a:type == 'line'
    silent normal! `[V`]y
  elseif a:type == 'char'
    silent normal! `[v`]y
  elseif a:type == 'block'
    silent normal! `[\<C-V>`]y
  endif
  call s:copy_to_clipboard(a:type)
endfunction

if !empty($WAYLAND_DISPLAY) || $XDG_SESSION_TYPE ==? 'wayland'
  " Map y operator to yank + copy to clipboard
  nnoremap <silent> y :set operatorfunc=<SID>yank_with_clipboardfunc<CR>g@
  " yy = current line (yank first, then copy to clipboard)
  nnoremap <silent> yy yy:call <SID>copy_to_clipboard('line', 1)<CR>
  " ya = copy entire buffer to clipboard
  nnoremap <silent> <leader>ya :call <SID>yank_all_to_clipboard()<CR>
  " Visual mode y = copy to clipboard (detects char/line/block type)
  vnoremap <silent> y y:call <SID>visual_yank_to_clipboard()<CR>
  " Paste from clipboard
   nnoremap <silent> <expr> p system('wl-paste -n') != '' ? ':let @"=system("wl-paste -n")<CR>p' : 'p'
  vnoremap <silent> p "0p
  " <C-v> for paste from clipboard (like Neovim)
  nnoremap <C-v> :let @"=system('wl-paste -n')<CR>p
  inoremap <C-v> <Esc>:let @"=system('wl-paste -n')<CR>pa
else
  " X11
  nnoremap <silent> y :set operatorfunc=<SID>yank_with_clipboardfunc<CR>g@
  nnoremap <silent> yy yy:call <SID>copy_to_clipboard('line', 1)<CR>
  nnoremap <silent> <leader>ya :call <SID>yank_all_to_clipboard()<CR>
  vnoremap <silent> y y:call <SID>visual_yank_to_clipboard()<CR>
   nnoremap <silent> <expr> p system('xclip -selection clipboard -o') != '' ? ':let @"=system("xclip -selection clipboard -o")<CR>p' : 'p'
  vnoremap <silent> p "0p
  " <C-v> for paste from clipboard (like Neovim)
  nnoremap <C-v> :let @"=system('xclip -selection clipboard -o')<CR>p
  inoremap <C-v> <Esc>:let @"=system('xclip -selection clipboard -o')<CR>pa
endif

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

" --- Functions ---
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

" --- Bash help (like Neovim <leader>bh) ---
command! BashHelp !man bash | less
nnoremap <leader>bh :BashHelp<CR>

" --- Get python help for word under cursor (keep legacy) ---
nnoremap <leader>k :<c-u>let save_isk = &iskeyword \| set iskeyword+=. \| execute "!pydoc3 " . expand("<cword>") \| let &iskeyword = save_isk<cr>

" --- Open man pages for word under cursor ---
nnoremap <leader>M :Man <C-R><C-W><CR>

" ==============================================================================
" Command Mode Abbreviations
" ==============================================================================
iabbr clm Carlos Lacaci Moya
iabbr true True
iabbr false False

cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
