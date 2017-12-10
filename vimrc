"show line numbers
set number
"highlight current line
set cursorline
"auto indent
set autoindent
set cindent


"auto close brackets, if return is pressed
inoremap {<CR> {<CR>}<Left>
inoremap (<CR> (<CR>)<Left>
inoremap [<CR> [<CR>]<Left>
inoremap <<CR> <<CR>><Left>

map <Enter> o<ESC>
map <Tab> :tab
map <C-f> :find **/

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


