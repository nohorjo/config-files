"gpg encrypt
augroup gpg
    autocmd!
    autocmd BufWritePost *.gpg !gpg -c --batch --yes -o %.tmp %; mv %.tmp %
augroup END
set foldmethod=marker
set noswf
"gpg decrypt
%!gpg -d -q --pinentry-mode loopback %
