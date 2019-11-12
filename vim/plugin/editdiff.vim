function! s:EditDiff()
    tabnew %
    let fn = tempname() . "." . expand("%:e")
    call system("cp " . expand('%') . " " . fn)
    execute "vs " . fn
    call delete(fn)
    windo diffthis
endfunction

command! EditDiff call s:EditDiff()
