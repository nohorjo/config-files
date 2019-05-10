function! LinesFrom(top)
    if a:top
        return winline() - 1
    endif
    let start = winline()
    normal! L
    let end = winline()
    normal! ``
    return end - start + 1
endfunction

function! LongestLine(where)
    function! ByLength(a, b)
        return strlen(a:b) - strlen(a:a)
    endfunction
    let start = a:where . "0"
    let end = a:where . "$"
    return strlen(sort(getline(start, end), "ByLength")[0])
endfunction

" resize window to longest line in buffer
nnoremap <Leader>e :exe "vertical resize " . (&foldcolumn + &numberwidth + LongestLine('') + 4)<CR>
" resize window to longest line in window
nnoremap <Leader><Leader>e :exe "vertical resize " . (&foldcolumn + &numberwidth + LongestLine('w') + 4)<CR>

" resize window to current line
nnoremap <Leader>E :exe "vertical resize " . (&foldcolumn + &numberwidth + strlen(getline('.')) + 4)<CR>

" resize to show selected lines
vnoremap <Leader>r :<BS><BS><BS><BS><BS>execute  "resize " . (line("'>") - line("'<") + 1 + (&scrolloff * 2))<CR>zt

" resize window in single steps
nnoremap <Leader><UP> <C-w>+
nnoremap <Leader><DOWN> <C-w>-
nnoremap <Leader><RIGHT> <C-w>>
nnoremap <Leader><LEFT> <C-w><

" WASD resize window in 50% steps
nnoremap <Leader>w :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <Leader>a :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
nnoremap <Leader>s :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <Leader>d :exe "vertical resize " . (winwidth(0) * 3/2)<CR>

" auto resize all windows
nnoremap <Leader>= <C-w>=

