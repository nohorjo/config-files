cabbrev G !git

function! GitDiff()
    let fn = expand('%')
    execute 'tabe ' . fn
    let ft = &ft
    vnew
    execute "read !git show @:" . fn
    normal! ggdd
    execute "set ft=" . ft
    windo diffthis
endfunction

command! -bar Gdiff call GitDiff()

function! GitHistory()
    let fn = expand('%')
    execute 'tabe ' . fn
    let t:ft = &ft
    vnew
    50vnew
    execute 'read !git log --pretty="\%h \%s" --follow ' . fn
    let t:ghistorywin=fn
    normal! ggdd
    set readonly
    call View()
endfunction

command! -bar Ghistory call GitHistory()

function! View()
    if exists('t:ghistorywin')
        let hash = split(getline('.'), ' ')[0]
        2wincmd w
        normal! ggdG
        execute "read !git show " . hash . ":" . t:ghistorywin
        normal! ggdd
        execute "set ft=" . t:ft
        windo diffoff
        2,3windo diffthis
    endif
endfunction
