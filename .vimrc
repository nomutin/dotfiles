" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

syntax enable
set background=dark
colorscheme material-theme
set t_Co=256

"===== 表示設定 =====
 set number "行番号の表示
 set title "編集中ファイル名の表示
 set showmatch "括弧入力時に対応する括弧を示す
 set list "タブ、空白、改行を可視化
 set ruler "カーソル位置を表示
 set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

 "===== 文字、カーソル設定 =====
 set guifont=Cica:h20
 set encoding=utf-8
 set virtualedit=onemore "カーソルを行末の一つ先まで移動可能にする
 set autoindent "自動インデント
 set smartindent "オートインデント
 set tabstop=4 "インデントをスペース4つ分に設定
 set shiftwidth=4 "自動的に入力されたインデントの空白を2つ分に設定
 set listchars=tab:▸\ ,eol:↲,extends:❯,precedes:❮ "不可視文字の指定
 set whichwrap=b,s,h,l,<,>,[,],~ "行頭、行末で行のカーソル移動を可能にする
 let &t_ti.="\e[5 q" "カーソルの形状を変更

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

 
 "fjキーでノーマルモード
 inoremap <silent> jj <Esc>
 inoremap <silent> っj <Esc>
 inoremap <C-x> <C-h>
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
set clipboard+=unnamed


set cursorline
hi clear CursorLine

