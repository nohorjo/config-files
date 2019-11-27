cabbrev TS %:r:r.component.ts
cabbrev HTML %:r:r.component.html
cabbrev MOD %:r:r.module.ts

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

