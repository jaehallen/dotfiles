let maplocalleader=" "
let mapleader=" "

"disable vi compatibility
set nocompatible
"add a search down to subfolder
set path+=**
"Display all matching files when we tab complete
set wildmenu

filetype plugin on
set colorcolumn=100
set number
set relativenumber
set showmatch
set showcmd
set cursorline
set encoding=utf-8
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

" Status Line
set laststatus=2
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc}, " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=line:%-14.(%4l\/%L%)
set statusline+=%-10.(col:%4c%V%)\ %<%P        " offset

" Changer Cursors on different mode
let &t_SI = "\<Esc>[5 q"
let &t_SR = "\<Esc>[3 q"
let &t_EI = "\<Esc>[1 q"

"vim-plug
call plug#begin('~/.vim/plug')
"Colors
  Plug 'felixhummel/setcolors.vim'
  Plug 'xero/sourcerer.vim'
  Plug 'rafi/awesome-vim-colorschemes'
  Plug 'Reewr/vim-monokai-phoenix'

"Plugin
  Plug 'tomtom/tcomment_vim'
  Plug 'Yggdroot/indentLine'
  Plug 'tpope/vim-surround'
  Plug 'jeetsukumaran/vim-filebeagle'
  Plug 'tpope/vim-sensible'
  Plug 'jiangmiao/auto-pairs'
  Plug 'lervag/vimtex'
  Plug 'w0rp/ale'
  Plug 'Shougo/neocomplete.vim'
  Plug 'Shougo/neosnippet.vim'
  Plug 'honza/vim-snippets'
  Plug 'Shougo/neosnippet-snippets'
call plug#end()

" view
if has("gui_running")
    colorscheme monokai-phoenix
else
    colorscheme sourcerer
endif

" Change highlight color on different mode
" hi Normal ctermbg=232 ctermfg=NONE
hi LineNr ctermbg=234 
" hi StatusLIneNC cterm=underline 
hi CursorLine ctermbg=236 ctermfg=NONE guibg=#383a3e
au InsertEnter * hi CursorLine ctermbg=234 guibg=#080808 
au InsertLeave * hi CursorLine ctermbg=236 guibg=#383a3e 

" key {{{
map <Leader>s :source ~/.vimrc<CR>
nmap <silent> <Leader><Leader> :nohlsearch<CR>
nmap <silent> <Leader>c :let @/ = ""<CR>
nnoremap <F3> :set wrap!<CR>
" nnoremap \ :colorscheme 

" Save
nnoremap <Leader>ww :w<CR>
nnoremap <Leader>wq :wq<CR>
cnoremap w!! w !sudo tee % > /dev/null

" Copy and Paste to clipboard
noremap <Leader>p "+p
noremap <Leader>y "+y
set pastetoggle=<F2>
au InsertLeave * set nopaste

"Buffer 
nnoremap <Leader>bl :buffers<CR>:buffer<space>
nnoremap <Leader>bd :bd<CR>
nnoremap <Leader><TAB> <C-^>
 
"indent with TAB/S-TAB in visual mode
xnoremap <TAB> >
xnoremap <S-TAB> <

"Move cursor in insert Mode
inoremap <C-l> <Esc>Ea

"Window Resize
nnoremap <C-Right> <C-W>>
nnoremap <C-Left> <C-W><
nnoremap <C-Down> <C-W>-
nnoremap <C-Up> <C-W>+
"}}}

augroup FastEscape
  autocmd!
  autocmd InsertEnter * set timeoutlen=300
  autocmd InsertLeave * set timeoutlen=1000
augroup END
  
set hidden
set history=1000

" Split 
set splitright
set splitbelow


" indent
filetype indent on
set nowrap
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab
set smartindent
set autoindent
if has('linebreak')
  set breakindent
  let &showbreak = '↳ '
  set cpo+=n
end
autocmd FileType html,css,sh,tex setlocal shiftwidth=2 tabstop=2
" autocmd FileType css setlocal shiftwidth=2 tabstop=2
" autocmd FileType sh setlocal shiftwidth=2 tabstop=2
" autocmd FileType tex setlocal shiftwidth=2 tabstop=2

" search
set hlsearch
set incsearch

" Folding
set nofoldenable
set foldmethod=manual
set foldlevelstart=10
autocmd FileType vim setlocal foldmethod=marker

" netrw
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 25
let g:netrw_altv = 1
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END


"neocomplete {{{
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" I will probably never hit <TAB> 10 times
let g:neocomplete#max_list = 10

" Automatically open and close the popup menu / preview window
" https://github.com/JessicaKMcIntosh/TagmaBufMgr/issues/8
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
" inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
" let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"}}}

"neosnippet {{{
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
" imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : "\<TAB>"
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/plug/vim-snippets/snippets'
let g:neosnippet#snippets_directory='~/.vim/custom_snippets'
" let g:neosnippet#disable_runtime_snippets = {'_':1,}
"}}}

"vimtext {{{
let g:vimtex_view_method = 'zathura'
let g:tex_conceal = ""
"}}}

"ale {{{
let g:ale_pattern_options = {'\.tex$': {'ale_warn_about_trailing_whitespace':0}}
let g:ale_sign_column_always = 1
let g:ale_sign_error= '>>'
let g:ale_sign_warning= '!!'
nmap <silent> <C-k> <Plug>(ale_previous)
nmap <silent> <C-j> <Plug>(ale_next)
"}}}

"indentline {{{
let g:indentLine_char = '│'
"}}}

"auto-pair {{{{
let g:AutoPairsShortcutToggle = '<F4>' 
let g:AutoPairs =  {'(':')', '[':']', '{':'}',"'":"'",'"':'"'}
"}}}}

