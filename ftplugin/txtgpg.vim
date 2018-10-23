"gpg encrypt/decrypt files
augroup gpg
    autocmd!
    autocmd BufWritePost *.gpg !gpg -c --batch --yes -o %.tmp %; mv %.tmp %
    autocmd BufReadPost *.gpg %!gpg -d -q --pinentry-mode loopback %
    autocmd BufReadPost *.gpg set noswf
    autocmd FileType txtgpg set foldmethod=marker
augroup END

