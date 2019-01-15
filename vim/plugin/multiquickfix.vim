function! s:SaveQuickFixList() 
    let t:qfnum = 1
    let g:tabidgen = g:tabidgen + 1
    let t:tabid = g:tabidgen
    let fname = "." . t:tabid . ".cfile"
    call delete(fname)
    let list = getqflist() 
    for i in range(len(list)) 
        if has_key(list[i], 'bufnr') 
            let list[i].filename = fnamemodify(bufname(list[i].bufnr), ':p') 
            unlet list[i].bufnr 
        endif 
    endfor 
    let string = string(list) 
    let lines = split(string, "\n") 
    call writefile(lines, fname) 
endfunction 

function! s:LoadQuickFixList() 
    let fname = "." . t:tabid . ".cfile"
    if filereadable(fname)
        execute winnr("$") . "wincmd w"
        if &buftype == 'quickfix'
            execute (winnr("$") - 1) . "wincmd w"
        endif

        let lines = readfile(fname) 
        let string = join(lines, "\n") 
        call setqflist(eval(string)) 
        if exists("t:qfnum") && t:qfnum > 1
            execute "cc" . t:qfnum
        else
            let t:qfnum = 1
        endif
    else
        cclose
    endif
endfunction

augroup autoquickfix
    autocmd!
    autocmd QuickFixCmdPre * if bufname("%") != "" | tabnew | else | execute "normal! \<C-w>L" | endif
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l* lwindow
    autocmd QuickFixCmdPost * if winnr('$') == 1 | tabclose | else | call s:SaveQuickFixList() | endif | redraw!
    autocmd TabEnter * if exists('t:tabid') | call s:LoadQuickFixList() | endif
    autocmd WinEnter * if &buftype == 'quickfix' | nnoremap <buffer> <Enter> :execute 'let t:qfnum = ' . line('.')<CR>:execute 'cc' . line('.')<CR>zz | endif
    autocmd VimEnter * let g:tabidgen = 0 | silent !rm -f .*.cfile 
augroup END

nnoremap <silent> <C-N> :cn<CR>zvzz:let t:qfnum = t:qfnum + 1<CR>
nnoremap <silent> <C-P> :cp<CR>zvzz:let t:qfnum = t:qfnum - 1<CR>

cabbrev ccl ccl \| call delete("." . t:tabid . ".cfile")
