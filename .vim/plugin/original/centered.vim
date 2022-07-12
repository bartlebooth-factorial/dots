" Centered mode
" - conveniently scroll through files
" - edit text without cursor management

function! ToggleCentered()
  if &scrolloff ==# 0
    set scrolloff=99
  else
    set scrolloff=0
  endif
endfunction

nnoremap <silent><leader>c :call<space>ToggleCentered()<cr>
