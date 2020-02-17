source ~/.vim/ftplugin/javascript.vim

let g:syntastic_typescript_checkers = ['tslint']
set makeprg=tsc\ -p\ .

function! TsFold()
    let fn = tempname()
    execute 'w ' . fn
    "! escape escapes
    let script = ""
    let script .= "const { promises: fs } = require('fs');"
    let script .= "const { TypescriptParser } = require('typescript-parser');"
    let script .= "const parser = new TypescriptParser();"
    let script .= "fs.readFile('%%F', 'utf-8').then(src => {"
    let script .= "    parser.parseSource(src).then(p => {"
    let script .= "        const foldLevels = src.split('\\n').fill(0);"
    let script .= "        p.declarations[0].methods.forEach(m => {"
    let script .= "            const start = src.slice(0, m.start).split('\\n').length;"
    let script .= "            const end = src.slice(0, m.end).split('\\n').length + 1;"
    let script .= "            foldLevels[start] = 1;"
    let script .= "            foldLevels[end] = -1;"
    let script .= "        });"
    let script .= "        foldLevels.forEach((x, i, a) => {"
    let script .= "            if (i) {"
    let script .= "                if (x === 0) {"
    let script .= "                    a[i] = a[i - 1];"
    let script .= "                } else if (x === -1) {"
    let script .= "                    a[i] = 0;"
    let script .= "                }"
    let script .= "            }"
    let script .= "        });"
    let script .= "        console.log(foldLevels.join(''));"
    let script .= "    });"
    let script .= "});"

    let script = substitute(script, '%%F', fn, '')

    let b:levels = system('echo "' . script . '" | NODE_PATH=/usr/local/lib/node_modules/:~/.nvm/versions/node/$(node -v)/lib/node_modules/ node')


    setlocal foldmethod=expr
    setlocal foldexpr=GetPotionFold(v:lnum)

    function! GetPotionFold(lnum)
        return b:levels[a:lnum]
    endfunction
endfunction
