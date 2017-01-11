" Vim ftplugin file
" Language:             Free RPG/ILE based on IBMi 7.1
" Maintainer:           Andreas Louv <andreas@louv.dk>
" Last Change:          Jan 11, 2017
" Version:              7
" URL:                  https://github.com/andlrc/rpgle.vim

" quit when a syntax file was already loaded {{{1
if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

let b:match_words = '\<select\>:\<when\>:\<other\>:\<endsl\>,'
      \ . '\<if\>:\<elseif\>:\<else\>:\<endif\>,'
      \ . '\<do[uw]\>:\<iter\>:\<leave\>:\<enddo\>,'
      \ . '\<begsr\>:\<endsr\>,'
      \ . '\<dcl-proc\>:\<return\>:\<end-proc\>,'
      \ . '\<dcl-pi\>:\<end-pi\>,'
      \ . '\<monitor\>:\<on-error\>:\<endmon\>'

" Proper section jumping {{{

function! <SID>NextSection(pattern, flags) range

  let cnt = v:count1

  mark '
  let pos = getpos('.')
  normal! ^

  while cnt > 0
    call search(a:pattern, a:flags . 'W')
    normal! ^

    let new_pos = getpos('.')
    if pos == new_pos
      execute 'norm! ' a:flags =~# 'b' ? 'gg' : 'G'
      break
    endif
    let pos = new_pos

    let cnt = cnt - 1
  endwhile

endfunction

noremap <script> <buffer> <silent> gd :execute 'keepj normal [[/\<<C-r><C-w>\>/' . "\r"<CR>

noremap <script> <buffer> <silent> ]] :call <SID>NextSection('^\s*dcl-proc', '')<CR>
noremap <script> <buffer> <silent> ][ :call <SID>NextSection('^\s*end-proc', '')<CR>
noremap <script> <buffer> <silent> [[ :call <SID>NextSection('^\s*dcl-proc', 'b')<CR>
noremap <script> <buffer> <silent> [] :call <SID>NextSection('^\s*end-proc', 'b')<CR>

" }}}

" vim: fdm=marker
