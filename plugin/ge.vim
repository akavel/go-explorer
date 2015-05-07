if exists('g:loaded_ge')
  finish
endif
let g:loaded_ge = 1

augroup ge_doc
    autocmd!
    autocmd BufReadCmd  godoc://** call ge#doc#read()
augroup END

command! -nargs=* -range -complete=customlist,ge#complete#complete GeDoc :call s:doc(<f-args>)

function! s:doc(arg)
  let path = ge#complete#resolve(a:arg)
  if &filetype != "godoc"
    let thiswin = winnr()
    exe "norm! \<C-W>b"
    if winnr() > 1
      exe "norm! " . thiswin . "\<C-W>w"
      while 1
	if &filetype == "godoc"
	  break
	endif
	exe "norm! \<C-W>w"
	if thiswin == winnr()
	  break
	endif
      endwhile
    endif
    if &filetype != "godoc"
      new
      setl nonumber foldcolumn=0
    endif
  endif
  silent execute 'edit godoc://' . path
endfunction

" vim:ts=4:sw=4:et
