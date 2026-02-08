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

" NOTE: The custom surround mappings have been removed.
" The 'vim-surround' plugin is already installed and handles this more efficiently.
" EXAMPLES:
"   - In Normal mode, type `ysiw"` to surround a word in double quotes.
"   - In Normal mode, type `cs"'` to change surrounding " to '.
"   - In Visual mode, select text and type `S*` to surround it with asterisks.

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

" Easy expansion of the active file directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%' 

" .vimrc modifications
nnoremap <leader>mv :tabnew $MYVIMRC<CR> 
nnoremap <leader>rv :source $MYVIMRC"<CR> 

" Copy of .vimrc
nnoremap <leader>cv :!cp ~/.vimrc vimrc_copy<CR> 

" Show working directory
nnoremap <leader>. :lcd %:p:h<CR>:pwd<CR>
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

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Compile/Run Mappings
nnoremap <leader>gb :!go build %<CR>
nnoremap <leader>gl :!go run %<CR>
nnoremap <leader>rb :!bash %<Esc>
nnoremap <leader>rc :!rustc %<CR>
nnoremap <leader>rl :!lua %<Esc>
nnoremap <leader>nr :!nim -r c %<Esc>
nnoremap <leader>rp :!python3 %<Esc>
nnoremap <leader>rr :!ruby %<Esc>

" Make file executable
nnoremap <leader>x :!chmod +x %<CR>

" Comment block in Python and Bash
vnorem <leader>c :normal I#<CR><Esc>

" Uncomment block
vnorem <leader>u :normal ^x <CR><Esc>

" Save selected text in vmode
vnorem <leader>s :w <C-R>=input("Save to file: ")<CR><Esc>

" Write as sudo
nnoremap <leader>sr :w !sudo tee <C-R>=input("Save to file: ")<CR> > /dev/null<Esc>

" Set language
nnoremap <leader>sp :setlocal spell spelllang=es<CR>
nnoremap <leader>se :setlocal spell spelllang=en_us<CR>

" Clipboard mappings based on OS
if has('macunix')
    " Clipboard for MacOS
    vnoremap <silent> <C-c> y:call system('pbcopy', @")<CR>
    nnoremap <silent> <C-v> :let @"=system('pbpaste')<CR>p
elseif has('unix')
    " Check if wl-copy is installed (More reliable than checking Session Type)
    if executable('wl-copy')
        " Clipboard for Wayland
        
        " COPY: Yank current selection into register " then pass that register to wl-copy
        vnoremap <silent> <C-c> y:call system('wl-copy', @")<CR>
        
        " PASTE: Read wl-paste into register " then paste normal style
        nnoremap <silent> <C-v> :let @"=system('wl-paste --no-newline')<CR>p
    else
        " Fallback for Linux (X11) / xclip
        vnoremap <silent> <C-c> y:call system('xclip -i -sel clipboard', @")<CR>
        nnoremap <silent> <C-v> :let @"=system('xclip -o -sel clip')<CR>p
    endif
endif

" Copy the whole buffer
" Map <leader>ya in Normal mode to yank the whole file
nnoremap <leader>ya :%y<CR>

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
" Load termdebug
let g:termdebug_wide=1

" Vimspector (plugin is commented)
" nnoremap <Leader>ds :call vimspector#Launch()<CR>
" nnoremap <Leader>dr :call vimspector#Reset()<CR>
" nmap <Leader>dR <Plug>VimspectorRestart

" nnoremap <Leader>db :call vimspector#ToggleBreakpoint()<CR>
" nnoremap <Leader>dB :call vimspector#ClearBreakpoints()<CR>

" nnoremap <Leader>dc :call vimspector#Continue()<CR>
" nmap <Leader>dh <Plug>VimspectorStepOut
" nmap <Leader>dl <Plug>VimspectorStepInto
" nmap <Leader>dk <Plug>VimspectorStepOver

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
vnorem <ct> :call CopytoTab()<CR>

" Mappings for Codeium
imap <script><silent><nowait><expr> <C-G> codeium#Accept()
imap <script><silent><nowait><expr> <C-h> codeium#AcceptNextWord()
imap <script><silent><nowait><expr> <C-j> codeium#AcceptNextLine()
imap <C-;>   <Cmd>call codeium#CycleCompletions(1)<CR>
imap <C-,>   <Cmd>call codeium#CycleCompletions(-1)<CR>
imap <C-x>   <Cmd>call codeium#Clear()<CR>

" Mappings for opening links
" nmap <silent> gx <Plug>(openbrowser-smart-search)
vmap <silent> gx <Plug>(openbrowser-smart-search)

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
        silent exe "normal! `[\<C-V>\]y"
    else
        silent exe "normal! `[v`]y"
    endif

    let search = substitute(escape(@@, '"\'), '[[:space:]]', '+', 'g')
    silent exe "!firefox 'https://www.google.com/search?q=" . search . "' &"

    let &selection = sel_save
    let @@ = reg_save
endfunction

vnorem <silent> <Leader>sw :<C-U>call SearchInFirefox(visualmode(), 1)<CR>
nnoremap <silent> <Leader>sw :set opfunc=SearchInFirefox<CR>g@

" Vimwiki
nnoremap<leader>di :VimwikiDiaryIndex<CR>
nnoremap<leader>kal :Calendar<CR>
nnoremap<leader>rw :VimwikiRenameFile<ESC>

" Emoji insert
noremap<leader>ie :!emoji_insert.sh<CR>
"
" Mapping to open Startify from any buffer
nnoremap <silent> <leader>fy :Startify<CR>
