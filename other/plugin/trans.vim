function Transg(word)
python << XXX
import vim
import os

text = vim.eval("a:word")
print text
f = open(os.path.expanduser('~')+"/.vim/other/dict/3k")
w = [line.split() for line in f]
c = len(w)
i = 0
for i in range(0,c):
	if text == w[i][0] or text == w[i][0]+'s':
		if len(w[i]) == 2:
			print w[i][1]
		else:
			print "无解释"
		break

if i == c-1:
	print "无记录"
XXX
endfunction

command! -nargs=0 Trans :call Transg(eval("expand('<cword>')"))
