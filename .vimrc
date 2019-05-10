function! s:LongestLine()
    function! ByLength(a, b)
        return strlen(a:b) - strlen(a:a)
    endfunction
    let start = "0"
    let end = "$"
    return strlen(sort(getline(start, end), "ByLength")[0])
endfunction

function! s:ApplyLineContinuationSpacing()
    normal! mm
    %s/\s*\\\s*$/ \\/g
    normal! gg
    let longest = s:LongestLine()
    while search('\\$', 'W')
        normal! xg_lD
        let current = col('.')
        call append(line('.'), '.' . repeat(' ', longest - current - 1) . '\')
        normal! Jxx$
    endwhile
    normal! `m
endfunction

if !&diff
    augroup LineConts
        autocmd!
        autocmd! BufWritePre,FileWritePre gitconfig* call s:ApplyLineContinuationSpacing()
        autocmd! InsertEnter gitconfig* silent! s/\s*\\$/\\/
    augroup END
endif

inoremap <Leader>f ="!f() { \<CR>    }; f"<ESC>O    
inoremap <Leader><CR> ;\<CR>

