" ==============================================================================
" Core Mappings — leader, esck keys, arrows, editing, navigation, windows,
" tabs, sessions, terminal, relative number, dates, etc.
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
