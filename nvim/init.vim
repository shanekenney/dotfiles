scriptencoding utf-8

let g:polyglot_disabled = ['yml']

source ~/.config/nvim/plugins.vim

" ============================================================================ "
" ===                           EDITING OPTIONS                            === "
" ============================================================================ "

" Remap leader key to ,
let g:mapleader=','

" Enable line numbers
set number
set nowrap

" Don't highlight current cursor line
set nocursorline

" Yank and paste with the system clipboard
set clipboard=unnamed
set signcolumn=yes
set inccommand=nosplit

set ignorecase
set smartcase
set incsearch
set hlsearch

set termguicolors

" Use vertical diff split
set diffopt+=vertical

" === TAB/Space settings === "
" Insert spaces when TAB is pressed.
set expandtab

" Change number of spaces that a <Tab> counts for during editing ops
set softtabstop=2

" Indentation amount for < and > commands.
set shiftwidth=2

" Allow hidden buffers
set hidden

inoremap jk <ESC>

" Buffer at top and bottom of file when scrolling
set scrolloff=10

syntax enable
colorscheme iceberg

"=== Telescope Config ===
lua << EOF
require('telescope').load_extension('fzf')
require('telescope').load_extension('coc')
EOF

nnoremap ; :Telescope buffers<CR>
nnoremap <leader>p :Telescope git_files<CR>
nnoremap <leader>g :Telescope live_grep<CR>

" === Coc bindings ===

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" === Custom tab line

function! MyTabLine()
  let s = ''
  for i in range(1, tabpagenr('$'))
    " select the highlighting
    if i == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . i . 'T'

    " the label is made by MyTabLabel()
    let s .= '%{TcdTabLabel(' . i . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction

function! TcdTabLabel(n)
  return ' ' . a:n . ' ' . split(getcwd(-1, a:n), '/')[-1]
endfunction

set tabline=%!MyTabLine()


let g:user_emmet_leader_key='<C-Z>'
