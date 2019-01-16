function! s:SaveQuickFixList() 
    let t:qfnum = 1
    let t:qflist = getqflist() 
endfunction 

function! s:LoadQuickFixList() 
    if exists("t:qflist")
        execute winnr("$") . "wincmd w"
        if &buftype == 'quickfix'
            execute (winnr("$") - 1) . "wincmd w"
        endif

        call setqflist(t:qflist)
        if exists("t:qfnum") && t:qfnum > 0
            execute "cc" . t:qfnum
        else
            let t:qfnum = 1
        endif
    endif
endfunction

augroup autoquickfix
    autocmd!
    autocmd QuickFixCmdPre * if bufname("%") != "" | tabnew | else | execute "normal! \<C-w>L" | endif
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l* lwindow
    autocmd QuickFixCmdPost * if winnr('$') == 1 | tabclose | else | call s:SaveQuickFixList() | endif | redraw!
    autocmd TabEnter * call s:LoadQuickFixList()
    autocmd WinEnter * if &buftype == 'quickfix' | nnoremap <buffer> <Enter> :execute 'let t:qfnum = ' . line('.')<CR>:execute 'cc' . line('.')<CR>zvzz | endif
augroup END

nnoremap <silent> <C-N> :cn<CR>zvzz:let t:qfnum = t:qfnum + 1<CR>
nnoremap <silent> <C-P> :cp<CR>zvzz:let t:qfnum = t:qfnum - 1<CR>

cabbrev ccl ccl \| if exists('t:qflist') \| unlet t:qflist \| endif
