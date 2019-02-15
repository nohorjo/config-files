" Change the color scheme from a list of color scheme names.
" Version 2010-09-12 from http://vim.wikia.com/wiki/VimTip341
" Press key:
"   -                next scheme
"   Shift-F8          previous scheme
if v:version < 700 || exists('loaded_setcolors') || &cp
  finish
endif

let loaded_setcolors = 1

let s:darkregular = [ 'badwolf',
\'cabin',
\'flattown',
\'hydrangea-mod',
\'itg_flat',
\'kolor',
\'lilypink',
\'materialbox',
\'moonfly',
\'space-vim-dark',
\'sublimemonokai',
\'tropikos',
\'turtles',
\'two-firewatch',
\'valloric',
\'vimbrains',
\'evening' ]
let s:blackregular = [ 'abstract-mod', 
\'antares',
\'bleh',
\'CandyPaper',
\'detailed',
\'itsasoa',
\'jellyx',
\'magellan',
\'mango',
\'neverland-darker',
\'sidonia',
\'sorcerer',
\'thornbird',
\'Tomorrow-Night-Bright',
\'vendetta',
\'wasabi256',
\'znake' ]

let s:lightregular = [
\'donbass',
\'github',
\'hemisu',
\'hybrid',
\'soda',
\'Tomorrow',
\'unicon']
let s:darkdiff = [ 'elda',
\'orbital',
\'phosphor',
\'tone',
\'zazen' ]
let s:fancyregular = [ 'dracula',
\'cobalt2',
\'night-owl' ]
let s:lightdiff = [ 'khaki-mod' ]

let s:mycolors = s:lightregular + s:lightdiff + s:fancyregular + s:darkregular + s:darkdiff + s:blackregular

" Set next/previous/random (how = 1/-1/0) color from our list of colors.
" The 'random' index is actually set from the current time in seconds.
" Global (no 's:') so can easily call from command line.
function! NextColor(how)
  call s:NextColor(a:how, 1)
endfunction

" Helper function for NextColor(), allows echoing of the color name to be
" disabled.
function! s:NextColor(how, echo_color)
  if exists('g:colors_name')
    let current = index(s:mycolors, g:colors_name)
  else
    let current = -1
  endif
  let missing = []
  let how = a:how
  for i in range(len(s:mycolors))
    if how == 0
      let current = localtime() % len(s:mycolors)
      let how = 1  " in case random color does not exist
    else
      let current += how
      if !(0 <= current && current < len(s:mycolors))
        let current = (how>0 ? 0 : len(s:mycolors)-1)
      endif
    endif
    try
      execute 'colorscheme '.s:mycolors[current]
      break
    catch /E185:/
      call add(missing, s:mycolors[current])
    endtry
  endfor
  redraw
  if len(missing) > 0
    echo 'Error: colorscheme not found:' join(missing)
  endif
  if (a:echo_color)
    echo g:colors_name
  endif
endfunction

nnoremap - :call NextColor(1)<CR>
nnoremap _ :call NextColor(-1)<CR>

