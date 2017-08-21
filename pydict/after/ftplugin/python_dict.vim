inoremap <silent> <buffer> <S-Tab>  <C-R>=<SID>SetVals()<CR>
			\<C-N><C-R>=<SID>RestoreVals()<CR>

function! s:SetVals()
	let s:py_isk = &isk
	setlocal isk +=.,(
	let s:py_dict = &dict
	let &dict = g:pydict
	return ''
endfunction

function! s:RestoreVals()
	let &dict = s:py_dict
	let &isk = s:py_isk
	return ''
endfunction
