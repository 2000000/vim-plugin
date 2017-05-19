" To do case-sensitive searches, set noignorecase (:set noic).
" inoremap <silent> <buffer> <Tab> 
inoremap <silent> <buffer> <C-p> 
         \<C-R>=<SID>SetVals()<CR>
         \<C-R>=<SID>TabComplete('down')<CR>
         \<C-R>=<SID>RestoreVals()<CR>

" Make Shift+Tab do python code completion in the reverse direction:
inoremap <silent> <buffer> <S-Tab> 
         \<C-R>=<SID>SetVals()<CR>
         \<C-R>=<SID>TabComplete('up')<CR>
         \<C-R>=<SID>RestoreVals()<CR>

if !exists("*s:TabComplete")
    function! s:TabComplete(direction)
        " Check if the char before the char under the cursor is an 
        " underscore, letter, number, dot or opening parentheses.
        " If it is, and if the popup menu is not visible, use 
        " I_CTRL-X_CTRL-K ('dictionary' only completion)--otherwise, 
        " use I_CTRL-N to scroll downward through the popup menu or
        " use I_CTRL-P to scroll upward through the popup menu, 
        " depending on the value of a:direction.
        " If the char is some other character, insert a normal Tab:
        if searchpos('[_a-zA-Z0-9.(]\%#', 'nb') != [0, 0] 
            if !pumvisible()
                return "\<C-X>\<C-K>"
            else
                if a:direction == 'down'
                    return "\<C-N>"
                else
                    return "\<C-P>"
                endif
            endif
        else
            return "\<Tab>"
        endif
    endfunction
endif

if !exists("*s:SetVals") 
    function! s:SetVals()
        " Save and change config values
        let s:pydiction_save_isk = &iskeyword
        setlocal iskeyword +=.,(

        let s:pydiction_save_dictions = &dictionary
        let &dictionary = g:pydict
        let s:pydiction_save_cot = &completeopt
        let &completeopt = "menu,menuone"
        let s:pydiction_save_pumheight = &pumheight
        if !exists('g:pydiction_menu_height')
            let g:pydiction_menu_height = 8
        endif
        let &pumheight = g:pydiction_menu_height

        return ''
    endfunction
endif

if !exists("*s:RestoreVals")
    function! s:RestoreVals()
        " Restore the user's initial values.
        let &dictionary = s:pydiction_save_dictions
        let &completeopt = s:pydiction_save_cot
        let &pumheight = s:pydiction_save_pumheight
        let &iskeyword = s:pydiction_save_isk
        return ''
    endfunction
endif
