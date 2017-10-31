inoremap <silent> <buffer> <S-Tab>  <ESC>bve:s/_/ /g<cr>:noh<cr>A
"noremap <silent> <buffer> <S-Tab>  <ESC>bi<C-R>=Phasej(eval("expand('<cword>')"))<CR><ESC>cw<C-R>=Phaseg()<CR>
function Phasej(word)
let g:Phase_tmp=a:word
return ''
endfunction

function Phaseg()
python << XXX
import vim
t = vim.eval("g:Phase_tmp")
t = t.replace('_', ' ') 
XXX
return pyeval("t")
endfunction

