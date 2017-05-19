" To do case-sensitive searches, set noignorecase (:set noic).

" Make the Tab key do python code completion:
inoremap <silent> <buffer> <Tab> 
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
        " Save and change any config values we need.
        " Temporarily change isk to treat periods and opening 
        " parenthesis as part of a keyword -- so we can complete
        " python modules and functions:
        let s:pydiction_save_isk = &iskeyword
        setlocal iskeyword +=.,(

        " Save any current dictionaries the user has set:
        let s:pydiction_save_dictions = &dictionary
        " Temporarily use only pydiction's dictionary:
        let &dictionary = g:pydiction_location

        " Save the ins-completion options the user has set:
        let s:pydiction_save_cot = &completeopt
        " Have the completion menu show up for one or more matches:
        let &completeopt = "menu,menuone"

        " Set the popup menu height:
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

