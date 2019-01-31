function! ManualFolds() 
    if !exists("b:dofolds")
        let b:dofolds = 1
    elseif !b:dofolds
        return
    endif
    function! LinesFromTop()
        let current = line('.')
        normal! H
        let top = line('.')
        execute "silent! normal! " . current . "gg"
        let lines = 0
        while current > top
            normal! k
            let lines = lines + 1
            let current = line('.')
        endwhile
        return lines
    endfunction

    setlocal foldmethod=manual

    let isTest = expand('%') =~ '.test.js$'

    if isTest || search('\<class\>.*{', 'n')
        let start = line('.')
        let col = col('.') - 1
        let screentop = LinesFromTop()
        normal! gg
        if isTest
            execute "normal! /\\s*test(\<cr>"
        else
            execute "normal! /\\<class\\>.*{\<cr>/^    \\w.*(.*).*{\<cr>"
        endif
        for pass in range(1,2)
            let lnum = line('.')
            while lnum <= line('.')
                let lnum = line('.') + 1
                if !foldlevel('.')
                    normal! j[{zf%
                endif
                normal! n
            endwhile
            normal! gg
            if isTest && pass == 1
                execute "normal! /\\s*describe(\<cr>n"
            else
                break
            endif
        endfor
        execute "silent! normal! " . start . "ggzO" . col . "|zt" . screentop . "\<C-y>"
        mkview!
    endif
endfunction

if !&diff
    augroup jsfold
        au!
        au InsertLeave *.js call ManualFolds()
    augroup END
    nnoremap <Leader>z zE:let b:dofolds = 1<CR>:call ManualFolds()<CR>
    nnoremap zE zE:let b:dofolds = 0<CR>
endif

let @t='0w"nyt(j"cci{try{console.time(">>>>>n");}finally{console.timeEnd(">>>>>n");}zEkk"cP/    \\w*{'

function! DisableTests()
    let ws = &wrapscan
    set nowrapscan

    normal! mmgg
    while 1
        let l = line('.')
        call search('^\s*test(')
        if l == line('.')
            break
        endif
        normal! O/*DISABLETESTj$%oDISABLETEST*/
    endwhile

    normal! `m/DISABLETESTddNdd`mzz

    if ws
        set wrapscan
    endif
endfunction

function! EnableTests()
    normal! mm
    g/DISABLETEST/d
    normal! `mzz
endfunction

set makeprg=eslint\ -f\ unix\ common\ __tests__

function! OpenTest()
    execute "vs __tests__/" . substitute(expand('%'), "js$", "test.js", "")
endfunction

inoremap <Leader>t test('', () => {<CR>});<UP><C-o>2f'
inoremap <Leader>d describe('', () => {<CR>});<UP><C-o>2f'

