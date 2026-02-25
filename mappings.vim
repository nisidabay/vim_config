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

" --- Window & Buffer Management ---
" Move between windows
nnoremap <leader>lw <C-w>h
nnoremap <leader>rw <C-w>l

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
    autocmd FileType cpp nnoremap <buffer> <leader>r :!g++ % -o %< && ./%<<CR>
augroup END

" Black format for Python
autocmd FileType python setlocal formatprg=black\ - 

" --- Editing & Utility ---
" Clear search highlights
nnoremap <leader>nh :nohls<CR>

" Maintain visual selection after shifting indentation
vnoremap < <gv
vnoremap > >gv

" Make current file executable
nnoremap <leader>x :!chmod +x %<CR>

" Save visually selected text to a new file
vnoremap <leader>s :w <C-R>=input("Save to file: ")<CR><Esc>

" Save file as root (sudo)
nnoremap <leader>sr :w !sudo tee <C-R>=input("Save to file: ")<CR> > /dev/null<Esc>

" Copy the entire buffer to clipboard
nnoremap <leader>ya :%y<CR>
" Copy selected code into a designated "C-Code" tab
vnoremap <ct> :call CopytoTab()<CR>

" Toggle spell check languages
nnoremap <leader>sp :setlocal spell spelllang=es<CR>
nnoremap <leader>se :setlocal spell spelllang=en_us<CR>

" Get python help for word under cursor
nnoremap <leader>k :<c-u>let save_isk = &iskeyword \| set iskeyword+=. \| execute "!pydoc3 " . expand("<cword>") \| let &iskeyword = save_isk<cr>

" Open man pages for word under cursor
nnoremap <leader>M :Man <C-R><C-W><CR>

" Diff mappings
nnoremap <silent> <leader>dN ]c " Previous difference
nnoremap <silent> <leader>dP [c " Next difference
nnoremap <silent> <leader>dg :diffget<CR> " Get diff
nnoremap <silent> <leader>dp :diffput<CR> " Put diff

" --- Vim Configuration Management ---
" Edit and reload .vimrc easily
nnoremap <leader>mv :tabnew $MYVIMRC<CR> 
nnoremap <leader>rv :source $MYVIMRC<CR> 
nnoremap <leader>cv :!cp ~/.vimrc vimrc_copy<CR> 

" --- Plugin Toggle Shortcuts ---
" Toggle NERDTree and Undotree
nnoremap <leader>ut :UndotreeToggle<CR>
nnoremap <leader>nt :NERDTreeToggle<CR>

" Startify
nnoremap <silent> <leader>fy :Startify<CR>

" Vimwiki
nnoremap <leader>di :VimwikiDiaryIndex<CR>
nnoremap <leader>kal :Calendar<CR>
nnoremap <leader>rw :VimwikiRenameFile<ESC>

" Miscellaneous utilities
noremap <leader>ie :!emoji_insert.sh<CR>

" --- Floating Copilot/Codeium Mappings ---
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

    let search = substitute(escape(@@, '"\'), '[[:space:]]', '+', 'g')
    silent exe "!firefox 'https://www.google.com/search?q=" . search . "' &"

    let &selection = sel_save
    let @@ = reg_save
endfunction

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
