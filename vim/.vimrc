" leader key: <SPACE>
let mapleader=" "

" sensible defaults
syntax enable
set number
set autowriteall
set linebreak
set noruler
set splitbelow
set splitright
set incsearch
set hlsearch
set ignorecase
set encoding=utf-8
set laststatus=0
set formatoptions-=cro
set background=dark  
set clipboard=unnamedplus
set termguicolors

" indentation
filetype plugin indent on
set ts=2 sts=2 sw=2 
set noexpandtab
set smarttab
set expandtab
set smartindent
set autoindent

" others
set fillchars+=vert:│
set directory=$HOME/.vim/swap

" formatprg
let s:formatprg_for_filetype = {
  \ "cpp"        : "astyle --indent=spaces=2 --style=google",
  \ "java"       : "astyle --indent=spaces=2 --style=google",
  \}

for [ft, fp] in items(s:formatprg_for_filetype)
  execute "autocmd FileType ".ft." let &l:formatprg=\"".fp."\" | 
	\ setlocal formatexpr="
endfor

" fzf
nnoremap <silent> <leader>f :Files ~<cr>
nnoremap <silent> <leader>b :Buffer <cr>
nnoremap <silent> <leader>p :Files .<cr>
let g:fzf_preview_window = []
let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1, 'border': 'horizontal' } }

" prettier
let g:prettier#exec_cmd_async = 1
nnoremap <silent> <leader>w :Prettier <cr>

" emmet
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\  'typescript' : {
\      'extends' : 'tsx',
\  },
\}

" nvcode
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust", "elm", "dart", "lua" },  -- list of language that will be disabled
  },
}
EOF

let g:nvcode_termcolors=256
colorscheme onedark

" highlights
hi LineNr ctermbg=NONE guibg=NONE
hi Normal guibg=NONE ctermbg=NONE
hi VertSplit ctermbg=NONE guibg=NONE
highlight clear SignColumn

" ale
let b:ale_fixers = {'javascript': ['prettier', 'eslint']}
let g:ale_completion_enabled = 1

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_set_highlights = 0
let g:ale_disable_lsp = 1

let g:ale_hover_cursor = 0
let g:ale_hover_to_floating_preview = 1
let g:ale_detail_to_floating_preview = 1

highlight clear ALEErrorSign
highlight clear ALEWarningSign
highlight clear SignColumn

" custom keybindings
" intuitive split navigation
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>

" leader key composition
nnoremap <leader><space> :nohlsearch <cr>
nnoremap <leader>ev :e ~/.vim/.vimrc <cr>
nnoremap <leader>ep :e ~/.vim/plugins.vim <cr>
nnoremap <leader>/ :Rg<Space>

" ale-spacfic
nnoremap gr :ALEFindReferences<cr>
nnoremap gd :ALEGoToDefinition<cr>
nnoremap K  :ALEHover<cr>

" custom ex-commands
command! PacUpdate call minpac#update()
command! PacClean call minpac#clean()

" plugins
so ~/.vim/plugins.vim

" coc
so ~/.vim/coc.vim
