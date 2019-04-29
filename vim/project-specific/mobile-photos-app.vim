function! ManualFolds() 
    if !exists("b:dofolds")
        let b:dofolds = 1
    elseif !b:dofolds
        return
    endif

    setlocal foldmethod=manual

    let isTest = expand('%') =~ '.test.js$'

    if isTest || search('\<class\>.*{', 'n')
        let start = line('.')
        let col = col('.')
        let screentop = winline() - &scrolloff - 1
        0
        if isTest
            execute "normal! /\\s*test(\<cr>"
        else
            while search('\<StyleSheet.create\>({', 'W')
                if !foldlevel('.')
                    normal! j[{zf%
                endif
            endwhile
            0
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
            0
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
    while search('^\s*test(', 'W')
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

command! OpenTest execute "vs __tests__/" . substitute(expand('%'), "js$", "test.js", "")
command! OpenTestAnalytics execute "vs __tests__/" . substitute(expand('%'), "js$", "analytics.test.js", "")

inoremap <Leader>t test('', () => {<CR>});<UP><C-o>2f'
inoremap <Leader>d describe('', () => {<CR>});<UP><C-o>2f'

