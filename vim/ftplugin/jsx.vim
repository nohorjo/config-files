source ~/.vim/ftplugin/javascript.vim
source ~/.vim/ftplugin/xml.vim

"jsbeautify
noremap <buffer>  <Leader>ff :call JsxBeautify()<cr>
vnoremap <buffer>  <Leader>ff :call RangeJsxBeautify()<cr>

