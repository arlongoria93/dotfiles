packadd minpac
call minpac#init()

" essentials
call minpac#add('jiangmiao/auto-pairs')
call minpac#add('mattn/emmet-vim')
call minpac#add('sheerun/vim-polyglot')

" tpope collection
call minpac#add('tpope/vim-vinegar')
call minpac#add('tpope/vim-commentary')

" web development
call minpac#add('prettier/vim-prettier')
call minpac#add('mxw/vim-jsx')
call minpac#add('styled-components/vim-styled-components')
call minpac#add('leafgarland/typescript-vim')
call minpac#add('peitalin/vim-jsx-typescript')

" fuzzy finder
call minpac#add('junegunn/fzf')
call minpac#add('junegunn/fzf.vim')

" colorschemes
call minpac#add('nvim-treesitter/nvim-treesitter')
call minpac#add('christianchiarulli/nvcode-color-schemes.vim')

" coc
call minpac#add('neoclide/coc.nvim')
