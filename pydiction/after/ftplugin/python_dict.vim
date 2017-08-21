inoremap <silent> <buffer> <S-Tab>  <C-R>=<SID>SetVals()<CR>
   \<C-R>=<SID>TabComplete()<CR><C-R>=<SID>RestoreVals()<CR>

function! s:TabComplete()
	return "\<C-N>"
endfunction

function! s:SetVals()
	let s:py_isk = &iskeyword
	setlocal iskeyword +=.,(
	let s:py_dictions = &dictionary
	let &dictionary = g:pydict
	return ''
endfunction

function! s:RestoreVals()
	let &dictionary = s:py_dictions
	let &iskeyword = s:py_isk
	return ''
endfunction
