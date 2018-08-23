"highlight current line
set cursorline
"auto indent
set autoindent
"tab size
set softtabstop=0 expandtab shiftwidth=4 smarttab
set hlsearch

filetype plugin on
syntax on
if &diff
    colorscheme khaki
    hi CursorLine ctermbg=233 ctermfg=228
    set number norelativenumber
    set noro
    noremap ]x /<<<<<<<<ENTER>
    noremap dgl :diffg LO<ENTER>
    noremap dgr :diffg RE<ENTER>
    noremap dd dd
else
    colorscheme hydrangea
    set number relativenumber
    hi CursorLine cterm=bold ctermbg=16
"make active window obvious
    augroup ActiveWindow
        autocmd!
        autocmd WinEnter,TabEnter * set relativenumber
        autocmd WinLeave,TabLeave * set norelativenumber
        autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
        autocmd WinLeave * setlocal nocursorline
    augroup END
    autocmd WinEnter,BufEnter,TabEnter * call Zebra()
    function! Zebra()
        silent! syn clear Oddlines
        silent! syn clear EvenLines
        syn match Oddlines "^.*$" contains=ALL nextgroup=Evenlines skipnl
        syn match Evenlines "^.*$" contains=ALL nextgroup=Oddlines skipnl
        hi Oddlines ctermbg=236
        hi Evenlines ctermbg=235
    endfunction
"save session
    autocmd TextChanged,TextChangedI,VimLeave * :silent :mksession!
    augroup autoquickfix
            autocmd!
            autocmd QuickFixCmdPost [^l]* cwindow
            autocmd QuickFixCmdPost l*    lwindow
    augroup END
" save view
    augroup AutoSaveFolds
        autocmd!
        autocmd BufWinLeave *.* mkview
        autocmd BufWinEnter *.* silent loadview
    augroup END
    set foldcolumn=3
endif

hi StatusLineNC ctermbg=254
hi StatusLine ctermbg=1
hi SpellBad cterm=bold ctermbg=88 ctermfg=206
hi SpellCap cterm=bold ctermbg=130 ctermfg=226
hi Search ctermbg=229
hi TODO cterm=underline ctermbg=201 ctermfg=159
hi link Boolean Statement

"insert style
augroup Insert
    autocmd!
    autocmd InsertEnter * hi CursorLine cterm=underline
    autocmd InsertLeave * hi CursorLine cterm=none
augroup END

set laststatus=2
set statusline=%m<%{winnr()}>\ %f\ %P:%c

"disable autoindent when for pasting with F2
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

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

noremap <Enter> <UP>o<ESC><DOWN>
noremap <S-Tab> :tab
noremap <S-Tab><UP> :tabnew<CR>
noremap <S-Tab><DOWN> :tabc<CR>
noremap <S-Tab><LEFT> :tabp<CR>
noremap <S-Tab><RIGHT> :tabn<CR>
noremap <C-f> :find ./**/
noremap <Leader>q :qa!<CR>
nnoremap <Leader>Q :only<CR>
nnoremap Q :sh<CR>
nnoremap * *N:%s///gn<CR>
nnoremap <Space> i <ESC><RIGHT>
nnoremap z{ [{zf%

inoremap <Leader>w <C-o>:w<CR>
    
"auto xml
inoremap <Space><Tab> <ESC>bdei <<C-r>"></<C-r>"><ESC>F<i
inoremap <Space>. <ESC>f>a

nnoremap <C-g> :%s//gc<LEFT><LEFT><LEFT>
nmap <C-h> yiw<C-g>\<<C-r>0\>/
vmap <C-h> y<C-g><C-r>0/
noremap <S-f><S-f> :grep -r 
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

"continue page in another split
nnoremap <Leader>cv H<C-w>v:set scb<CR><C-w>wLzt5<C-y>:set scb<CR>

"move line up or down
nnoremap <C-j> ddp
nnoremap <C-k> ddkP

augroup filetype
    autocmd!
    autocmd BufNewFile,BufRead *.ts setf typescript
    autocmd BufNewFile,BufRead *.ts set syntax=javascript
    autocmd BufNewFile,BufRead *.html hi Error None
    autocmd BufNewFile,BufRead vimrc hi Error None
augroup END

"pathogen
execute pathogen#infect()

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_typescript_checkers = ['tslint']

"jsbeautify
autocmd FileType javascript,typescript noremap <buffer>  <Leader>ff :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <Leader>ff :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer> <Leader>ff :call JsxBeautify()<cr>
autocmd FileType html noremap <buffer> <Leader>ff :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <Leader>ff :call CSSBeautify()<cr>
autocmd FileType javascript,typescript vnoremap <buffer>  <Leader>ff :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer> <Leader>ff :call RangeJsonBeautify()<cr>
autocmd FileType jsx vnoremap <buffer> <Leader>ff :call RangeJsxBeautify()<cr>
autocmd FileType html vnoremap <buffer> <Leader>ff :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <Leader>ff :call RangeCSSBeautify()<cr>

"enable project specific .vimrc
set exrc
set secure


