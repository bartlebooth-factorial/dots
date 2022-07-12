" Autopair mode
" - instances of ( [ { ' " are automatically
" - closed with their reflection

function! AutoPair()
    inoremap ( ()<Left>
    inoremap [ []<Left>
    inoremap { {}<Left>
    inoremap ' ''<Left>
    inoremap " ""<Left>
    if (expand('%:e') == "c" || expand('%:e') == "java")
	inoremap { {<cr>}<esc>O<tab>
    endif
endfunction

function! NoAutoPair()
    inoremap ( (
    inoremap [ [
    inoremap { {
    inoremap ' '
    inoremap " "
endfunction

nnoremap <Leader>] :call<space>AutoPair()<cr>
nnoremap <Leader>} :call<space>NoAutoPair()<cr>

