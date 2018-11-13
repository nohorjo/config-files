"jsbeautify
noremap <buffer>  <Leader>ff :call JsBeautify()<cr>
vnoremap <buffer>  <Leader>ff :call RangeJsBeautify()<cr>

"console.log
iabbrev <buffer> clog console.log

let g:syntastic_javascript_checkers = ['eslint']



