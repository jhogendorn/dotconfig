" GENERAL {{{
" =================

syntax on

set shell=/usr/bin/env\ zsh         " :! commands use zsh
"set termguicolors		    " truecolour support
set number                          " set line numbers on
set cursorline                      " highlight current line
set numberwidth=6                   " Make sure the gutter is big enough for everything
set foldcolumn=2                    " Show folds in gutter
set showmode                        " always show what mode we're in
set showcmd                         " show commands as they're typed
set cmdheight=1                     " Command line height
set pumheight=10                    " Completion window max size
set noswapfile                      " New buffers get made without swapfile
set hidden                          " Keeps buffers in background
set clipboard=unnamed               " Use system clipboard
set pastetoggle=<F12>               " Use F12 to paste in insertmode from system clipboard
set lazyredraw                      " Don't redraw while executing macros
set ttyfast                         " Using vim locally so faster tty is good (vim only)
set showmatch                       " Highlight matching brackets
set matchtime=2                     " How many tenths of a second to blink when matching brackets
set virtualedit=block               " Able to edit past EOL in visual block
set scrolloff=20                    " Keep context when moving to search results
set winminheight=0                  " Allow windows to be collapsed
set winminwidth=0                   " Allow windows to be collapsed
" set path=.,src,node_modules       " Dirs to be searched with gf, :find etc  :h 'path'
" set suffixesadd+=.js,.jsx,.ts,.rb " Suffixes to be searched with gf, :find etc
set formatoptions=l                 " Vim should never insert line breaks when pasting
set autoindent                      " What it says on the tin
set wrap                            " Soft wrap lines
set lbr                             " Better line breaks when wrapping
set wrapmargin=5                    " Num of chars from right window border to wrap
let &showbreak = '   ->'            " Prefix wrapped lines with this char
set cpoptions+=n                    " The col used for number/relnumber will be used for text of wrapped lines
set breakindent                     " Wrapped lines witll continue visually indented
set breakindentopt=shift:2,sbr      " Shift indented lines 0 cols and show the showbreak chars
set backspace=indent,eol,start      " Affects what characters backspace will work over
set switchbuf=useopen               " When switching to a buffer, only look for ones open in the current tab
set magic                           " Use magic matching in search patterns
set incsearch                       " Start searching as soon as you start typing
set inccommand=nosplit              " Replacements show up as you type
set ignorecase                      " ignore case when using a search pattern
set smartcase                       " override 'ignorecase' when pattern has upper case character
set wrapscan                        " Auto wrap searches
set hlsearch                        " Highlight searches
set shiftwidth=2                    " Cols for reindent, >> etc
set tabstop=2                       " Cols for tabs
set list                            " show whitespace chars
set listchars=tab:\│\ ,eol:↲        " Bars for tabs, show eol chars
set listchars+=nbsp:␣               " Show nonbreaking spaces
set listchars+=trail:•              " Highlight trailing whitespace
set listchars+=extends:⟩            " Char to show when no wrap but text extends right
set listchars+=precedes:⟨           " Char to show when no wrap but text extends left
set title                           " Sets the title of the window
set visualbell                      " Show bells as flashes
set shortmess=filnxtToOI            " Don't show welcome message
set notimeout                       " Dont time out on mappings
set ttimeout                        " Do time out on key codes
set ttimeoutlen=50                  " Ms to allow for key sequences to complete
set mouse=a                         " Enable mouse in all modes
set tildeop                         " Tilde now acts like a normal verb
set exrc                            " Allow per dir .vimrc files
set secure                          " Disable unsafe commands in per project .vimrc files
set foldmethod=marker               " Markers are used to specify folds.
set foldlevel=0                     " Start folding automatically from level 2
set fillchars="fold:"               " Characters to fill the statuslines and vertical separators

set spl=en spell                    " Use english dictionary
set nospell                         " Disable checking by default (use <F4> to toggle)
set encoding=utf-8                  " utf-8 > * baaabeeee

set nobackup                        " Disable backup files, this rarely saves me and typically gets in the way
if has('persistent_undo')
	set undofile
	if has('nvim')
			set undodir=~/.config/nvim/tmp/undo//
	else
			set undodir=~/.vim/tmp/undo//
	endif
endif

let mapleader="\<Space>"           " Space is the superior leader

autocmd BufRead,BufNewFile * setlocal signcolumn=yes	" Ensure the symbol column is always present

"Ignore these files when completing names
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif

"Use the system ruby, not whatever rvm is set to
let g:ruby_path = system('rvm current')

"}}}

" PLUGINS {{{
" =================
call plug#begin('~/.config/nvim/plugged')


	" Completion {{{
	
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
		" When in completion, enter selects
		inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
		" When in completion, tab cycles
		"inoremap <expr><TAB>	pumvisible() ? "\<C-n>" : "\<TAB>"
		"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

		"inoremap <silent><expr> <TAB>
		"      \ pumvisible() ? coc#_select_confirm() :
		"      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
		"      \ <SID>check_back_space() ? "\<TAB>" :
		"      \ coc#refresh()

		"function! s:check_back_space() abort
		"  let col = col('.') - 1
		"  return !col || getline('.')[col - 1]  =~# '\s'
		"endfunction

		let g:coc_snippet_next = '<tab>'

	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
		"autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
		let g:UltiSnipsExpandTrigger="<C-j>"

	Plug 'pechorin/any-jump.vim'
		let g:any_jump_disable_default_keybindings = 1
		" Normal mode: Jump to definition under cursore
		nnoremap <leader>f :AnyJump<CR>

		" Visual mode: jump to selected text in visual mode
		xnoremap <leader>f :AnyJumpVisual<CR>

		" Normal mode: open previous opened file (after jump)
		nnoremap <leader>fb :AnyJumpBack<CR>

		" Normal mode: open last closed search window again
		nnoremap <leader>fl :AnyJumpLastResults<CR>

	" }}}

	" Movement {{{
	Plug 'jeffkreeftmeijer/vim-numbertoggle'
	Plug 'justinmk/vim-sneak'
		let g:sneak#label = 1
	" }}}

	" Behaviour {{{
	Plug 'tpope/vim-repeat', {}
	"Plug 'tpope/vim-surround', {}
	Plug 'machakann/vim-sandwich', {}
		augroup NERDTree-disable-sandwich
			autocmd FileType nerdtree nnoremap <buffer><nowait> s :call nerdtree#ui_glue#invokeKeyMap('s')<CR>
		augroup END
	Plug 'tpope/vim-characterize', {}

	"Causes excessive screen redrawing
	"Plug 'wellle/context.vim', {}

	" }}}

	" History and VCS {{{
	Plug 'tpope/vim-fugitive'
		autocmd QuickFixCmdPost *log* cwindow
		autocmd QuickFixCmdPost *grep* cwindow

	Plug 'mbbill/undotree'
		if !exists('g:undotree_WindowLayout')
			let g:undotree_WindowLayout = 4
			nnoremap <F3> :UndotreeToggle<CR>
		endif
	" }}}

	" Refactoring {{{
	Plug 'scrooloose/nerdcommenter'

	Plug 'PeterRincker/vim-argumentative', {}
	Plug 'tpope/vim-abolish', {}

	Plug 'godlygeek/tabular', {}
		nmap <Leader>a,	 :Tabularize /,<CR>
		vmap <Leader>a,	 :Tabularize /,<CR>
		nmap <Leader>a=	 :Tabularize /=<CR>
		vmap <Leader>a=	 :Tabularize /=<CR>
		nmap <Leader>a=>	:Tabularize /=><CR>
		vmap <Leader>a=>	:Tabularize /=><CR>

	" }}}

	" File Management {{{

	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
		if executable('rg')
			let $FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
		elseif executable('ag')
			let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
		endif
		nnoremap <Leader>o :Files<cr>
		nnoremap <Leader>b :Buffers<cr>

	Plug 'scrooloose/nerdtree', {}
		nnoremap <F2> :NERDTreeToggle<CR>
		nnoremap <S-F2> :NERDTreeFocus<CR>
		nnoremap <Leader>sit :NERDTreeFind<CR>

		let NERDTreeShowHidden=1
		" Ignore vcs files, project files and resource forks.
		let NERDTreeIgnore=[	'\.git$',
					\ '\.svn$',
					\ '\.project$',
					\ '\.settings$',
					\ '\.buildpath$',
					\ '\._.+$',
					\ '\.git_externals$',
					\ '\.gitignore',
					\ '\.gitkeep',
					\'\.DS_Store' ]

		let NERDTreeMinimalUI=1
		let NERDTreeShowBookmarks=1
		let NERDTreeShowLineNumbers=1

	Plug 'tpope/vim-apathy', {}

	" }}}

	" Look & Feel {{{
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
		let g:airline#extensions#tabline#enabled = 1
		let g:airline_powerline_fonts = 1
		let g:airline_theme = 'powerlineish'

		if !exists('g:airline_symbols')
			let g:airline_symbols = {}
		endif

		let g:airline_left_sep = ''
		let g:airline_left_alt_sep = ''
		let g:airline_right_sep = ''
		let g:airline_right_alt_sep = ''
		let g:airline_symbols.branch = ''
		let g:airline_symbols.readonly = ''
		let g:airline_symbols.linenr = ''

		Plug 'rafi/awesome-vim-colorschemes'
	" }}}

	" Language Specific {{{
	Plug 'pangloss/vim-javascript'
	Plug 'leafgarland/typescript-vim'
	Plug 'peitalin/vim-jsx-typescript'

	Plug 'plasticboy/vim-markdown', {}
	"Plug 'tpope/vim-markdown', {}
		au BufNewFile,BufReadPost *.md set filetype=markdown
		au BufNewFile,BufReadPost README set filetype=markdown
		let g:vim_markdown_fenced_languages = ['css', 'erb=eruby', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'html', 'shell=sh']

	Plug 'stephpy/vim-yaml', {}
	Plug 'chase/vim-ansible-yaml', {}
	Plug 'elzr/vim-json', {}
		au! BufRead,BufNewFile *.json set filetype=json
		augroup json_autocmd
			autocmd!
			autocmd FileType json set autoindent
			autocmd FileType json set formatoptions=tcq2l
			autocmd FileType json set foldmethod=syntax
		augroup END

	Plug 'https://github.com/m-kat/aws-vim'

	Plug 'hashivim/vim-terraform'
	Plug 'juliosueiras/vim-terraform-completion'

	Plug 'Glench/Vim-Jinja2-Syntax'
		augroup jinja2_ft
			autocmd!
			autocmd BufNewFile,BufRead,BufReadPost *.yml.j2    set ft=yaml.jinja syntax=yaml.jinja
			autocmd BufNewFile,BufRead,BufReadPost *.yaml.j2   set ft=yaml.jinja syntax=yaml.jinja
			autocmd BufNewFile,BufRead,BufReadPost *.json.j2   set ft=json.jinja syntax=yaml.jinja
		augroup END
	Plug 'wilriker/gcode.vim'
	" }}}

call plug#end()


"}}}

" WINDOW NAVIGATION {{{
" =================

	nnoremap <Leader>q <C-W>q

	nnoremap <Leader>k <C-W>k
	nnoremap <Leader>j <C-W>j
	nnoremap <Leader>h <C-W>h
	nnoremap <Leader>l <C-W>l

" Closes the current buffer
" Manage Tabs
	nnoremap <Leader>mtr :tabp<CR>
	nnoremap <Leader>mtl :tabn<CR>
	nnoremap <Leader>it :tabnew<CR>
" Change Sizes
"	 Vertical Size
	nnoremap <Leader>mwl <C-W>+
	nnoremap <Leader>mwh <C-W>-
"	Horizontal Size
	nnoremap <Leader>mwk <C-W><
	nnoremap <Leader>mwj <C-W>>
"	Zoom Toggle
	nnoremap <Leader>mwm <C-W>=
	nnoremap <Leader>mwn <C-W>_<C-W><Bar>
"}}}

" WINDOW CREATION {{{
" ==============
"
" Vertical total span
"	 Left
	nnoremap <Leader>iwH	 :topleft	vnew<CR>
"	Right
	nnoremap <Leader>iwL	 :botright	vnew<CR>
" Horizontal total span
"	 Left
	nnoremap <Leader>iwK	 :topleft	new<CR>
"	Right
	nnoremap <Leader>iwJ	 :botright new<CR>
"
" Horizontal Split
"	 Left
	nnoremap <Leader>iwh :leftabove	vnew<CR>
"	Right
	nnoremap <Leader>iwl :rightbelow vnew<CR>
" Horizontal Split
"	 Left
	nnoremap <Leader>iwk :leftabove	new<CR>
"	Right
	nnoremap <Leader>iwj :rightbelow new<CR>
"}}}

" MAPPINGS {{{
" ==============
"
" Visual linewise up and down by default (and use gj gk to go quicker)
nnoremap j gj
nnoremap k gk
nnoremap gj 5j
nnoremap gk 5k
vnoremap j gj
vnoremap k gk
vnoremap gj 5j
vnoremap gk 5k

" More logical Y (default was alias for yy)
nnoremap Y y$

" Quick replay 'q' macro
nnoremap Q @q

" Don't yank to default register when changing something
nnoremap c "xc
xnoremap c "xc

" After block yank and paste, move cursor to the end of operated text and don't override register
" search for yanked text :%s/<CTRL-R>"/"/g
vnoremap y y`]
vnoremap p "_dP`]
nnoremap p p`]

" Don't cancel visual select when shifting
xnoremap <	<gv
xnoremap >	>gv

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Reselect last-pasted text (not sure which binding i like better)
nnoremap gp `[v`]
nnoremap gV `[v`]

nnoremap <Leader>tw	mt:%s@\s\+$@@ge<CR>`t:delm t<CR>:noh<CR>:let @/ = ""<CR>			" Trim whitespace
command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

" Change working dir to current
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Hide highlights
nnoremap <Leader><Leader> :noh<CR>

" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Stop that q window popping up
nnoremap q: :q

" Mappings for tag navigation
" Use [] for back/forward. Use the g behaviour by default
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
nnoremap g<c-]> <c-]>
vnoremap g<c-]> <c-]>

" dts for inserting timestamp for journalling or comments
iab <expr> dts strftime("%Y%m%d %H%M   \>")
" ✓ mark replacement for checklists
nnoremap <Leader>tick r<C-V>u2713<Esc>
"}}}

colorscheme molokai
