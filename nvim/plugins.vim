" ============================================================================ "
" ===                               PLUGINS                                === "
" ============================================================================ "

" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

call plug#begin('~/.config/nvim/plugged')

" Colorschemes
Plug 'connorholyday/vim-snazzy'
Plug 'haishanh/night-owl.vim'
Plug 'cocopon/iceberg.vim'
Plug 'ayu-theme/ayu-vim'

" Denite - Fuzzy finding, buffer management
Plug 'Shougo/denite.nvim'

" Language pack
Plug 'sheerun/vim-polyglot'

" Intellisense Engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Consistent navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'

" Commenting
Plug 'scrooloose/nerdcommenter'

" Git
Plug 'tpope/vim-fugitive'

" Haskell Formatting
Plug 'sdiehl/vim-ormolu'

" Emmet
Plug 'mattn/emmet-vim'

" Initialize plugin system
call plug#end()
