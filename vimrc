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
    colorscheme khaki-mod
    set number norelativenumber
    set noro
    noremap ]x /<<<<<<<<ENTER>
    noremap dgl :diffg LO<ENTER>
    noremap dgr :diffg RE<ENTER>
    noremap dd dd
else
    colorscheme hydrangea-mod
    set number relativenumber
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
        autocmd BufWinEnter *[^*.txt.gpg] silent loadview
    augroup END
    set foldcolumn=3
endif

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
inoremap <Space><Tab> <ESC>bce<<C-r>"></<C-r>"><ESC>F<i

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
nnoremap <Leader>; <C-w>w

"continue page in another split
nnoremap <Leader>cv H<C-w>v:set scb<CR><C-w>wLzt5<C-y>:set scb<CR>

augroup filetype
    autocmd!
    autocmd BufNewFile,BufRead *.ts setf typescript
    autocmd BufNewFile,BufRead *.ts set syntax=javascript
    autocmd BufNewFile,BufRead *.html hi Error None
    autocmd BufNewFile,BufRead vimrc hi Error None
    autocmd BufNewFile,BufRead *.java hi Error None

    autocmd BufNewFile,BufRead *.txt.gpg setf txtgpg
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

"console.log
autocmd FileType javascript,typescript noremap <buffer> co oconsole.log('');<ESC>2hi

"gpg encrypt/decrypt files
augroup gpg
    autocmd BufWritePost *.gpg !gpg -c --batch --yes -o %.tmp %; mv %.tmp %
    autocmd BufReadPost *.gpg %!gpg -d -q --pinentry-mode loopback %
    autocmd BufReadPost *.gpg set noswf
    autocmd FileType txtgpg set foldmethod=marker
augroup END

nnoremap gg ggzz

"enable project specific .vimrc
set exrc
set secure


