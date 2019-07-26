"===== 表示設定 =====
set number "行番号の表示
set title "編集中ファイル名の表示
set showmatch "括弧入力時に対応する括弧を示す
set list "タブ、空白、改行を可視化
set visualbell "ビープ音を視覚表示
set ruler "カーソル位置を表示
syntax on "コードに色をつける

"===== 文字、カーソル設定 =====
"set fenc=utf-8 "文字コードtabstop指定
set virtualedit=onemore "カーソルを行末の一つ先まで移動可能にする
set autoindent "自動インデント
set smartindent "オートインデント
set shiftwidth=4 "自動的に入力されたインデントの空白を2つ分に設定
set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮ "不可視文字の指定
set whichwrap=b,s,h,l,<,>,[,],~ "行頭、行末で行のカーソル移動を可能にする
let &t_ti.="\e[5 q" "カーソルの形状を変更
set cursorline
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4

"===== 検索設定 =====
set ignorecase "大文字、小文字の区別をしない
set smartcase "大文字が含まれている場合は区別する
set wrapscan "検索時に最後まで行ったら最初に戻る
set hlsearch "検索した文字を強調
set incsearch "インクリメンタルサーチを有効にする

"===== マウス設定 =====
set mouse=a
set ttymouse=xterm2

"===== キー入力 =====
"入力モード時のカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" 矢印キーを無効にする
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

"fjキーでノーマルモード
inoremap <silent> jj <Esc>
inoremap <silent> っj <Esc>
inoremap <C-x> <C-h>
nnoremap x X
nnoremap X x   
nnoremap a A
nnoremap A a
noremap <S-h> ^
noremap <S-l> $
nnoremap <CR> A<CR><ESC>
nnoremap == gg=G''
nnoremap <C-c><C-c> : <C-u>nohlsearch<cr><Esc>
set backspace=indent,eol,start

"=====ファイル出力無効化=====
set noswapfile
set nobackup
set noundofile

"=====色関係=====
colorscheme molokai
"colorscheme lucario

syntax on
set t_Co=256
set termguicolors
set background=dark
