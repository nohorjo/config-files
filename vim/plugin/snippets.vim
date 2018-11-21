augroup AutoPopUp
    au!
augroup END
finish

function! SnippetSuggestion(fs, base)
    if a:fs
        return 0
    else
        return [a:base]
    endif
endfunction

function! AutoCU(typedchar)
    if a:typedchar != ' '
        call feedkeys("\<C-x>\<C-u>")
    endif
endfunction

set completefunc=SnippetSuggestion

augroup AutoPopUp
    au!
    au InsertCharPre * call AutoCU(v:char)
augroup END
