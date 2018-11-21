function! SaveQuickFixList(fname) 
    let t:qfnum = 1
    call delete(a:fname)
    let list = getqflist() 
    for i in range(len(list)) 
        if has_key(list[i], 'bufnr') 
            let list[i].filename = fnamemodify(bufname(list[i].bufnr), ':p') 
            unlet list[i].bufnr 
        endif 
    endfor 
    let string = string(list) 
    let lines = split(string, "\n") 
    call writefile(lines, a:fname) 
endfunction 

function! LoadQuickFixList(fname) 
    if filereadable(a:fname)
        let lines = readfile(a:fname) 
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

function! UpdateCfilesDelete(start)
    let tabcount = tabpagenr('$')
    if tabcount == start
        call LoadQuickFixList("." . start . ".cfile")
    else
        call delete ("." . a:start . ".cfile")
        for page in range(a:start, tabcount)
            let toMove = "." . (page + 1) . ".cfile"
            if filereadable(toMove)
                silent execute "!mv " . toMove . " ." . page . ".cfile"
            endif
        endfor
    endif
endfunction

function! UpdateCfilesAdd(start)
    for page in reverse(range(a:start, tabpagenr('$')))
        let toMove = "." . page . ".cfile"
        if filereadable(toMove)
            silent execute "!mv " . toMove . " ." . (page + 1) . ".cfile"
        endif
    endfor
endfunction

function! PrepareTab()
    call UpdateCfilesAdd(tabpagenr())
    call delete("." . tabpagenr() . ".cfile")
    if !exists("t:qfnum")
        let t:qfnum = 1
    endif
endfunction

augroup autoquickfix
    autocmd!
    autocmd QuickFixCmdPre * tabnew
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l* lwindow
    autocmd QuickFixCmdPost * call SaveQuickFixList("." . tabpagenr() . ".cfile")
    autocmd TabNew * call PrepareTab()
    autocmd TabEnter * call LoadQuickFixList("." . tabpagenr() . ".cfile")
    autocmd TabClosed * call UpdateCfilesDelete(tabpagenr())
    autocmd WinEnter * if &buftype == 'quickfix' | nnoremap <buffer> <Enter> :execute 'let t:qfnum = ' . line('.')<CR>:execute 'cc' . line('.')<CR>zz | endif
    autocmd VimEnter * execute "!rm  .*.cfile"
augroup END

nnoremap <silent> <C-N> :cn<CR>zvzz:let t:qfnum = t:qfnum + 1<CR>
nnoremap <silent> <C-P> :cp<CR>zvzz:let t:qfnum = t:qfnum - 1<CR>

