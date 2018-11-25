finish

function! SnippetSuggestion(fs, base)
    "TODO implement
    if a:fs
        return 0
    else
        return [a:base]
    endif
endfunction

function! AutoCU(typedchar)
    if a:typedchar =~? '[a-z]'
        if pumvisible()
            call feedkeys("\<C-n>\<C-p>", "n")
        else
            call feedkeys("\<C-n>\<C-n>\<C-n>\<C-p>", "n")
        endif
    endif
endfunction

set completefunc=SnippetSuggestion

augroup AutoPopUp
    au!
    au InsertCharPre * call AutoCU(v:char)
augroup END
