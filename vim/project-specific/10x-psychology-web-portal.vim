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

function! s:DoGetImport(import)
    let l:search = split(a:import, '#')[0]
    try
        let l:num = str2nr(split(a:import, '#')[1])
    catch
        let l:num = 0
    endtry
    let l:fpath = system('find ./src/app/ -name *' . l:search . '*module.ts')
    let l:fpath = split(l:fpath, '\n')

    if len(l:fpath) != 1
        if l:num != 0
            let l:fpath = l:fpath[l:num - 1]
        else
            echo a:import . ': '
            echo l:fpath
            return
        endif
    else
        let l:fpath = l:fpath[0]
    endif

    let l:comp = system("grep 'export class' " . l:fpath[:-1])
    let l:comp = split(l:comp, ' ')[2]
    let l:relpath = system('realpath --relative-to=' . expand('%') . ' ' . l:fpath)
    let l:relpath = l:relpath[3:-5]

    if l:relpath !~ '\./.*'
        let l:relpath = './' . l:relpath
    endif

    return "import { " . l:comp . " } from '" . l:relpath . "';"
endfunction

function! GetImport(...)
    for import in a:000
        let l:import = s:DoGetImport(import)
        if type(l:import) == 1
            call append(line('.'), l:import)
        endif
    endfor
endfunction
