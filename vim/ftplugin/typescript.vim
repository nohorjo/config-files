source ~/.vim/ftplugin/javascript.vim

let g:syntastic_typescript_checkers = ['tslint']
set makeprg=tsc\ -p\ .
