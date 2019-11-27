cabbrev TS %:r:r.component.ts
cabbrev HTML %:r:r.component.html
cabbrev MOD %:r:r.module.ts

function! s:DoMove(from, to, comp)
    execute a:from . 'wincmd w'

    call search(a:comp)
    normal! dd
    execute a:to . 'wincmd w'
    normal! G

    call search('import {', 'b')
    normal! pww*
    execute a:from . 'wincmd w'

    let l:count = 2

    try
        normal! ggnddnddn
        let l:count = 3
        normal! dd
    catch
    endtry

    execute a:to . 'wincmd w'

    call search('declarations')
    normal! 3)P

    call search('exports')
    normal! 3)P

    if l:count == 3
        call search('entryComponents')
        normal! $%P
    endif
endfunction

function! MoveComp(from, to, ...)
    for comp in a:000
        call s:DoMove(a:from, a:to, comp)
    endfor
    
    augroup MoveCompSave
        autocmd!
        autocmd TabClosed * execute "wa | augroup MoveCompSave | autocmd! | augroup END"
    augroup END

    execute a:to . 'windo EditDiff'
endfunction

function! s:DoGetImport(import)
    let l:search = split(a:import, '#')[0]
    try
        let l:num = str2nr(split(a:import, '#')[1])
    catch
        let l:num = 0
    endtry
    let l:fpath = system('find ./src/app/ -name *' . l:search . '*module.ts')
    let l:fpath = split(l:fpath, '\n')

    if len(l:fpath) != 1
        if l:num != 0
            let l:fpath = l:fpath[l:num - 1]
        else
            echo a:import . ': '
            let l:i = 1
            for p in l:fpath
                echo l:i . ': ' . p
                let l:i = l:i + 1
            endfor
            let l:selection = input('Which one? ')
            if l:selection == 0
                return
            endif
            try
                let l:fpath = l:fpath[l:selection - 1]
            catch
                return
            endtry
        endif
    else
        let l:fpath = l:fpath[0]
    endif

    let l:comp = system("grep 'export class' " . l:fpath[:-1])
    let l:comp = split(l:comp, ' ')[2]
    let l:relpath = system('realpath --relative-to=' . expand('%:h') . ' ' . l:fpath)
    let l:relpath = l:relpath[:-5]

    if l:relpath !~ '\./.*'
        let l:relpath = './' . l:relpath
    endif

    return "import { " . l:comp . " } from '" . l:relpath . "';"
endfunction

function! GetImport(...)
    for import in a:000
        let l:import = s:DoGetImport(import)
        if type(l:import) == 1
            call append(line('.'), l:import)
        endif
    endfor
endfunction

function! Import()
python3<<EOF
from subprocess import Popen, PIPE
import vim

cword = vim.eval("expand('<cword>')")

with Popen([
    "grep",
    "-r",
    "export.*%s" % cword,
    "src"
], stdout = PIPE) as proc:
    grep_out = list(map(lambda x: x.split(':')[0], proc.stdout.read().decode('utf-8').split('\n')))
    if len(grep_out) > 1:
        if len(grep_out) is 2:
            index = 0
        else:
            for i, l in enumerate(grep_out):
                if not l == '':
                    print('[%i] %s' % (i, l))
            while True:
                try:
                    index = int(vim.eval("input('Which one? ')"))
                    if index < len(grep_out) - 1 and index >= 0:
                        break
                except ValueError:
                    pass
        with Popen([
            "realpath",
            "--relative-to=%s" % vim.eval("expand('%:h')"),
            grep_out[index]
        ], stdout = PIPE) as proc:
            path = proc.stdout.read().decode('utf-8').strip()[:-3]
            if path[0] != '.':
                path = './' + path
            vim.command("""let impstr = "import { %s } from '%s';" """ % (cword, path))
EOF
    if exists('impstr')
        call append(search('import ', 'bn'), impstr)
    else
        echo 'Not found'
    endif
endfunction

