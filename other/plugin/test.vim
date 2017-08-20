function SetTime(word)
python << XXX
import vim
text = vim.eval("a:word")
if text == "hello":
	print "你好"
elif text == "canonical":
	print "权威的"
elif text == "bondage":
	print "捆绑"

XXX
endfunction


command! -nargs=0 Trans :call SetTime(eval("expand('<cword>')"))
