function! Surround()
    let char = nr2char(getchar())
    if char == '('
        let otherchar = ')'
    elseif char == '['
        let otherchar = ']'
    elseif char == '{'
        let otherchar = '}'
    elseif char == '<'
        let otherchar = '>'
    else
        let otherchar = char
    endif
    execute "normal! i" . char . "\<C-r>\"" . otherchar . "\<Esc>vi" . char
endfunction

function! SurroundChange()
    execute 'normal! di' . nr2char(getchar()) . "h\"_2x"
    call Surround()
endfunction

vnoremap s d:call Surround()<CR>
vnoremap sd dh"_2xP

nnoremap S :call SurroundChange()<CR>
