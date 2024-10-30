" Vim mappings
" -------------

 " Autopep format for Python
au FileType python setlocal formatprg=black\ -

" Set leader key
let mapleader = "\<Space>"

" Remap 'jk' and 'kj' to escape in insert and visual modes
inoremap jk <Esc>
inoremap kj <Esc>
vnoremap jk <Esc>
vnoremap kj <Esc>

" Termwinkey
" Move from terminal to window
" Example: C-t k
set termwinkey=<C-T>

" Save/Restore/View sessions
" Mappings for saving and restoring sessions
nnoremap <leader>ss :mksession! ~/.vim/sessions/
nnoremap <leader>sr :source ~/.vim/sessions/

" Function to list and load sessions using fzf
function! s:load_session()
  let l:sessions = split(globpath('~/.vim/sessions', '*'), '\n')
  call fzf#run({
        \ 'source': map(l:sessions, 'fnamemodify(v:val, ":t")'),
        \ 'sink': 'source',
        \ 'dir': '~/.vim/sessions',
        \ 'options': '+m --prompt="Sessions> "',
        \ })
endfunction

" Mapping to view and select sessions
nnoremap <leader>sv :call <SID>load_session()<CR>

" Ensure the sessions directory exists
if !isdirectory($HOME . '/.vim/sessions')
  call mkdir($HOME . '/.vim/sessions', 'p')
endif

" Open term
nnoremap <leader>t :term<CR>

" Switch from terminal mode to normal mode
tnoremap <C-x> <C-\><C-n>
"
" InstantMarkdownPreview
map <leader>md :InstantMarkdownPreview<CR>

" Easy expansion of the active file directory
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" .vimrc modifications
nnoremap <leader>mv :tabnew $MYVIMRC<CR>
nnoremap <leader>rv :source $MYVIMRC"<CR>

" Copy of .vimrc
nnoremap <leader>cv :!cp ~/.vimrc "vim
" Esc key
inoremap kj <Esc>
cnoremap kj <Esc>
inoremap jk <Esc>
cnoremap jk <Esc>

" Show working directory
nnoremap <leader>. :lcd %:p:h<CR>
" Change directory of the current file
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
vnoremap K :m'<-2<cr>gv=gv

" C/C++
nnoremap <leader>gc :!gcc -Wall -Wextra -g -std=c11 -o %< %<.c<CR>
nnoremap <leader>gcp :!g++ -Wall -Wextra -g -std=c++17 -o %< %<.cpp<CR>
nnoremap <leader>gcn :!gcc -Wall -Wextra -g -std=c11 -o %< -lncurses %<.c<CR>
nnoremap <leader>gcs :!gcc -Wall -Wextra -g -std=c11 -o %< -lsqlite3 %<.c<CR>
nnoremap <leader>cf :%!clang-format<CR>

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
nnoremap <leader>8 yyp<c-v>$r-A<Esc>yy1kP<Esc>

" Underline word
nnoremap <leader>9 yyp<c-v>$r-A<CR><Esc>
inoremap <leader>9 <Esc>yyp<c-v>$r-A<CR>

" Compile current rust file
nnoremap <leader>rc :!rustc %<CR>
" Run rust file
nnoremap <leader>rr :!./main <CR>

" Run python code
nnoremap <leader>rp :!python3 %<Esc>

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
nnoremap <leader>wr :w !sudo tee <C-R>=input("Save to file: ")<CR> > /dev/null<Esc>

" Set language
nnoremap <F2> :setlocal spell spelllang=es<CR>
nnoremap <F3> :setlocal spell spelllang=en_us<CR>

" Clipboard 
" For using in Macos
vnoremap <leader>y :w !pbcopy<CR><CR>
nnoremap <leader>p :r !pbpaste<CR>
vnoremap <leader>y :w !kitten clipboard<CR><CR>
nnoremap <leader>p :r !kitten clipboard --get-clipboard<CR>
set clipboard=unnamed
vnoremap <leader>y "+y
nnoremap <leader>p "+p
" Clipboard for Linux
" nnoremap <F4> :r !xclip -o -sel clip<Esc>
" vnoremap <F6> :w !xclip -i -sel clip<CR><CR>
" " Clipboard for wayland
" vnoremap <silent> <C-c> :w !wl-copy<CR><CR>
" nnoremap <silent> <C-v> :r !wl-paste<Esc>

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*node_modules/
"

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
nnoremap <silent><F5> :NERDTreeToggle<CR>

" Icon settings
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1

" If you want different icons for different file types:
let g:WebDevIconsUnicodeDecorateFileNodes = 1
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:DevIconsEnableFolderExtensionPatternMatching = 1

" Highlight full name (not only icons) with the same color
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1


" Tagbar plugin
nmap <F8> :TagbarToggle<CR>
set tags=./tags,tags;$HOME
let g:tagbar_type_c = {
    \ 'kinds' : [
        \ 'f:functions',
        \ 'g:enum',
        \ 's:structs',
        \ 'u:unions',
        \ 't:typedefs',
        \ 'v:variables',
        \ 'd:macros'
    \ ]
\ }

" MACROS FOR ACTING ON WORDS
"
" Surround word with quotes
nnoremap <leader>qwa Bi"<Esc>Ea"<Esc>
" Surround word with markdown code
nnoremap <leader>qwc Bi`<Esc>Ea`<Esc>
" Surround word with markdown bold
nnoremap <leader>qwb Bi**<Esc>Ea**<Esc>
" Surround word with markdown italics
nnoremap <leader>qws Bi*<Esc>Ea*<Esc>
" Surround word with markdown inline code
nnoremap <leader>qwi Bi$<Esc>Ea$<Esc>

" MACROS FOR ACTING ON LINES
"
" Surround line with quotes
nnoremap <leader>qla I"<Esc>$A"<Esc>
" Surround line with markdown code
nnoremap <leader>qlc I`<Esc>$A`<Esc>
" Surround line marked with code with bold 
nnoremap <leader>qlb I**<Esc>$A**<Esc>
" Surround line with Italics
nnoremap <leader>qls I*<Esc>$A*<Esc>
" Surround word with markdown inline code
nnoremap <leader>qli I$<Esc>$A$<Esc>

" Move between windows
" move right
nnoremap <leader>mwr <C-W><C-L>
" move left
nnoremap <leader>mwl <C-W><C-H>
" move down
nnoremap <leader>mwd <C-W><C-J>
" move up
nnoremap <leader>mwu <C-W><C-K>

" Split windows

" split window vertically
nnoremap <leader>v :vsplit<CR>
" split window horizontally
nnoremap <leader>- :split<CR>
" make splitted windows equal width
nnoremap <leader>= <C-W>=
"close current splitted window
nnoremap <leader>c :close<CR>

" Resize windows
nnoremap <C-up> :resize -2<CR>
nnoremap <C-down> :resize +2<CR>
nnoremap <C-left> :vertical resize -2<CR>
nnoremap <C-right> :vertical resize +2<CR>

" Vimwiki 
" Search Vimwiki
nnoremap <leader>ws :!source ~/.bash_aliases && ws<CR>

" Vimwiki Diary mappings

" Index
nnoremap <leader>wdi :VimwikiDiaryIndex<CR>

" Make note
nnoremap <leader>wdn :VimwikiMakeDiaryNote<CR>

" Make yesterday note
nnoremap <leader>wdy :VimwikiMakeYesterdayDiaryNote<CR>

" Make tomorrow note
nnoremap <leader>wdt :VimwikiMakeTomorrowDiaryNote<CR>

" Generate links
nnoremap <leader>wdl :VimwikiDiaryGenerateLinks<CR>

" Vimwiki Tables mappings
" Create table
nnoremap <leader>wt :VimwikiTable<CR>

" VimwikiRenameFile mappings
nnoremap <leader>rf :VimwikiRenameFile<esc>

" Vimwiki TOC
nnoremap <leader>wtoc :VimwikiTOC<esc>

" VimWikiTags
 "Tagbar integration                                            *vimwiki-tagbar*
 "
 "As an alternative to the Table of Contents, you can use the Tagbar plugin
 ""(https://preservim.github.io/tagbar/) to show the headers of your wiki files
 "in a side pane.
 "Download the Python script from
 "https://raw.githubusercontent.com/vimwiki/utils/master/vwtags.py and follow
 "the instructions in it.

let g:tagbar_type_vimwiki = {
          \   'ctagstype':'vimwiki'
          \ , 'kinds':['h:header']
          \ , 'sro':'&&&'
          \ , 'kind2scope':{'h':'header'}
          \ , 'sort':0
          \ , 'ctagsbin':'~/bin/vwtags.py'
          \ , 'ctagsargs': 'markdown'
          \ }

" Vimwiki colorize line
nnoremap <leader>wc

" Folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent

" Save the folds
augroup remember_folds
autocmd!
autocmd BufWinLeave, BufLeave ?* silent! mkview
autocmd BufWinEnter *.* silent! loadview 
augroup END

" Persistent undo
nnoremap <leader>u :UndotreeToggle<CR>
set undofile
set undodir=~/.vim/undodir

" Show buffers
nnoremap <leader>b :set nomore <Bar> :ls <Bar> :set more <CR>:b<leader>
" Delete all buffers but this one
nnoremap <silent> <leader>cab :update <bar> %bd <bar> e# <bar> bd# <CR><CR>

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

" Some abbreviations
iabbr clm Carlos Lacaci Moya
"iabbr email nisidabay@gmail.com
" For pythoh
"iabbr true True
"iabbr false False

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

" Some macros
" Add header to python_nuggets.py
let @h = "I\u2022\u2022\u2022"

" split the lines in 80 characters
let @l = "080li ya0"

" Convenient diff commands
nnoremap <silent> <leader>dU :diffupdate<CR>
nnoremap <silent> <leader>dN ]c "Previous difference"
nnoremap <silent> <leader>dP [c "Previous difference"
nnoremap <silent> <leader>dg :diffget<CR> "Get diff from another file"
nnoremap <silent> <leader>dp :diffput<CR> "Put diff from another file"

" python help
nnoremap <leader>k :<c-u>let save_isk = &iskeyword \|
\ set iskeyword+=. \|
\ execute "!pydoc3 " . expand("<cword>") \|
\ let &iskeyword = save_isk<cr>
"
" search related docsets
nnoremap <silent> <Leader>K :call Dasht(dasht#cursor_search_terms())<Return>

" search ALL the docsets
nnoremap <silent> <Leader><Leader>K :call Dasht(dasht#cursor_search_terms(), '!')<Return>
" search related docsets
vnoremap <silent> <Leader>K y:<C-U>call Dasht(getreg(0))<Return>

" search ALL the docsets
vnoremap <silent> <Leader><Leader>K y:<C-U>call Dasht(getreg(0), '!')<Return>

" sourcery
nnoremap <silent> <leader>cl :CocDiagnostics<cr>
nnoremap <silent> <leader>ch :call CocAction('doHover')<cr>
nnoremap <silent> <leader>cc <plug>(coc-codeaction-cursor)
nnoremap <silent> <leader>ca <plug>(coc-fix-current)
nnoremap <silent> <leader>fi :CocCommand python.sortImports<CR>

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
vnoremap <F5> :call CopytoTab()<CR>

" Generate ALE config file
function! GenerateCompileCommands()
    let l:root = getcwd()
    let l:compile_commands_file = l:root . '/compile_commands.json'
    let l:files = glob(l:root . '/**/*.c', 0, 1)
    let l:compile_commands = []
    let l:compiler_flags = '-Wall -Wextra -std=c11'

    " Read existing compile_commands.json if it exists
    if filereadable(l:compile_commands_file)
        let l:existing_content = join(readfile(l:compile_commands_file), '\n')
        let l:compile_commands = json_decode(l:existing_content)
    endif

    " Create a dictionary for quick lookup of existing entries
    let l:existing_entries = {}
    for entry in l:compile_commands
        let l:existing_entries[entry.file] = entry
    endfor

    " Update or add entries for each .c file
    for l:file in l:files
        let l:rel_path = fnamemodify(l:file, ':.:r')
        let l:command = printf('gcc %s -c %s.c -o %s.o', l:compiler_flags, l:rel_path, l:rel_path)
        let l:entry = {
            \ 'directory': l:root,
            \ 'command': l:command,
            \ 'file': l:file
            \ }
        
        if has_key(l:existing_entries, l:file)
            let l:index = index(l:compile_commands, l:existing_entries[l:file])
            let l:compile_commands[l:index] = l:entry
        else
            call add(l:compile_commands, l:entry)
        endif
    endfor

    " Write the updated compile_commands.json
    call writefile([json_encode(l:compile_commands)], l:compile_commands_file)
    echo "compile_commands.json updated successfully with compiler flags!"
endfunction

nnoremap <Leader>ag :call GenerateCompileCommands()<CR>

