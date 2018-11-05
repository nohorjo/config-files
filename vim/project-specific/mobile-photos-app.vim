
function! GetFoldLevel(lnum)
    if a:lnum == line('$')
        return '0'
    endif

    let line = getline(a:lnum)

    if line =~? '^}.*'
        unlet b:classFound
        return '0'
    endif

    function! NextMatching(regex, start)
        let numlines = line('$')
        let current = a:start + 1

        while current <= numlines
            if getline(current) =~? a:regex
                return current
            endif

            let current += 1
        endwhile

        return '0' 
    endfunction

    if !exists('b:classFound') || !b:classFound
        let b:classFound = NextMatching('\<class\>.*{', a:lnum)
    endif

    if b:classFound >= a:lnum
        return '0'
    endif

    let regStart = '^    \w.*(.*).*{' 
    let regEnd =  '^ \{1,4\}}.*$'

    if line =~? regStart
        return '>1'
    endif

    if line =~? regEnd
        return "<1"
    endif

    return "-1"
endfunction

 
if !&diff
    augroup jsfold
        au!
        au BufRead *.js if search('\<class\>.*{', 'n') | setlocal foldexpr=GetFoldLevel(v:lnum) | setlocal foldmethod=expr | setlocal foldlevel=99 | endif
    augroup END
endif
