"jsbeautify
noremap <buffer>  <Leader>ff :call JsBeautify()<cr>
vnoremap <buffer>  <Leader>ff :call RangeJsBeautify()<cr>

"console.log
iabbrev clog console.log

set syntax=javascript
let g:syntastic_typescript_checkers = ['tslint']
