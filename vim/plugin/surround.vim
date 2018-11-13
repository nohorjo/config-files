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
    execute "normal! i" . char . otherchar . "\<ESC>\<LEFT>p"
endfunction

function! SurroundChange() 
    execute 'normal! di' . nr2char(getchar()) . "\<LEFT>\"_x\"_x"
    call Surround()
endfunction

vnoremap s d:call Surround()<CR>
vnoremap sd da<BS><BS><ESC>p

nnoremap S :call SurroundChange()<CR>
