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
    execute 'vs ' . tempname() . '.' . expand('%:e')
    execute '50vs ' . tempname()
    execute 'read !git log --pretty="\%h \%s" --follow ' . fn
    let t:ghistorywin=fn
    normal! ggdd
    write
    set readonly
    call View()
endfunction

command! -bar Ghistory call GitHistory()

function! View()
    if exists('t:ghistorywin')
        try
            let hashes = [
            \    split(getline(line('.') + 1), ' ')[0],
            \    split(getline('.'), ' ')[0]
            \ ]
        catch
            let hashes = [
            \    split(getline('.'), ' ')[0],
            \    split(getline('.'), ' ')[0]
            \ ]
        endtry
        for hash in hashes
            execute (index(hashes, hash) + 2) . 'wincmd w'
            normal! ggdG
            execute "read !git show " . hash . ":" . t:ghistorywin
            normal! ggdd
            write
        endfor
        windo diffoff
        2,4windo diffthis
    endif
endfunction

command! -bar View call View()
