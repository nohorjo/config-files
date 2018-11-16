finish

function! SnippetSuggestion(fs, base)
    if a:fs
        return 0
    else 
        return [a:base]
    endif
endfunction

set completefunc=SnippetSuggestion

augroup AutoPopUp
    au!
    au TextChangedI * call feedkeys("\<C-x>\<C-U>")
augroup END
