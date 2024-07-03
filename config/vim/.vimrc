set encoding=utf-8
scriptencoding utf-8

"===== 色関係 ====="
syntax enable
syntax on
set background=dark
set t_Co=256
colorscheme industry

"===== 表示設定 ====="
set number "行番号の表示"
set title "編集中ファイル名の表示"
set showmatch "括弧入力時に対応する括弧を示す"
set list "タブ、空白、改行を可視化"
set ruler "カーソル位置を表示"
set relativenumber "相対行番号の表示"

"===== 文字、カーソル設定 ====="
set autoindent "自動インデント"
set expandtab "タブキーを空白に変換"
set smartindent "オートインデント"
set tabstop=4 "インデントをスペース4つ分に設定"
set shiftwidth=4 "自動的に入力されたインデントの空白を4つ分に設定"
set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮ "不可視文字の指定"
set whichwrap=b,s,h,l,<,>,[,],~ "行頭、行末で行のカーソル移動を可能にする"
set cursorline
hi clear CursorLine
hi CursorLineNr term=bold  cterm=NONE ctermfg=228 ctermbg=NONE "カーソルのある行番号をハイライト"

"===== マウス ====="
set mouse=a  "全モードでマウスを有効化"
set ttymouse=xterm2 "マウスの動作を設定"

"===== キー入力 ====="
inoremap <silent> jk <Esc>
nnoremap == gg=G''
nnoremap <C-c><C-c> : <C-u>nohlsearch<cr><Esc>
set backspace=indent,eol,start
set wildmenu        "コマンドラインモードでTABキーによる補完を有効化"
set wildchar=<tab>  "コマンド補完を開始するキー"
let mapleader = "\<SPACE>"

"===== ファイル出力無効化 ====="
set noswapfile
set nobackup
set noundofile
set viminfo=

"===== 検索 ====="
set ignorecase "大文字、小文字の区別をしない"
set smartcase "大文字が含まれている場合は区別する"
set wrapscan "検索時に最後まで行ったら最初に戻る"
set hlsearch "検索した文字を強調"
set incsearch "インクリメンタルサーチを有効にする"

"===== 全角スペースのハイライト表示 ====="
"ref: http://code-life.net/?p=2704"

function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction
if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
call ZenkakuSpace()
endif
