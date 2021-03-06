" Leader
let mapleader = ","

" " GO
" if exists("g:did_load_filetypes")
"   filetype off
"   filetype plugin indent off
" endif
" set runtimepath+=$GOROOT/misc/vim " replace $GOROOT with the output of: go env GOROOT
" filetype plugin indent on
" syntax on
" autocmd FileType go autocmd BufWritePre <buffer> Fmt
" autocmd FileType go compiler go
"
autocmd BufWritePre * :%s/\s\+$//e
set listchars=tab:\.\ ,trail:·

set timeoutlen=1000 ttimeoutlen=0

set backspace=2   " Backspace deletes like most programs in insert mode
set nocompatible  " Use Vim settings, rather then Vi settings
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set autoread

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" ================ Search Settings  =================
"
set incsearch       " Find the next match as we type the search
set hlsearch        " Hilight searches by default
set viminfo='100,f1 " Save up to 100 marks, enable capital marks
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital
set relativenumber
set showmatch

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

augroup vimrcEx
  autocmd!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Cucumber navigation commands
  autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
  autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd BufRead,BufNewFile *.md setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END

" Softtabs, 2 spaces
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set nowrap

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
" Use Ag over Grep
set grepprg=ag\ --nogroup\ --nocolor
let g:ackprg = 'ag --nogroup --nocolor --column'
" let g:ack_use_dispatch = 1

" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0

" Color scheme
syntax on
set background=dark
set termguicolors
let g:dracula_italic = 0
let g:dracula_colorterm = 0
colorscheme dracula
" let g:hybrid_custom_term_colors = 1

let g:jsx_ext_required = 0

let g:airline_powerline_fonts = 1
let g:airline#extensions#tmuxline#enabled = 0
let g:airline_theme='dracula'

" SYNTASTIC
let g:syntastic_go_checkers = []
let g:syntastic_ruby_checkers = ['rubocop', 'mri']
let g:syntastic_javascript_checkers = ['eslint', 'flow']

let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" set clipboard=unnamed

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_loc_list_height = 2
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_mode_map = {
"         \ "mode": "active",
"         \ "active_filetypes": ['ruby', 'javascript', 'jsx', 'javascript.jsx'],
"         \ "passive_filetypes": [] }
" "
" " Run NeoMake on read and write operations
"
" let g:syntastic_mode_map = {
"   \ "mode": "passive",
"   \ "active_filetypes": [],
"   \ "passive_filetypes": [] }

" let g:neomake_javascript_enabled_makers = ['eslint']
" let g:neomake_jsx_enabled_makers = ['eslint']
" " let g:neomake_javascript_eslint_exe='$(npm bin)/eslint'
" let g:neomake_javascript_eslint_maker = {
"             \ 'args': ['--no-color', '--format'],
"             \ 'errorformat': '%f: line %l\, col %c\, %m'
"             \ }
" let g:neomake_serialize = 1
" let g:neomake_verbose = 3
" let g:neomake_logfile= '/Users/raphaelcosta/neomake.log'
" let g:neomake_serialize_abort_on_error = 1
"
" autocmd! BufReadPost,BufWritePost * Neomake
" let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
" let g:ale_statusline_format = ['%#ale_error# ⨉ %d %*', ' %#ale_warning# ⚠ %d %*', '%#ale_info ⬥ ok %*']
"
" let g:ale_linters = { 'javascript': [] }

   " 'javascript': ['eslint'],
   "
let b:ale_fixers = {'javascript': ['prettier', 'eslint']}
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:jsx_ext_required = 0

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

let g:tmuxline_theme  = 'vim_statusline_1'
let g:tmuxline_powerline_separators = 0
let g:tmuxline_preset = 'nightly_fox'

" Numbers
set relativenumber
set number
set numberwidth=5

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
set complete=.,w,t
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

" Exclude Javascript files in :Rtags via rails.vim due to warnings when parsing
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" vim-rspec mappings
nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
nnoremap <Leader>s :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>

noremap Q <nop>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

map W <Plug>CamelCaseMotion_w
map B <Plug>CamelCaseMotion_b
map E <Plug>CamelCaseMotion_e
sunmap W
sunmap B
sunmap E

" ========================================
" extensions for tComment plugin. Normally
" tComment maps 'gcc' to comment current line
" this adds 'gcp' comment current paragraph (block)
" using tComment's built in <c-_>p mapping
nmap <silent> gcp <c-_>p

" Command-/ to toggle comments
map <D-/> :TComment<CR>
imap <D-/> <Esc>:TComment<CR>

" Create window splits easier. The default
" way is Ctrl-w,v and Ctrl-w,s. I remap
" this to vv and ss
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

"Clear current search highlight by double tapping //
nmap <silent> // :nohlsearch<CR>

" We don't want to use Ctrl-p as the mapping because
" it interferes with YankRing (paste, then hit ctrl-p)
let g:ctrlp_map = ',t'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|public)$'
nnoremap <silent> ,t :CtrlP<CR>

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cab W! w!
cab Q! q!
cab Wq wq
cab Wa wa
cab wQ wq
cab WQ wq
cab W w
cab Q q

nmap :W :w
nmap :Q :q
nmap :wQ :wq
nmap :WQ :wq

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap \ :Ack<SPACE>

" via: http://rails-bestpractices.com/posts/60-remove-trailing-whitespace
" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
command! StripTrailingWhitespaces call <SID>StripTrailingWhitespaces()
nmap ,w :StripTrailingWhitespaces<CR>

" runtime macros/matchit.vim

nnoremap <leader>y :call system('nc localhost 8377', @0)<CR>

let g:yankring_history_file = '.yankring-history'

 let g:no_turbux_mappings = 1
 map <leader>rt <Plug>SendTestToTmux
 map <leader>rT <Plug>SendFocusedTestToTmux

"  if has('nvim')
"    nmap <BS> <C-W>h
"  endif
"
"  if has('nvim')
"   nmap <bs> :<c-u>TmuxNavigateLeft<cr>
"   nmap <bs> :<c-l>TmuxNavigateRight<cr>
" endif

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
