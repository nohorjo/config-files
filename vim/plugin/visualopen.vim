function! s:GetV()
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]

    return getline(lnum1)[col1-1:col2-1]
endfunction

function! Open()
    execute "e " . s:GetV()
endfunction

function! VOpen()
    execute "vs " . s:GetV()
endfunction

