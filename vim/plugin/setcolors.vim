" Change the color scheme from a list of color scheme names.
" Version 2010-09-12 from http://vim.wikia.com/wiki/VimTip341
" Press key:
"    -           next scheme
"    Shift-F8    previous scheme
if v:version < 700 || exists('loaded_setcolors') || &cp
    finish
endif

let loaded_setcolors = 1

let s:mycolors = [
\'hemisu',
\'detailed',
\'vimbrains',
\'thornbird',
\'wasabi256',
\'evening',
\'lilypink',
\'tropikos-mod',
\'dracula',
\'itg_flat',
\'cobalt2'
\]
let s:justregular = [
\'Tomorrow-Night-Bright',
\'badwolf',
\'CandyPaper',
\'Tomorrow',
\'abstract-mod',
\'soda',
\'valloric',
\'flattown',
\'mango',
\'space-vim-dark',
\'github',
\'kolor'
\]
let s:justdiff = [
\'jellyx-mod',
\'unicon',
\'two-firewatch',
\'hybrid',
\'sublimemonokai',
\'orbital',
\'neverland-darker',
\'zazen',
\'antares',
\'khaki',
\'sorcerer',
\'materialbox',
\'donbass',
\'vendetta'
\]

let s:regularcolours = copy(s:mycolors) + s:justregular
let s:diffcolours = reverse(copy(s:mycolors)) + s:justdiff

function! TimeColour(periodseconds, diff)
    let colours = a:diff ? s:diffcolours : s:regularcolours
    let index = (float2nr(localtime() / a:periodseconds) % len(colours)) - 1
    execute 'colorscheme ' . colours[index]
endfunction

" Set next/previous (how = 1/-1) color from our list of colors.
function! NextColor(how)
    if exists('g:colors_name')
        let current = index(s:mycolors, g:colors_name)
    else
        let current = -1
    endif
    let missing = []
    let how = a:how
    for i in range(len(s:mycolors))
        let current += how
        if !(0 <= current && current < len(s:mycolors))
            let current = (how>0 ? 0 : len(s:mycolors)-1)
        endif
        try
            execute 'colorscheme ' . s:mycolors[current]
            break
        catch /E185:/
            call add(missing, s:mycolors[current])
        endtry
    endfor
    redraw
    if len(missing) > 0
        echo 'Error: colorscheme not found:' join(missing)
    endif
    echo g:colors_name
endfunction

nnoremap - :call NextColor(1)<CR>
nnoremap _ :call NextColor(-1)<CR>

