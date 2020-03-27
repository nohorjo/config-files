source ~/.vim/ftplugin/javascript.vim
source ~/.vim/ftplugin/jsx.vim

let g:syntastic_typescript_checkers = ['tslint']
set makeprg=tsc\ -p\ .
