" " NOTE: You can use other key to expand snippet.
"
" " Expand
" imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
" smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
"
" " Expand or jump
" imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
" smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
"
" " Jump forward or backward
" imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
" smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
"
" " Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" " See https://github.com/hrsh7th/vim-vsnip/pull/50
" nmap        s   <Plug>(vsnip-select-text)
" xmap        s   <Plug>(vsnip-select-text)
" nmap        S   <Plug>(vsnip-cut-text)
" xmap        S   <Plug>(vsnip-cut-text)
"
" " If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
" let g:vsnip_filetypes = {}
" let g:vsnip_filetypes.javascriptreact = ['javascript']
" let g:vsnip_filetypes.typescriptreact = ['typescript']
" " let g:vsnip_filetypes.typescript = ['javascript']


" " press <Tab> to expand or jump in a snippet. These can also be mapped separately
" via <Plug>luasnip-expand-snippet and <Plug>luasnip-jump-next.
" imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
" imap <silent><expr> <Tab> luasnip#jumpable(1) ? <Plug>luasnip-jump-next : luasnip#expandable() ? '<plug>luasnip-expand' : '<tab>' 
" -1 for jumping backwards.
" inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
"
" snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
" snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
