source ~/.vim/ftplugin/javascript.vim
source ~/.vim/ftplugin/jsx.vim

let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi', 'tslint']
set makeprg=tsc\ -p\ .
