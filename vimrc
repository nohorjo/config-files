"highlight current line
set cursorline
"auto indent
set autoindent
set cindent
"tab size
set tabstop=4 softtabstop=0 expandtab shiftwidth=4 smarttab
set hlsearch

filetype plugin on
syntax on
set omnifunc=syntaxcomplete#Complete
if &diff
    colorscheme khaki
    set number norelativenumber
    set noro
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

hi StatusLineNC ctermbg=254
hi StatusLine ctermbg=1
hi CursorLine cterm=bold ctermbg=16
hi SpellBad cterm=bold ctermbg=88 ctermfg=206
hi SpellCap cterm=bold ctermbg=130 ctermfg=226
hi Search ctermbg=229
syn match Oddlines "^.*$" contains=ALL nextgroup=Evenlines skipnl
syn match Evenlines "^.*$" contains=ALL nextgroup=Oddlines skipnl
hi Oddlines ctermbg=236
hi Evenlines ctermbg=235

"insert style
augroup Insert
    autocmd!
    autocmd InsertEnter * hi CursorLine cterm=underline
    autocmd InsertLeave * hi CursorLine cterm=none
augroup END

augroup autoquickfix
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow
augroup END

set laststatus=2
set statusline=%m<%{winnr()}>\ %f\ %P:%c

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
vnoremap sd da<BS><BS><ESC>p
vnoremap sc" da<BS><BS>""<LEFT><ESC>p
vnoremap sc' da<BS><BS>''<LEFT><ESC>p
vnoremap sc` da<BS><BS>``<LEFT><ESC>p
vnoremap sc( da<BS><BS>()<LEFT><ESC>p
vnoremap sc[ da<BS><BS>[]<LEFT><ESC>p
vnoremap sc{ da<BS><BS>{}<LEFT><ESC>p
vnoremap sc< da<BS><BS><><LEFT><ESC>p

inoremap <Leader><Leader><Space> <C-x><C-o>

noremap <Enter> <UP>o<ESC><DOWN>
noremap <S-Tab> :tab
noremap <C-f> :find ./**/
noremap <Leader>q :qa!<CR>
nnoremap <Leader>Q :only<CR>
nnoremap Q :sh<CR>
nnoremap * *N

nnoremap <C-g> :%s//gc<LEFT><LEFT><LEFT>
nmap <C-h> yiw<C-g><C-r>0/
vmap <C-h> y<C-g><C-r>0/
noremap <S-f> :grep -r 
nnoremap <silent> <C-N> :cn<CR>zvzz
nnoremap <silent> <C-P> :cp<CR>zvzz
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
nnoremap <C-j> ddp
nnoremap <C-k> ddkP

"save session
autocmd TextChanged,TextChangedI * :silent :mksession!

"jsctags
"autocmd BufWritePost *.js :silent :exe '! nohup find . -type f -iregex ".*\.js$" -not -path "./node_modules/*" -exec jsctags {} -f \; 2>&1 | sed /^$/d | sort > tags & ' | redraw!

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
let g:syntastic_typescript_checkers = ['tslint']

"enable project specific .vimrc
set exrc
set secure


