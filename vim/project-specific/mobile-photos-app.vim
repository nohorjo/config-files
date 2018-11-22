function! ManualFolds() 
    if !exists("b:dofolds")
        let b:dofolds = 1
    elseif !b:dofolds
        return
    endif
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
            let lnum = line('.') + 1
            if !foldlevel('.')
                normal! j[{zf%
            endif
            normal! n
        endwhile
        execute "silent! normal! " . start . "ggzO" . col . "|zt" . screentop . "\<C-y>"
        mkview!
    endif
endfunction

function! ToggleFold()
    if !exists("b:dofolds")
        let b:dofolds = 0
    else
        let b:dofolds = !b:dofolds
    endif
endfunction
 
if !&diff
    augroup jsfold
        au!
        au InsertLeave *.js call ManualFolds()
    augroup END
    nnoremap <Leader>z zE:call ManualFolds()<CR>:call ToggleFold()<CR>
    nnoremap zE zE:call ToggleFold()<CR>
endif

let @t='0w"nyt(j"cci{try{console.time(">>>>>n");}finally{console.timeEnd(">>>>>n");}zEkk"cP/    \\w*{'
