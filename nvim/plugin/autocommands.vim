augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
augroup end

augroup C
  autocmd!
  autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
augroup END

" augroup CPP
"   autocmd!
"   autocmd BufRead,BufNewFile *.hh,*.cc,*.cpp, set filetype=cpp.doxygen
" augroup END

" augroup ION
"   autocmd!
"   autocmd BufRead,BufNewFile *.ino set filetype=cpp
"   " autocmd BufRead,BufNewFile *.ino set filetype=arduino
" augroup END
" augroup _git
"     autocmd!
"     autocmd FileType gitcommit setlocal wrap
"     autocmd FileType gitcommit setlocal spell
" augroup end

augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell spelllang=de_de,en_us
augroup end

" LaTeX
autocmd FileType tex set spell spelllang=de_de,en_us

augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
augroup end

" set titlestring=NVIM:\ %-25.55F\ %a%r%m titlelen=70
" augroup _alpha
"     autocmd!
"     autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
" augroup end

" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()
" set nofoldenable                     " Disable folding at startup.

" hi! Normal ctermbg=NONE guibg=NONE
" hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
" Autoformat
" augroup _lsp
" autocmd!
" autocmd BufWritePre * lua vim.lsp.buf.formatting()
" augroup end
