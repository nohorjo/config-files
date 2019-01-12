function! s:LongestLine()
    function! ByLength(a, b)
        return strlen(a:b) - strlen(a:a)
    endfunction
    let start = "0"
    let end = "$"
    return strlen(sort(getline(start, end), "ByLength")[0])
endfunction

function! s:ApplyLineContinuationSpacing()
    normal! mmgg
    let longest = s:LongestLine()
    while search('\\$', 'W')
        normal! xg_lD
        let current = col('.')
        call append(line('.'), '.' . repeat(' ', longest - current - 1) . '\')
        normal! Jxx$
    endwhile
    normal! `m
endfunction

augroup LineConts
    autocmd!
    autocmd! BufWritePre,FileWritePre gitconfig* call s:ApplyLineContinuationSpacing()
    autocmd! InsertLeave gitconfig* silent! s/[ ]*\\/ \\/
augroup END
