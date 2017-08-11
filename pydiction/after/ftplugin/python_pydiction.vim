
inoremap <silent> <buffer> <S-Tab> 
         \<C-R>=<SID>SetVals()<CR>
         \<C-R>=<SID>TabComplete()<CR>
         \<C-R>=<SID>RestoreVals()<CR>

if !exists("*s:TabComplete")
    function! s:TabComplete()
		return "\<C-N>"
    endfunction
endif

if !exists("*s:SetVals") 
    function! s:SetVals()
        let s:py_isk = &iskeyword
        setlocal iskeyword +=.,(
        let s:py_dictions = &dictionary
        let &dictionary = g:pydict
        return ''
    endfunction
endif

if !exists("*s:RestoreVals")
    function! s:RestoreVals()
        let &dictionary = s:py_dictions
        let &iskeyword = s:py_isk
        return ''
    endfunction
endif
