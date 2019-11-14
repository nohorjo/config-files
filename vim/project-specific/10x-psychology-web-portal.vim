set ff=dos

cabbrev TS %:r.ts
cabbrev HTML %:r.html

function! s:DoMove(from, to, comp)
    execute a:from . 'wincmd w'

    call search(a:comp)
    normal! dd
    execute a:to . 'wincmd w'
    normal! G

    call search('import {', 'b')
    normal! pww*
    execute a:from . 'wincmd w'

    let l:count = 2

    try
        normal! ggnddnddn
        let l:count = 3
        normal! dd
    catch
    endtry

    execute a:to . 'wincmd w'

    call search('declarations')
    normal! 3)P

    call search('exports')
    normal! 3)P

    if l:count == 3
        call search('entryComponents')
        normal! $%P
    endif
endfunction

function! MoveComp(from, to, ...)
    for comp in a:000
        call s:DoMove(a:from, a:to, comp)
    endfor
    
    augroup MoveCompSave
        autocmd!
        autocmd TabClosed * execute "wa | augroup MoveCompSave | autocmd! | augroup END"
    augroup END

    execute a:to . 'windo EditDiff'
endfunction
