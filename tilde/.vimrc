set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Add support for `.editorconfig` files
Plugin 'editorconfig/editorconfig-vim'

" Fuzzy search
Plugin 'wincent/command-t'

" File tree plugin
Plugin 'scrooloose/nerdtree'

" Set `wildignore` from `.gitignore`
Plugin 'gitignore'

" Status bar
Plugin 'itchyny/lightline.vim'

" Tmux integration
Plugin 'tmux-plugins/vim-tmux'

" Key mappings for navigating between Vim and Tmux splits:
"   <Ctrl-h> => Left
"   <Ctrl-j> => Down
"   <Ctrl-k> => Up
"   <Ctrl-l> => Right
"   <Ctrl-\> => Previous
Plugin 'christoomey/vim-tmux-navigator'

" By default only native commands are repeated when using the `.` command.
" This plugin remaps the `.` key to allow plugin commands to be repeated.
Plugin 'tpope/vim-repeat'

" Use `<Ctrl-A>` and `<Ctrl-X>` to increment / decrement dates.
Plugin 'tpope/vim-speeddating'

" Shortcut key mappings for common ex commands. For example:
"   [<Space> adds a newline above the current one
"   ]<Space> adds a newline below the current one
"   [e exchanges the current line with the one above it
"   ]e exchanges the current line with the one below it
" See: https://github.com/tpope/vim-unimpaired
Plugin 'tpope/vim-unimpaired'

" Replace surrounding quotes / brackets
" e.g. `cs"'` replaces surrounding double-quotes with single-quotes
" See: https://github.com/tpope/vim-surround
Plugin 'tpope/vim-surround'

" Git integration
Plugin 'tpope/vim-fugitive'

" UNIX helpers (remove, move, rename, chmod, mkdir, etc.)
Plugin 'tpope/vim-eunuch'

" Show git diff in gutter
Plugin 'airblade/vim-gitgutter'

" Color schemes
Plugin 'EvitanRelta/vim-colorschemes'

" Comment / un-comment code
Plugin 'tpope/vim-commentary'

" Automatically add `end` in Ruby and equivalents in Vimscript, Bash, etc.
Plugin 'tpope/vim-endwise'

" Automatically close quotes, parens, brackets, etc.
Plugin 'raimondi/delimitmate'

" Visual indentation guide
" Plugin 'yggdroot/indentline'

" Highlight trailing whitespace, `:FixWhitespace` helper
Plugin 'bronson/vim-trailing-whitespace'

" 1 - Automatic correction of commonly-misspelled words
"   e.g. to convert all variants of `seperate` to `separate`:
"   :Abolish seperat{e,es,ed,ely,ing,ion,ions,or} separat{}
" 2 - Search for and replace multiple variants of a word
"   e.g. to replace all variants of `facility` with `building`:
"   :S/facilit{y,ies}/building{,s}/g
" 3 - Format strings:
"   crs => snake_case
"   crm => MixedCase
"   crc => camelCase
"   cru => UPPER_CASE
Plugin 'tpope/vim-abolish'

" Async command runner
Plugin 'tpope/vim-dispatch'

" Rails helpers / tools
Plugin 'tpope/vim-rails'

" Bundler integration
Plugin 'tpope/vim-bundler'

" Heroku integration
Plugin 'tpope/vim-heroku'

" Rspec runner
Plugin 'thoughtbot/vim-rspec'

" TypeScript tools
Plugin 'clausreinke/typescript-tools.vim'

" Dart tools
Plugin 'dart-lang/dart-vim-plugin'

" Syntax plugins
Plugin 'sheerun/vim-polyglot'
Plugin 'isruslan/vim-es6'
Plugin 'leafgarland/typescript-vim'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'mattn/emmet-vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'cakebaker/scss-syntax.vim'

" Syntax checking / linting
Plugin 'scrooloose/syntastic'
Plugin 'gcorne/vim-sass-lint'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" allow unsaved background buffers and remember marks/undo for them
set hidden

" remember more commands and search history
set history=10000

" Configure indentation
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set autoindent
let g:indentLine_char = '│'

set showmatch
set incsearch
set hlsearch

" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase

" Highlight current line
set cursorline

" Height of the command line
set cmdheight=1

set switchbuf=useopen
set winwidth=79

" This makes RVM work inside Vim. I have no idea why.
set shell=bash

" Location for backup / temp files
set backup
set backupdir=~/.dotfiles/data/vim-tmp
set directory=~/.dotfiles/data/vim-tmp

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" display incomplete commands
set showcmd

" Enable highlighting for syntax
syntax on

" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list

" make tab completion for files/buffers act like bash
set wildmenu
let mapleader=','

" Fix slow O inserts
set timeout ttimeout timeoutlen=1000 ttimeoutlen=100

" Normally, Vim messes with iskeyword when you open a shell file. This can
" leak out, polluting other file types even after a 'set ft=' change. This
" variable prevents the iskeyword change so it can't hurt anyone.
let g:sh_noisk=1

" Modelines (comments that set vim options on a per-file basis)
set modeline
set modelines=3

" Turn folding off for real, hopefully
set foldmethod=manual
set nofoldenable

" Insert only one space when joining lines that contain sentence-terminating
" punctuation like `.`.
set nojoinspaces

" If a file is changed outside of vim, automatically reload it without asking
set autoread

" Automatically save file changes
set autowriteall

" Use the old vim regex engine (version 1, as opposed to version 2, which was
" introduced in Vim 7.3.969). The Ruby syntax highlighting is significantly
" slower with the new regex engine.
set re=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set t_Co=256 " 256 colors
set background=dark

try
  color grb256
  colorscheme smyck
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry

hi clear CursorLine
hi CursorLine gui=underline cterm=underline

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

" Alows show the status line
set laststatus=2

" Always show the tab line
set showtabline=2

" Hide default mode indicator
set noshowmode

" Lightline config
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'fugitive', 'filename' ] ]
  \ },
  \ 'component_function': {
  \   'fugitive': 'LightLineFugitive',
  \   'readonly': 'LightLineReadonly',
  \   'modified': 'LightLineModified',
  \   'filename': 'LightLineFilename'
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' }
  \ }

function! LightLineModified()
  if &filetype == 'help'
    return ''
  elseif &modified
    return '+'
  elseif &modifiable
    return ''
  else
    return ''
  endif
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "⭤"
  else
    return ""
  endif
endfunction

function! LightLineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? '⭠ '.branch : ''
  endif
  return ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

" Ensure EditorConfig and Fugitive plugins play nice
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Set ignore pattern for Command-T plugin to match `wildignore`
set wildignore+=tmp/**,.keep,.gitkeep,node_modules,bower_components,.git
set wildignore-=.githooks
let g:CommandTWildIgnore=&wildignore
let g:CommandTAlwaysShowDotFiles=1
let g:CommandTScanDotDirectories=1
let g:CommandTFileScanner='find'

" Enable sass-lint syntax checker
let g:syntastic_sass_checkers=["sass_lint"]
let g:syntastic_scss_checkers=["sass_lint"]

" vim-abolish config: replace commonly misspelled words
if exists(":Abolish")
  Abolish desparat{e,ely,ion}                   desperat{}
  Abolish seperat{e,es,ed,ing,ely,ion,ions,or}  separat{}
  Abolish persistan{ce,t,tly}                   persisten{}
  Abolish delimeter{,s}                         delimiter{}
  Abolish {,non}existan{ce,t}                   {}existen{}
  Abolish cal{a,e}nder{,s}                      cal{e}ndar{}
endif

" Text expansions
iabbrev #! #!/usr/bin/env
iabbrev #!b #!/usr/bin/env bash
iabbrev #!r #!/usr/bin/env ruby

" Toggle Paste Mode on or off
set pastetoggle=<F10>

" Use `Ctrl-V` in Insert Mode to paste text in Paste Mode
inoremap <C-V> <F10><C-R>+<F10>

" Use `,p` or `,v` in Normal Mode to paste text in Paste Mode
nnoremap <Leader>p i<F10><C-R>+<F10><Esc>
nnoremap <Leader>v i<F10><C-R>+<F10><Esc>
