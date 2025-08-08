" Vim  mappings
" -------------

 " Black format for Python
au FileType python setlocal formatprg=black\ -

" Set leader key
let mapleader = "\<Space>"

" Remap 'jk' and 'kj' to escape in insert and visual modes
inoremap jk <Esc> 
inoremap kj <Esc>
vnoremap jk <Esc>
vnoremap kj <Esc>
cnoremap kj <Esc>
cnoremap jk <Esc>

" Disable arrow keys
no <down> <Nop>
no <up> <Nop>
no <left> <Nop>
no <right> <Nop>

ino <down> <Nop>
ino <up> <Nop>
ino <left> <Nop>
ino <right> <Nop>

vno <down> <Nop>
vno <up> <Nop>
vno <left> <Nop>
vno <right> <Nop>

" Surround selected text with quotes
xnoremap <leader>vc :s/\%V\(^.*$\)/`&`/g<CR>gv

" Surround word with quotes
nnoremap <leader>qwa Bi"<Esc>Ea"<Esc>

" Surround word with code
nnoremap <leader>qwc Bi`<Esc>Ea`<Esc>

" Surround word in bold
nnoremap <leader>qwb Bi**<Esc>Ea**<Esc>

" Surround word with italics
nnoremap <leader>qws Bi*<Esc>Ea*<Esc>

" Surround word inline
nnoremap <leader>qwi Bi$<Esc>Ea$<Esc>

" Surround line with quotes
nnoremap <leader>qla I"<Esc>$A"<Esc>

" Surround line with code
nnoremap <leader>qlc I`<Esc>$A`<Esc>

" Surround line in bold
nnoremap <leader>qlb I**<Esc>$A**<Esc>

" Surround line with italics
nnoremap <leader>qls I*<Esc>$A*<Esc>

" Surround line inline
nnoremap <leader>qli I$<Esc>$A$<Esc>

" Move between windows
nnoremap <leader>lw <C-w>h
nnoremap <leader>rw <C-w>l

" Some abbreviations
iabbr clm Carlos Lacaci Moya
"iabbr email nisidabay@gmail.com
iabbr true True
iabbr false False

" Command mode abreviations for saving and quitting
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


" Show buffers
nnoremap <leader>b :set nomore <Bar> :ls <Bar> :set more <CR>:b<leader>
" Delete all buffers but this one
nnoremap <silent> <leader>cab :update <bar> %bd <bar> e# <bar> bd# <CR><CR>


" Termwinkey
" Move from terminal to window
" Example: C-t k
set termwinkey=<C-T>

" Ensure the sessions directory exists
if !isdirectory($HOME . '/.vim/sessions')
  call mkdir($HOME . '/.vim/sessions', 'p')
endif

" Save/Restore/View sessions 
function! s:save_session()
  let l:name = input('Session name: ', '')  " Added empty default value
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

" Open term
nnoremap <leader>t :term<CR> 

" Switch from terminal mode to normal mode
tnoremap <C-x> <C-\><C-n> 

" InstantMarkdownPreview
map <leader>md :InstantMarkdownPreview<CR> 

" Easy expansion of the active file directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%' 

" .vimrc modifications
nnoremap <leader>mv :tabnew $MYVIMRC<CR> 
nnoremap <leader>rv :source $MYVIMRC"<CR> 

" Copy of .vimrc
nnoremap <leader>cv :!cp ~/.vimrc vimrc_copy<CR> 

" Show working directory
nnoremap <leader>. :lcd %:p:h<CR> 
" Change directory to the current file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR> 

" Tab keys
nnoremap <leader>tc :tabclose<CR> 
nnoremap <leader>tf :tabfirst<CR> 
nnoremap <leader>tj :tabprev<CR> 
nnoremap <leader>tk :tabnext<CR> 
nnoremap <leader>tl :tablast<CR> 
nnoremap <leader>tn :tabnew <Space> 
nnoremap <leader>ts :tabs<CR> 


" No hls. Unselect marked words
nnoremap <leader>nh :nohls<CR> 

" Surround the block with quotes
vnoremap <leader>vc :s/\%V\(^.*$\)/`&`/g<CR>gv 

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Move visual selection one line below
vnoremap J :m'>+1<cr>gv=gv

" Move visual selection one line up
xnoremap K :m'<-2<cr>gv=gv

" C/C++
nnoremap <leader>gc :!gcc -Wall -Wextra -g -std=c11 -o %< %<.c<CR>
nnoremap <leader>gcp :!g++ -Wall -Wextra -g -std=c++17 -o %< %<.cpp<CR>
nnoremap <leader>gcn :!gcc -Wall -Wextra -g -std=c11 -o %< -lncurses %<.c<CR>
nnoremap <leader>gcs :!gcc -Wall -Wextra -g -std=c11 -o %< -lsqlite3 %<.c<CR>
nnoremap <leader>cf :%!clang-format<CR>

" Insert pynuggets header
nnoremap <leader>ph I<C-r>=nr2char(0x2022) . nr2char(0x2022) . nr2char(0x2022)<CR> <Esc>

" Which bash
nnoremap <leader>wb :.!which bash<CR>I#!<Esc>

" Which python3
nnoremap <leader>wp :.!which python3<CR>I#!<Esc>

" Which ruby
nnoremap <leader>wrb :.!which ruby<CR>I#!<Esc>

" Which lua
nnoremap <leader>wl :.!which lua<CR>I#!<Esc>

" Append date
nnoremap <leader>ad :.!date<CR>I# Date: <Esc>

" Underline word
nnoremap <leader>0 yyp<c-v>$r=A<CR><Esc>

" Insert 79 #
nnoremap <leader>7 i#<esc>79a#<esc>

" Insert word in a box
nnoremap <leader>8 yyp<c-v>$r"A<Esc>yy1kP<Esc>

" Underline word
nnoremap <leader>9 yyp<c-v>$r-A<CR><Esc>
inoremap <leader>9 <Esc>yyp<c-v>$r-A<CR>

" Compile current rust file
nnoremap <leader>rc :!rustc %<CR>
" Run rust file
nnoremap <leader>rr :!./main <CR>

" Run python code
nnoremap <leader>rp :!python3 %<Esc>

" Run ruby code
nnoremap <leader>rr :!ruby %<Esc>

" Run lua code
nnoremap <leader>rl :!lua %<Esc>

" Run bash code
nnoremap <leader>rb :!bash %<Esc>

" Run go code
nnoremap <leader>gl :!go run %<Esc>
nnoremap <leader>gb :!go build %<Esc>

" Make file executable
nnoremap <leader>x :!chmod +x %<CR>

" Comment block in Python and Bash
vnoremap <leader>c :normal I#<CR><Esc>

" Uncomment block
vnoremap <leader>u :normal ^x <CR><Esc>

" Save selected text in vmode
vnoremap <leader>s :w <C-R>=input("Save to file: ")<CR><Esc>

" Write as sudo
nnoremap <leader>sr :w !sudo tee <C-R>=input("Save to file: ")<CR> > /dev/null<Esc>

" Set language
nnoremap <leader>sp :setlocal spell spelllang=es<CR>
nnoremap <leader>se :setlocal spell spelllang=en_us<CR>

" Clipboard mappings based on OS
if has('macunix')
    " Clipboard for MacOS
    vnoremap <silent> <C-c> :w !pbcopy<CR><CR>
    nnoremap <silent> <C-v> :r !pbpaste<CR>
elseif has('unix')
    " Check if it's Wayland
    if system('echo $XDG_SESSION_TYPE') =~? 'wayland'
        " Clipboard for Wayland
        vnoremap <silent> <C-c> :w !wl-copy<CR><CR>
        nnoremap <silent> <C-v> :r !wl-paste<CR>
    else
        " Clipboard for Linux (X11)
        vnoremap <silent> <C-c> :w !xclip -i -sel clipboard<CR><CR>
        nnoremap <silent> <C-v> :r !xclip -o -sel clip<CR>
    endif
endif


set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*node_modules/


" NERDTree settings
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['node_modules','\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Close vim if the only window left open is NERDTree
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Toggle NERDTree with ot 
nnoremap <leader>ut :UndotreeToggle<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>

" Tagbar settings
let g:tagbar_autofocus = 1

" Icon settings
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1

" If you want different mappings for diffupdate<CR>
nnoremap <silent> <leader>dN ]c "Previous difference"
nnoremap <silent> <leader>dP [c "Previous difference"
nnoremap <silent> <leader>dg :diffget<CR> "Get diff from another file"
nnoremap <silent> <leader>dp :diffput<CR> "Put diff from another file"

" python help
nnoremap <leader>k :<c-u>let save_isk = &iskeyword \|
\ set iskeyword+=. \|
\ execute "!pydoc3 " . expand("<cword>") \|
\ let &iskeyword = save_isk<cr>

" Mapping for Man pages above the cursor
nnoremap <leader>M :Man <C-R><C-W><CR>
"
" search related docsets
"nnoremap <silent> <Leader>K :call Dasht(dasht#cursor_search_terms())<Return>

" search ALL the docsets
nnoremap <silent> <Leader><Leader>K :call Dasht(dasht#cursor_search_terms(), '!')<Return>
" search related docsets
vnoremap <silent> <Leader>K y:<C-U>call Dasht(getreg(0))<Return>

" search ALL the docsets
vnoremap <silent> <Leader><Leader>K y:<C-U>call Dasht(getreg(0), '!')<Return>

" diagnostic
nnoremap <silent> <leader> dp: <plug>(coc-diagnostic-prev)
nnoremap <silent> <leader> dn: <plug>(coc-diagnostic-next)

" Load termdebug
let g:termdebug_wide=1

" Vimscpector
nnoremap <Leader>ds :call vimspector#Launch()<CR>
nnoremap <Leader>dr :call vimspector#Reset()<CR>
nmap <Leader>dR <Plug>VimspectorRestart

nnoremap <Leader>db :call vimspector#ToggleBreakpoint()<CR>
nnoremap <Leader>dB :call vimspector#ClearBreakpoints()<CR>

nnoremap <Leader>dc :call vimspector#Continue()<CR>
nmap <Leader>dh <Plug>VimspectorStepOut
nmap <Leader>dl <Plug>VimspectorStepInto
nmap <Leader>dk <Plug>VimspectorStepOver

" Copy selected code in new tab
function! CopytoTab()
    " Yank the selected text
    normal! gvy

    " Check if our special tab already exists
    let tab_number = -1
    for i in range(tabpagenr('$'))
        if gettabvar(i + 1, 'is_code_tab') == 1
            let tab_number = i + 1
            break
        endif
    endfor

    if tab_number == -1
        " If the tab doesn't exist, create a new one
        tabnew
        let t:is_code_tab = 1
        file C-Code
    else
        " If it exists, switch to it
        execute 'tabnext ' . tab_number
    endif

    " Clear the contents of the tab
    %delete _

    " Paste the yanked text
    normal! P

    " Set the filetype to C
    setlocal filetype=c

    " Move cursor to the beginning of the file
    normal! gg
endfunction

" Map the function to F5 for visual mode
vnoremap <ct> :call CopytoTab()<CR>

" Mappings for Codeium
imap <script><silent><nowait><expr> <C-G> codeium#Accept()
imap <script><silent><nowait><expr> <C-h> codeium#AcceptNextWord()
imap <script><silent><nowait><expr> <C-j> codeium#AcceptNextLine()
imap <C-;>   <Cmd>call codeium#CycleCompletions(1)<CR>
imap <C-,>   <Cmd>call codeium#CycleCompletions(-1)<CR>
imap <C-x>   <Cmd>call codeium#Clear()<CR>

" Mappings for opening links
nmap <silent> gx <Plug>(openbrowser-smart-search)
vmap <silent> gx <Plug>(openbrowser-smart-search)

"##############################################
" Snippets mappings in the module configuration
"##############################################
"
"
" Search for a word under the cursor
function! SearchInFirefox(type, ...)
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@

    if a:0  " Invoked from Visual mode, use '< and '> marks.
        silent exe "normal! `<" . a:type . "`>y"
    elseif a:type == 'line'
        silent exe "normal! '[V']y"
    elseif a:type == 'block'
        silent exe "normal! `[\<C-V>`]y"
    else
        silent exe "normal! `[v`]y"
    endif

    let search = substitute(escape(@@, '"\'), '[[:space:]]', '+', 'g')
    silent exe "!firefox 'https://www.google.com/search?q=" . search . "' &"

    let &selection = sel_save
    let @@ = reg_save
endfunction

vnoremap <silent> <Leader>sw :<C-U>call SearchInFirefox(visualmode(), 1)<CR>
nnoremap <silent> <Leader>sw :set opfunc=SearchInFirefox<CR>g@

" Vimwiki
nnoremap<leader>di :VimwikiDiaryIndex<CR>
nnoremap<leader>kal :Calendar<CR>
nnoremap<leader>rw :VimwikiRenameFile<ESC>
nnoremap<leader>wt :VimwikiTOC<CR>
nnoremap<leader>ww :VimwikiIndex<CR>

" Map `<leader>8` in visual mode to create a box around selected text
vnoremap <leader>8 :<C-u>call BoxAround()<CR>
function! BoxAround()
  " Get the selected text range
  let l:lines = getline("'<", "'>")

  " Calculate the longest line
  let l:max_length = max(map(copy(l:lines), 'strwidth(v:val)'))

  " Build the box
  let l:top_bottom = '+' . repeat('-', l:max_length + 2) . '+'
  let l:boxed_lines = map(copy(l:lines), '"| ".v:val.repeat(" ", l:max_length-strwidth(v:val))." |"')
  call extend(l:boxed_lines, [l:top_bottom], 0)
  call extend(l:boxed_lines, [l:top_bottom])

  " Replace the selection with the boxed text
  call setline("'<", l:boxed_lines)
endfunction

" format shell scripts
nnoremap <Leader>fs :!shellcheck %<CR>

" Mapping to open Startify from any buffer
nnoremap <silent> <leader>ss :Startify<CR>
