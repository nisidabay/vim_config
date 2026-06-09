" ==============================================================================
" Markdown filetype overrides
" ==============================================================================
" Global settings.vim sets textwidth=80 + formatoptions (with 't' for
" auto-wrap). README files, docs, and prose routinely exceed 80 chars
" (URLs, long bullet lines, plugin lists). The 't' flag would mangle them
" by inserting hard newlines mid-line as you type.
"
" This ftplugin applies to *.md files. Files inside ~/vimwiki/ and
" ~/personalwiki/ get filetype=vimwiki and are unaffected.
" ==============================================================================

" Don't hard-wrap at 80. Display soft-wraps via 'wrap' + 'linebreak' (both
" still active globally).
setlocal textwidth=0

" Pin formatoptions explicitly. Vim's runtime ftplugin/markdown.vim runs
" AFTER our user ftplugin and re-adds 't'. The autocmd at the bottom of
" this file re-strips 't' defensively on every buffer event so the runtime
" ftplugin's late addition cannot mangle prose.
"
" Keep:  c — auto-wrap comments (no-op for markdown, harmless)
"        q — allow 'gq' manual formatting
"        n — numbered lists
"        l — long lines not auto-formatted (preserves long URLs)
" Drop:  t — auto-wrap at textwidth (the bug we are fixing)
"        a — auto-format paragraphs (mangles list structure)
setlocal formatoptions=cqln

augroup markdown_no_autowrap
    autocmd!
    autocmd BufEnter,BufWinEnter,FileType *.md setlocal formatoptions-=t
augroup END
