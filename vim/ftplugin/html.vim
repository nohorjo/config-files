source ~/.vim/ftplugin/xml.vim

setlocal shiftwidth=2

"jsbeautify
noremap <buffer>  <Leader>ff :call HtmlBeautify()<cr>
vnoremap <buffer>  <Leader>ff :call RangeHtmlBeautify()<cr>

