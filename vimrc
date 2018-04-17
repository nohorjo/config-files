"show line numbers
set number relativenumber
"highlight current line
set cursorline
"auto indent
set autoindent
set cindent
"tab size
set tabstop=3

filetype plugin on
syntax on
set omnifunc=syntaxcomplete#Complete
colorscheme dracula

"disable autoindent when for pasting with F2
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

"auto close brackets, if return is pressed
inoremap {<CR> {<CR>}<Left><CR><UP><TAB>
"inoremap (<CR> (<CR>)<Left><CR><UP><TAB>
inoremap [<CR> [<CR>]<Left><CR><UP><TAB>
inoremap <<CR> <<CR>><Left><CR><UP><TAB>

map <Enter> o<ESC>
map <S-Tab> :tab
map <C-f> :find **/
map <Leader>q :qa!<CR>

"resize splits
nnoremap  <Leader>d :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap  <Leader>a :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
nnoremap  <Leader>w :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap  <Leader>s :exe "resize " . (winheight(0) * 2/3)<CR>

"move line up or down
nnoremap <C-S-DOWN> ddp
nnoremap <C-S-UP> ddkP

"jsctags
autocmd BufWritePost *.js :silent :exe '! nohup find . -type f -iregex ".*\.js$" -not -path "./node_modules/*" -exec jsctags {} -f \; 2>&1 | sed /^$/d | sort > tags & ' | redraw!
 
"pathogen
execute pathogen#infect()

"NERDTree
nnoremap <Leader>z :NERDTree<CR>
"autocmd vimenter * NERDTree
let NERDTreeShowLineNumbers=1

"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"enable project specific .vimrc
set exrc
set secure


