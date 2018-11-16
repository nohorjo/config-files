function! ManualFolds() 
    function! LinesFromTop()
        let current = line('.')
        normal! H
        let top = line('.')
        execute "silent! normal! " . current . "gg"
        let lines = 0
        while current > top
            normal! k
            let lines = lines + 1
            let current = line('.')
        endwhile
        return lines
    endfunction

    setlocal foldmethod=manual

    if search('\<class\>.*{', 'n')
        let start = line('.')
        let col = col('.') - 1
        let screentop = LinesFromTop()
        execute "normal! gg/\\<class\\>.*{\<cr>/^    \\w.*(.*).*{\<cr>"
        let lnum = line('.')
        while lnum <= line('.')
            normal! j
            let lnum = line('.')
            if !foldlevel('.')
                normal! [{zf%
            endif
            normal! n
        endwhile
        execute "silent! normal! " . start . "ggzO0" . col . "lzt" . screentop . "\<C-y>"
    endif
endfunction

 
if !&diff
    augroup jsfold
        au!
        au InsertLeave *.js call ManualFolds()
    augroup END
    nnoremap <Leader>z :call ManualFolds()<CR>
endif

let @t='0w"nyt(j"cci{try{console.time(">>>>>n");}finally{console.timeEnd(">>>>>n");}zEkk"cP/    \\w*{'
