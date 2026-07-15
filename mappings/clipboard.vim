" ==============================================================================
" Clipboard Mappings — Wayland + X11 clipboard integration with functions.
" ==============================================================================

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
