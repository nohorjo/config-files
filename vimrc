"highlight current line
set cursorline
"auto indent
set autoindent
set cindent
"tab size
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set hlsearch

filetype plugin on
syntax on
set omnifunc=syntaxcomplete#Complete
if &diff
    colorscheme khaki
     set number norelativenumber
else
    colorscheme hydrangea
    set number relativenumber
"make active window obvious
    augroup ActiveWindow
        autocmd!
        autocmd WinEnter,TabEnter * set relativenumber
        autocmd WinLeave,TabLeave * set norelativenumber
        autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
        autocmd WinLeave * setlocal nocursorline
    augroup END
endif

hi StatusLine ctermbg=DarkRed
hi CursorLine cterm=bold ctermbg=16
hi SpellBad cterm=bold ctermbg=88 ctermfg=206
hi SpellCap cterm=bold ctermbg=130 ctermfg=226

"insert style
augroup Insert
    autocmd!
    autocmd InsertEnter * hi CursorLine cterm=underline
    autocmd InsertLeave * hi CursorLine cterm=none
augroup END

set laststatus=2
set statusline=%m
set statusline+=<%{winnr()}>
set statusline+=\ %f
set statusline+=\ %P
"disable autoindent when for pasting with F2
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

"auto close brackets, if return is pressed
inoremap {<CR> {<CR>}<Left><CR><UP><TAB>
inoremap [<CR> [<CR>]<Left><CR><UP><TAB>

"surround
vnoremap s" di""<ESC><LEFT>p
vnoremap s' di''<ESC><LEFT>p
vnoremap s` di``<ESC><LEFT>p
vnoremap s( di()<ESC><LEFT>p
vnoremap s[ di[]<ESC><LEFT>p
vnoremap s{ di{}<ESC><LEFT>p
vnoremap s< di<><ESC><LEFT>p

inoremap <Leader><Leader><Space> <C-x><C-o>

noremap <Enter> <UP>o<ESC><DOWN>
noremap <S-Tab> :tab
noremap <C-f> :find ./**/
noremap <Leader>q :qa!<CR>
nnoremap  <Leader>Q :only<CR>

noremap <S-f> :grep 
nnoremap <silent> <C-N> :cn<CR>zv
nnoremap <silent> <C-P> :cp<CR>zv
nnoremap n nzz
nnoremap N Nzz

"resize splits
nnoremap <Leader>d :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <Leader>a :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
nnoremap <Leader>w :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <Leader>s :exe "resize " . (winheight(0) * 2/3)<CR>
noremap <Leader><UP>    <C-w>+
noremap <Leader><DOWN>  <C-w>-
noremap <Leader><RIGHT>  <C-w>>
noremap <Leader><LEFT>  <C-w><
nnoremap <Leader>= <C-w>=

"switch windows
nnoremap <Leader>k <C-w><UP>
nnoremap <Leader>j <C-w><DOWN>
nnoremap <Leader>h <C-w><LEFT>
nnoremap <Leader>l <C-w><RIGHT>
nnoremap <Leader>t <C-w>t
nnoremap <Leader>b <C-w>b
nnoremap <Leader>; <C-w>w

"move line up or down
nnoremap <C-S-DOWN> ddp
nnoremap <C-S-UP> ddkP

"save session
autocmd TextChanged,TextChangedI * :silent :mksession!

"jsctags
autocmd BufWritePost *.js :silent :exe '! nohup find . -type f -iregex ".*\.js$" -not -path "./node_modules/*" -exec jsctags {} -f \; 2>&1 | sed /^$/d | sort > tags & ' | redraw!
 
"pathogen
execute pathogen#infect()

"NERDTree
nnoremap <Leader>z :NERDTree<CR>
"autocmd vimenter * NERDTree
let NERDTreeShowLineNumbers=1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"enable project specific .vimrc
set exrc
set secure


