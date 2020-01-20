if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.txt.gpg setfiletype txtgpg
  au! BufRead,BufNewFile *.ts setfiletype typescript
  au! BufRead,BufNewFile gitconfig* setfiletype gitconfig
  au! BufRead,BufNewFile *.elm setfiletype haskell
augroup END

