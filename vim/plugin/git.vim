cabbrev G !git

function! GitDiff()
    let fn = expand('%')
    execute 'tabe ' . fn
    execute 'vs ' . tempname() . '.' . expand('%:e')
    execute "read !git show @:" . fn
    normal! ggdd
    write
    windo diffthis
endfunction

command! -bar Gdiff call GitDiff()

function! GitHistory()
    let fn = expand('%')
    execute 'tabe ' . fn
    execute 'vs ' . tempname() . '.' . expand('%:e')
    execute '50vs ' . tempname()
    execute 'read !git log --pretty="\%h \%s" --follow ' . fn
    let t:ghistorywin=fn
    normal! ggddj
    write
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
        write
        windo diffoff
        2,3windo diffthis
    endif
endfunction

command! -bar View call View()
