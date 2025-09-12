let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Enable syntax highlighting and file type detection
syntax on
filetype plugin indent on

call plug#begin('~/.vim/plugged')
Plug 'rose-pine/vim'
Plug 'mbbill/undotree'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

" Rose-pine configuration
let g:rosepine_disable_bg = 1
let g:rosepine_disable_float_bg = 1

function! ColorMyPencils()
    " Set colorscheme first
    set background=dark
    colorscheme rosepine_moon
    
    " Force transparent backgrounds
    highlight Normal ctermbg=NONE guibg=NONE
    highlight NormalFloat ctermbg=NONE guibg=NONE
    highlight NonText ctermbg=NONE guibg=NONE
    highlight LineNr ctermbg=NONE guibg=NONE
    
    " Custom line numbers
    highlight LineNrAbove ctermfg=66 cterm=bold guifg=#3e8fb0 gui=bold
    highlight LineNr ctermfg=215 cterm=bold guifg=#f6c177 gui=bold
    highlight LineNrBelow ctermfg=204 cterm=bold guifg=#eb6f92 gui=bold
    
    " Other custom highlights
    highlight CursorLine ctermbg=234 guibg=#212121
    highlight Visual ctermbg=237 guibg=#3c3c3c
    highlight Search ctermbg=237 ctermfg=231 cterm=bold guibg=#3c3c3c guifg=#ffffff gui=bold
    highlight IncSearch ctermbg=61 ctermfg=231 cterm=bold guibg=#5f5faf guifg=#ffffff gui=bold
    highlight MatchParen ctermbg=238 ctermfg=231 cterm=bold guibg=#444444 guifg=#ffffff gui=bold
endfunction

" Apply after Vim starts
autocmd VimEnter * call ColorMyPencils()

"" Use a space as the leader key
let mapleader = " "

" Set a tab character to be 4 spaces wide
set tabstop=4

" The number of spaces to use for each step of (auto)indent
set shiftwidth=4

" Use spaces instead of tabs
set expandtab

" Copy indent from the previous line
set autoindent

" Smartly insert indents in new lines
set smartindent

" Disable text wrapping
set wrap

" Disable creating swap files
set noswapfile

" Set undo directory
set undodir=~/.vim/undodir
set undofile

" Allow for hidden buffers
set hidden

" Ignore case in search patterns
set ignorecase

" Override `ignorecase` if the search pattern contains an uppercase letter
set smartcase

" Highlight the current line
set cursorline

" Number of screen lines to keep above and below the cursor
set scrolloff=8

" Number of screen columns to keep to the left and right of the cursor
set sidescrolloff=8

" Explicitly disable system clipboard integration
set clipboard=

" Enable 24-bit color support (this might not be available in older Vim versions)
set termguicolors

" Use a dark background
set background=dark

" Show the sign column only when needed
set signcolumn=yes

" Use rounded corners for window borders (might not be available in older Vim versions)
" This option is not available in standard Vim, so we'll omit it.
" For visual borders, some plugins or terminal configurations might be needed.

" Show the cursor position in the status line
set ruler

" Always show the status line
set laststatus=2

" Use relative line numbers
set relativenumber

" Show the absolute line number
set number

" Highlight column 80 for line length guide
" set colorcolumn=80 

" Redraw immediately (can be CPU-intensive, but faster feedback)
" Note: The Nvim config had this set to false, which is the default in Vim. `set nolazyredraw` is the equivalent.
set lazyredraw 

" Time in ms to wait for `CursorHold` events
set updatetime=100

" Time in ms to wait for a mapped sequence
set timeoutlen=2000

" Time in ms to wait for key codes
set ttimeoutlen=100

" Allow backspace over everything
set backspace=indent,eol,start

" Mouse support (disable)
set mouse=

" Turn on wildmenu for command-line completion
set wildmenu

" Wildmode completion behavior
set wildmode=longest:full,full

" Show matching brackets
set showmatch

" Time in tenths of a second to show the match
set matchtime=2

" Disable error bells
set noerrorbells

" Use a visual bell instead of an audible one
set visualbell

" Do not create backup files
set nobackup

" Do not create a backup before writing a file
set nowritebackup

" Allow block-visual mode to select on virtual lines
set virtualedit=block

" horizontal splits go below
set splitbelow

" vertical splits go to the right
set splitright

" NETRW settings
" Thin listing: just the current directory
let g:netrw_liststyle = 0

" Hide the help banner
let g:netrw_banner = 0

" Use current buffer
let g:netrw_browse_split = 0

" Avoid vertical splits
let g:netrw_altv = 1

" Disable arrow keys in all modes
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
vnoremap <Up> <Nop>
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
snoremap <Up> <Nop>
snoremap <Down> <Nop>
snoremap <Left> <Nop>
snoremap <Right> <Nop>
cnoremap <Up> <Nop>
cnoremap <Down> <Nop>
cnoremap <Left> <Nop>
cnoremap <Right> <Nop>
tnoremap <Up> <Nop>
tnoremap <Down> <Nop>
tnoremap <Left> <Nop>
tnoremap <Right> <Nop>

" Disable substitute command
nnoremap s <Nop>
vnoremap s <Nop>
nnoremap S <Nop>
vnoremap S <Nop>

nnoremap Q <Nop>

inoremap <C-[> <Esc>

nnoremap <C-f> :silent !tmux neww fsession<CR>
nnoremap <C-b> :silent !tmux neww fmusic<CR>

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Searching and centering activate while on word with * or #
nnoremap n nzz
nnoremap N Nzz

vnoremap K :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap H :t '<-1<CR>gv=gv
vnoremap L :t '><CR>gv=gv

vnoremap < <gv
vnoremap > >gv

xnoremap <leader>p "_dP
xnoremap <leader>P "+p
nnoremap <leader>p "+p
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y
nnoremap <leader>d "_d
nnoremap <leader>c "_c

vnoremap <leader>d "_d
vnoremap <leader>c "_c

nnoremap <leader>b :bufdo bd \| enew<CR>

nnoremap <leader>x :!chmod +x %<CR>
nnoremap <leader>X :!chmod -x %<CR>

nnoremap <leader>S :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

nnoremap J mzJ`z
nnoremap <leader>n :nohl<CR>

nnoremap <leader>va :bufdo bd \| enew<CR>

nnoremap <C-j> :cnext<CR>zz
nnoremap <C-k> :cprev<CR>zz
nnoremap <leader>q :copen<CR>
nnoremap <leader>Q :cclose<CR>

nnoremap <leader>j :lnext<CR>zz
nnoremap <leader>k :lprev<CR>zz
nnoremap <leader>l :lopen<CR>
nnoremap <leader>L :lclose<CR>

" Highlight when yanking (copying) text
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
augroup END

" Open netrw in current buffer
nnoremap <leader>e :Ex<CR>

" Open netrw in current working directory
nnoremap <leader>E :Ex <C-r>=getcwd()<CR><CR>

" Set up the key mapping (Vimscript version)
nnoremap <leader>u :UndotreeToggle<CR>

" vim-fugitive configuration
nnoremap <leader>g :0Git<CR>
nnoremap <leader>vl :0Git log --oneline --graph --decorate --parents<CR>
nnoremap <leader>vo :diffget //2<CR>
nnoremap <leader>vt :diffget //3<CR>

" Fugitive autocmd for buffer-specific mappings
augroup Fugitive
    autocmd!
    autocmd BufReadPost,BufNewFile fugitive://* 
        \ setlocal bufhidden=delete |
        \ nnoremap <buffer> <leader>p :Git push<CR> |
        \ nnoremap <buffer> <leader>u :call SmartGitPull()<CR>
augroup END

" Smart Git pull function
function! SmartGitPull()
    let branch = systemlist('git rev-parse --abbrev-ref HEAD')[0]
    if branch ==# 'main'
        execute 'Git pull --ff-only'
    else
        execute 'Git pull --rebase origin main'
    endif
endfunction

" ==================== ADVANCED FZF.VIM CONFIG ====================
" Initialize fzf_vim config dictionary
let g:fzf_vim = {}

" Window layout (similar to your fzf-lua setup)
let g:fzf_layout = { 
  \ 'window': { 
  \   'width': 0.8, 
  \   'height': 0.8,
  \   'border': 'rounded'
  \ } 
\ }

" Preview window settings
let g:fzf_vim.preview_window = ['right:50%', 'ctrl-/']

" Customize command options
let g:fzf_vim.files_options = ['--prompt', 'Files❯ ']
let g:fzf_vim.buffers_options = ['--prompt', 'Buffers❯ ']
let g:fzf_vim.help_tags_options = ['--prompt', 'Help❯ ']
let g:fzf_vim.marks_options = ['--prompt', 'Marks❯ ']

" Custom fd options for Files command
let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git --color=never'

" Custom ripgrep options
let $FZF_DEFAULT_OPTS = '--bind ctrl-q:select-all+accept'

" ==================== CUSTOM COMMANDS ====================
" Custom Files command with preview
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, 
  \   fzf#vim#with_preview({
  \     'options': ['--prompt', 'Files❯ ', '--fd-opts=--color=never --type f --hidden --follow --exclude .git']
  \   }), <bang>0)

" Custom Rg command with preview
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --hidden --glob "!{.git,node_modules}/*" '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview({
  \     'options': ['--prompt', 'Live Grep❯ ', '--bind', 'ctrl-u:preview-page-up,ctrl-d:preview-page-down']
  \   }), <bang>0)

" File operations
nnoremap <leader>f :FzfFiles<CR>
nnoremap <C-p> :FzfGFiles<CR>
nnoremap <C-g> :Rg<CR>

" Search operations
nnoremap <leader>w :execute 'Rg ' . expand('<cword>')<CR>
nnoremap <leader>W :execute 'Rg ' . expand('<cWORD>')<CR>
vnoremap <leader>v y:Rg <C-R>"<CR>
nnoremap <leader>h :FzfHelptags<CR>

" Navigation
nnoremap <leader>vb :Buffers<CR>
nnoremap <leader>vh :Helptags<CR>
nnoremap <leader>vm :Marks<CR>
nnoremap <leader>vr :Registers<CR>
nnoremap <leader>vj :Jumps<CR>
nnoremap <leader>vc :Commands<CR>
nnoremap <leader>vp :Maps<CR>

" Git operations (if you have fugitive)
nnoremap <leader>vg :Commits<CR>
nnoremap <leader>vG :BCommits<CR>
