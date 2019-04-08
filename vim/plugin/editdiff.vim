function! s:EditDiff()
    tabnew %
    let fn = "/tmp/editdiff." . system("uuidgen | tr -d '\n'") . "." . expand("%:e")
    echom fn
    call system("cp " . expand('%') . " " . fn)
    execute "vs " . fn
    call delete(fn)
    diffthis
    wincmd l
    diffthis
endfunction

command! EditDiff call s:EditDiff()
