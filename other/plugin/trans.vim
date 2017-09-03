function Transg(word)
python << XXX
import vim
text = vim.eval("a:word")

w = [line.split() for line in open("/home/gjie/.vim/other/dict/4k")]

for i in range(1,2000):
	if text == w[i][0]:
		print w[i][1]
		i = 0
		break

XXX
endfunction

command! -nargs=0 Trans :call Transg(eval("expand('<cword>')"))
