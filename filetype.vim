if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.txt.gpg setfiletype txtgpg
  au! BufRead,BufNewFile *.ts setfiletype typescript
augroup END

