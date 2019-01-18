function! LinesFrom(bottom)
    let current = line('.')
    if a:bottom
        normal! L
    else
        normal! H
    endif
    let end = line('.')
    execute "silent! normal! " . current . "gg"
    let lines = 0
    while (a:bottom && current < end ) || (!a:bottom && current > end)
        if a:bottom
            normal! j
        else
            normal! k
        endif
        let lines = lines + 1
        let current = line('.')
    endwhile
    return lines + 1
endfunction

function! LongestLine(where)
    function! ByLength(a, b)
        return strlen(a:b) - strlen(a:a)
    endfunction
    let start = a:where . "0"
    let end = a:where . "$"
    return strlen(sort(getline(start, end), "ByLength")[0])
endfunction

nnoremap <Leader>e :exe "vertical resize " . (&foldcolumn + &numberwidth + LongestLine('') + 4)<CR>
nnoremap <Leader><Leader>e :exe "vertical resize " . (&foldcolumn + &numberwidth + LongestLine('w') + 4)<CR>

nnoremap <Leader>E :exe "vertical resize " . (&foldcolumn + &numberwidth + strlen(getline('.')) + 4)<CR>

nnoremap <Leader>d :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <Leader>a :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

nnoremap <Leader>r :exe "resize " . (LinesFrom(0) + (&scrolloff * 2))<CR>L
nnoremap <Leader>R :exe "resize " . (LinesFrom(1) + (&scrolloff * 2))<CR>H

vnoremap <Leader>r :<BS><BS><BS><BS><BS>execute  "resize " . (line("'>") - line("'<") + 1 + (&scrolloff * 2))<CR>

nnoremap <Leader>w :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <Leader>s :exe "resize " . (winheight(0) * 2/3)<CR>

nnoremap <Leader><UP> <C-w>+
nnoremap <Leader><DOWN> <C-w>-
nnoremap <Leader><RIGHT> <C-w>>
nnoremap <Leader><LEFT> <C-w><
nnoremap <Leader>= <C-w>=

