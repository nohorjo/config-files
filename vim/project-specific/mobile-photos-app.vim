
function! ManualFolds() 
    setlocal foldmethod=manual
    if search('\<class\>.*{', 'n')
        let start = line('.')
        execute "normal! gg/\\<class\\>.*{\<cr>/^    \\w.*(.*).*{\<cr>zE"
        let lnum = line('.')
        while lnum <= line('.')
            let lnum = line('.')
            normal j[{zf%n
        endwhile
        execute "normal " . start . "gg"
    endif
endfunction

 
if !&diff
    augroup jsfold
        au!
        au InsertLeave *.js call ManualFolds()
    augroup END
endif
