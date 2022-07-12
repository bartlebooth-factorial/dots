" Zen mode
" - uses Goyo.vim and Limelight.vim

let g:limelight_conceal_ctermfg=7

nnoremap <silent><leader>- :Goyo<cr>:Limelight<cr>
nnoremap <silent><leader>_ :Limelight!<cr>:Goyo!<cr>:source<space>~/.vim/vimrc<cr>:source<space>~/.vim/vimrc<cr>

