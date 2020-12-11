source ~/.vim/ftplugin/javascript.vim
source ~/.vim/ftplugin/jsx.vim

let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tsuquyomi', 'eslint']
set makeprg=tsc\ -p\ .

augroup FTTypescript
    autocmd!
    autocmd WinEnter *.ts setfiletype typescript
augroup END
