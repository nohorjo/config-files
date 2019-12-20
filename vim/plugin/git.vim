cabbrev G !git

function! GitDiff()
    let fn = expand('%')
    let ft = &ft
    vnew
    execute "read !git show @:" . fn
    execute "set ft=" . ft
    windo diffthis
endfunction

command! -bar Gdiff call GitDiff()
