"gpg encrypt
augroup gpg
    autocmd!
    autocmd BufWritePost *.gpg !gpg -c --batch --yes -o %.tmp %; mv %.tmp %
augroup END

augroup Syntax
    autocmd!
    autocmd InsertEnter *.txt.gpg set syntax=markdown
augroup END

set foldmethod=marker
set foldmarker=##,----
set noswf

"gpg decrypt
%!gpg -d -q --pinentry-mode loopback %
