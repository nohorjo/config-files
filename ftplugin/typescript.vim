"jsbeautify
noremap <buffer>  <Leader>ff :call JsBeautify()<cr>
vnoremap <buffer>  <Leader>ff :call RangeJsBeautify()<cr>

"console.log
noremap <buffer> co oconsole.log('');<ESC>2hi

set syntax=javascript
let g:syntastic_typescript_checkers = ['tslint']
