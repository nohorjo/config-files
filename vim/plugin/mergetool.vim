function! DiffBase(other)
    execute a:other . 'wincmd w'
    let line = line('.')
    4wincmd w

    let base = bufname(2)
    let other = bufname(a:other)

    execute "tabedit " . other
    execute "vs " . base
    windo diffthis
    execute line
endfunction

command! DiffLocal call DiffBase(1)
command! DiffRemote call DiffBase(3)
