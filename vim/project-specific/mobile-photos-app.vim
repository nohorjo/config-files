
function! ManualFolds() 
    setlocal foldmethod=manual
    if search('\<class\>.*{', 'n')
        let start = line('.')
        let col = col('.')
        normal! H
        let top = line('.')
        execute "normal! gg/\\<class\\>.*{\<cr>/^    \\w.*(.*).*{\<cr>"
        let lnum = line('.')
        while lnum <= line('.')
            let lnum = line('.')
            if !foldlevel('.')
                normal! j[{zf%
            endif
            normal! n
        endwhile
        execute "silent! normal! " . top . "ggzt" . start . "ggzO0" . col . "l"
    endif
endfunction

 
if !&diff
    augroup jsfold
        au!
        au InsertLeave *.js call ManualFolds()
    augroup END
    nnoremap <Leader>z :call ManualFolds()<CR>
endif

let @t='0w"nyt(j"cci{try{console.time(">>>>>n");}finally{console.timeEnd(">>>>>n");}kk"cPzE/    \\w*{'
