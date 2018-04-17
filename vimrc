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
map <Tab> :tab
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

"pathogen
execute pathogen#infect()

"NERDTree
nnoremap <Leader>z :NERDTree<CR>
"autocmd vimenter * NERDTree
let NERDTreeShowLineNumbers=1

"enable project specific .vimrc
set exrc
set secure


