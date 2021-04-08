cabbrev TS %:r:r.component.ts
cabbrev HTML %:r:r.component.html
cabbrev CSS %:r:r.component.scss
cabbrev MOD %:r:r.module.ts
cabbrev TEST %:r.spec.ts

cabbrev TSP %:r:r.page.ts
cabbrev HTMLP %:r:r.page.html
cabbrev CSSP %:r:r.page.scss

cabbrev CONFIG src/assets/config/config.dev.json

cabbrev F find src/**
cabbrev VF vs \| find src/**

function! s:GetExportPath(compName)
python3<<EOF
from subprocess import Popen, PIPE
import vim

with Popen([
    "grep",
    "-r",
    "export.*\\b%s\\b" % vim.eval("a:compName"),
    "src"
], stdout = PIPE) as proc:
    grep_out = list(map(lambda x: x.split(':')[0], proc.stdout.read().decode('utf-8').split('\n')))
    if len(grep_out) > 1:
        if len(grep_out) == 2:
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
        vim.command("let path = '%s'" % grep_out[index])
EOF
    return path
endfunction

function! Import()
    let path = s:GetExportPath(expand('<cword>'))
python3<<EOF
from subprocess import Popen, PIPE
import vim

with Popen([
    "realpath",
    "--relative-to=%s" % vim.eval("expand('%:h')"),
    vim.eval('path')
], stdout = PIPE) as proc:
    path = proc.stdout.read().decode('utf-8').strip()[:-3]
    if path[0] != '.':
        path = './' + path
    vim.command("""let impstr = "import { %s } from '%s';" """ % (vim.eval("expand('<cword>')"), path))
EOF
    if exists('impstr')
        call append(search('import ', 'bn'), impstr)
    else
        echo 'Not found'
    endif
endfunction

function! GoToDeclaration()
    execute "edit " . s:GetExportPath(expand('<cword>'))
endfunction

function! FindMethod()
python3<<EOF
from subprocess import Popen, PIPE
import vim

with Popen([
    "grep",
    "-Enr",
    "^\\s*%s\\([^\\)]*\\)[ :a-zA-Z<>]+{" % vim.eval("expand('<cword>')"),
    "src"
], stdout = PIPE) as proc:
    grep_out = list(map(lambda x: x.split(':'), proc.stdout.read().decode('utf-8').split('\n')))
    if len(grep_out) > 1:
        if len(grep_out) is 2:
            index = 0
        else:
            for i, l in enumerate(grep_out):
                if not l[0] == '':
                    print('[%i] %s' % (i, l[0]))
            while True:
                try:
                    index = int(vim.eval("input('Which one? ')"))
                    if index < len(grep_out) - 1 and index >= 0:
                        break
                except ValueError:
                    pass
        vim.command("tabe %s" % grep_out[index][0])
        vim.command("%s" % grep_out[index][1])
EOF
endfunction
