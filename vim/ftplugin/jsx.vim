"jsbeautify
noremap <buffer>  <Leader>ff :call JsxBeautify()<cr>
vnoremap <buffer>  <Leader>ff :call RangeJsxBeautify()<cr>

"console.log
iabbrev <buffer> clog console.log

"auto xml
inoremap <Space><Tab> <ESC>bce<<C-r>"></<C-r>"><ESC>F<i

