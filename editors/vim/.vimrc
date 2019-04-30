" UR : http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.

"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" ard for plugins that are filetype specific.
filetype indent plugin on

"------------------------------------------------------------
set nowrap
set noswapfile

"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline


"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Fix split dragging inside tmux/byobu
" See https://superuser.com/questions/549930/cant-resize-vim-splits-inside-tmux
if has("mouse_sgr")
    set ttymouse=sgr
else
    set ttymouse=xterm2
end

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=1

" Display line numbers on the left
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>


"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab

" Indentation settings for using hard tabs for indent. Display tabs as
" four characters wide.
"set shiftwidth=4
"set tabstop=4


"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings

" Use space as leader:
let mapleader = " "

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

"------------------------------------------------------------
" Vundle and plugins

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.

Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'tomasr/molokai'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'altercation/vim-colors-solarized'
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/vimshell.vim'
Plugin 'Shougo/unite.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'ryanoasis/vim-devicons'
Plugin 'majutsushi/tagbar'
Plugin 'junegunn/vim-easy-align'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'wesQ3/vim-windowswap'
Plugin 'simeji/winresizer'
Plugin 'junegunn/fzf.vim'
Plugin 'tikhomirov/vim-glsl'
Plugin 'peterhoeg/vim-qml'
Plugin 'amix/vim-2048'
Plugin 'kana/vim-operator-user'
Plugin 'rhysd/vim-clang-format'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'reedes/vim-pencil'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'martinda/Jenkinsfile-vim-syntax'
Plugin 'paroxayte/vwm.vim'
Plugin 'lvht/tagbar-markdown'
Plugin 'mzlogin/vim-markdown-toc'
Plugin 'haya14busa/incsearch.vim'
Plugin 'haya14busa/incsearch-fuzzy.vim'
Plugin 'osyo-manga/vim-over'
Plugin 'itchyny/lightline.vim'
Plugin 'terryma/vim-multiple-cursors'

" Pathogen does not support install hooks so the install() call will not
" be run automatically. Run it again on first start.
" See
" https://github.com/iamcco/markdown-preview.nvim/issues/43#issuecomment-478414688
Plugin 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" NERDtree related config
let g:nerdtree_tabs_open_on_console_startup=0

" Syntax highlighting
syntax on
colorscheme molokai

" Solarized colorscheme config
let g:solarized_termcolors=256

set guifont=Inconsolata-dz\ for\ Powerline\ Plus\ Nerd\ File\ Types\ 12
set encoding=utf-8
" required if using https://github.com/bling/vim-airline
let g:airline_powerline_fonts=1
"
" Doxygen settings
let g:DoxygenToolkit_briefTag_pre="\\brief "
let g:DoxygenToolkit_paramTag_pre="\\param "
let g:DoxygenToolkit_templateParamTag_pre="\\tparam "
let g:DoxygenToolkit_returnTag_pre="\\returns "

" fzf config
set rtp+=~/.fzf " add fzf repo to vim runtime path

" Override Ag command to ignore filenames but only show files which
" content matches. See https://github.com/junegunn/fzf.vim/issues/346
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args> , '--word-regex', <bang>0)

" ConqueGDB settings

" Use buildroot ARM gdb
"let g:ConqueGdb_GdbExe = '/home/manuel/wmip/octopus-vserver-v3/output/host/usr/bin/arm-linux-gdb'

" clang-format config:
let g:clang_format#command = 'clang-format-6.0'
let g:clang_format#auto_format_on_insert_leave = 1 " format when leaving insert mode
let g:clang_format#auto_formatexpr = 1             " use clang-format for vim block formatting
let g:clang_format#enable_fallback_style = 0       " Disable fallback style, does nothing if no config file is found
autocmd FileType c,cpp,protobuf ClangFormatAutoEnable

" markdown preview config:
let vim_markdown_preview_github=1
let vim_markdown_preview_toggle=1

" vim-markdown config:
let g:markdown_enable_spell_checking = 0
let g:vim_markdown_conceal = 3
let g:vim_markdown_folding_disabled = 1

" markdown-preview.nvim config:
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 1

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

function! g:Open_browser(url)
    echo "Opening Markdown preview Google Chrome Window for " . a:url . " ..."
    silent exec "! google-chrome-stable --app=" . a:url . " &"
endfunction

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = 'g:Open_browser'

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'relative',
    \ 'hide_yaml_meta': 1
    \ }

" use a custom markdown style must be absolute path
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" vim-markdown-toc config:
let g:vmt_cycle_list_item_markers = 1

" vim-pencil config
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END

" incsearch config

set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

map / <Plug>(incsearch-fuzzy-/)
map ? <Plug>(incsearch-fuzzy-?)
map g/ <Plug>(incsearch-fuzzy-stay)

