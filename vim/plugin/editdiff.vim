function! s:EditDiff()
    tabnew %
    let fn = "/tmp/editdiff." . system("uuidgen | tr -d '\n'") . "." . expand("%:e")
    call system("cp " . expand('%') . " " . fn)
    execute "vs " . fn
    call delete(fn)
    windo diffthis
endfunction

command! EditDiff call s:EditDiff()
