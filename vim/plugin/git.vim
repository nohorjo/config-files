cabbrev G !git

function! GitDiff()
    let fn = expand('%')
    execute 'tabe ' . fn
    execute 'vs ' . tempname() . '.' . expand('%:e')
    execute "read !git show @:" . fn
    normal! ggdd
    write
    windo diffthis
endfunction

command! -bar Gdiff call GitDiff()

function! GitHistory(ref)
    let fn = expand('%')
    execute 'tabe ' . fn
    execute 'sp ' . tempname() . '.' . expand('%:e')
    execute 'vs ' . tempname() . '.' . expand('%:e')
    execute 'vs ' . tempname()
    wincmd H
    vertical resize 50
    execute 'read !git log ' . a:ref .' --pretty="\%h \%s" --follow ' . fn
    let t:ghistorywin=fn
    normal! ggdd
    write
    set readonly
    call View()
endfunction

command! -bar Ghistory call GitHistory('@')

function! View()
    if exists('t:ghistorywin')
        try
            let hashes = [
            \    split(getline(line('.') + 1), ' ')[0],
            \    split(getline('.'), ' ')[0]
            \ ]
        catch
            let hashes = [
            \    split(getline('.'), ' ')[0],
            \    split(getline('.'), ' ')[0]
            \ ]
        endtry
        for hash in hashes
            execute (index(hashes, hash) + 2) . 'wincmd w'
            normal! ggdG
            execute "read !git show " . hash . ":" . t:ghistorywin
            normal! ggdd
            write
        endfor
        windo diffoff
        2,4windo diffthis
        1wincmd w
    endif
endfunction

command! -bar View call View()

function! GitBlame()
    let fn = expand('%')
    let ln = line('.')
    execute 'tabe ' . fn
    normal! gg
    execute 'vs ' . tempname()
    setlocal nowrap
python3<<EOF
from subprocess import Popen, PIPE
import vim
import re

with Popen([
    "git",
    "blame",
    "-p",
    vim.eval("fn")
], stdout = PIPE) as proc:
    lines = proc.stdout.read().decode('utf-8').split('\n')
    out = ""
    ln = 0
    summaries = {}
    committers = {}
    lasthash = ""
    ll = 50
    for l in lines:
        if re.match('^[a-f\d]{40}( \d+){3}$', l):
            lasthash = l[0:7]
            out = out + lasthash
        elif l.startswith('committer-mail'):
            email = l.replace('committer-mail', '')
            out = out + email
            committers[lasthash] = email
        elif l.startswith('summary'):
            summary = l.replace('summary', '')
            out = out + summary
            summaries[lasthash] = summary
        elif l.startswith('\t'):
            if out == lasthash:
                out = "%s%s%s" % (lasthash, committers[lasthash], summaries[lasthash])
            vim.command('call append(%d ,"%s")' % (ln, out))
            ln = ln + 1
            ll = min(max(ll, len(out)), 100)
            out = ""
        vim.command("""exe "vertical resize " . (&foldcolumn + &numberwidth + %d + 4)""" % ll)
EOF
    write
    normal! gg
    windo set scrollbind
    execute ln
endfunction

command! -bar Gblame call GitBlame()

