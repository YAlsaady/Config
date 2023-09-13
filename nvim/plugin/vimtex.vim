nmap <leader>c <Plug>(vimtex-compile)

" noremap <leader>c <Cmd>update<CR><Cmd>VimtexCompileSS<CR>

let g:vimtex_quickfix_open_on_warning = 0 

let g:vimtex_view_method = 'zathura'

let g:vimtex_syntax_enabled = 1

nmap <leader>v <plug>(vimtex-view)

augroup VimTeX
  autocmd!
  " autocmd BufReadPre $HOME/Studium/Mathe/LaTeX/Inhalt/*.tex
  autocmd BufReadPre LaTeX/Inhalt/*.tex
        \ let b:vimtex_main = 'LaTeX/main.tex'
augroup END

augroup VimTeX
  autocmd!
  autocmd BufReadPre $HOME/Studium/Mathe/LaTeX/Inhalt/*.tex
  \ let b:vimtex_main = '$HOME/Studium/Mathe/LaTeX/Inhalt'
augroup END
