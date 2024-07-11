-- Minimalist neovim configuration by @nomutin

-- ====== OPTIONS ======
vim.loader.enable()
vim.g.mapleader = " "
vim.opt.title = true -- ウィンドウのタイトルを現在開いているファイル名で更新
vim.opt.termguicolors = true -- ターミナルの色を24ビットカラーに設定
vim.opt.clipboard = "unnamedplus" -- システムのクリップボードを使用
vim.opt.completeopt = { "menuone", "noselect" } -- 補完メニューを表示し、自動で選択しない
vim.opt.pumheight = 10 -- ポップアップメニューの高さを10行に設定
vim.opt.showtabline = 2 -- タブラインを常に表示
vim.opt.ignorecase = true -- 検索時に大文字小文字を区別しない
vim.opt.smartcase = true -- 検索パターンに大文字が含まれている場合は大文字小文字を区別
vim.opt.smartindent = true -- 自動インデントを有効に
vim.opt.undofile = true -- アンドゥ情報をファイルに保存
vim.opt.expandtab = true -- タブをスペースに展開
vim.opt.cursorline = true -- カーソル行をハイライト
vim.opt.number = true -- 行番号を表示
vim.opt.wrap = false -- 折り返しを無効に
vim.opt.scrolloff = 8 -- スクロール時に画面の端から8行分余裕を持たせる
vim.opt.sidescrolloff = 8 -- スクロール時に画面の端から8列分余裕を持たせる
vim.opt.laststatus = 3 -- 最後のウィンドウのステータスラインを常に表示
vim.opt.list = true -- 制御文字を表示

-- ====== KEYMAP ======
vim.keymap.set("i", "jk", "<ESC>") -- インサートモード時jk でノーマルモードに戻る
vim.keymap.set("t", "fd", [[<C-\><C-n>]]) -- Terminal Mode 時 fd でノーマルモードに戻る
vim.keymap.set("x", "<M-k>", ":move '<-2<CR>gv=gv") -- 選択範囲を上に移動
vim.keymap.set("x", "<M-j>", ":move '>+1<CR>gv=gv") -- 選択範囲を下に移動
vim.keymap.set("n", "gd", vim.lsp.buf.definition) -- 定義ジャンプ
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format) -- フォーマット

-- ===== NETRW =====
vim.g.netrw_banner = 0 -- バナーを非表示
vim.g.netrw_liststyle = 3 -- ツリービュー形式で表示
vim.g.netrw_showhide = 1 -- 隠しファイルを表示
vim.g.netrw_browse_split = 4 -- ファイルを開くときに新しいウィンドウを作成
vim.g.netrw_altv = 1 -- ファイルを開くときに垂直分割
vim.g.netrw_winsize = -28 -- ウィンドウサイズ
vim.g.netrw_keepdir = 0  -- ディレクトリを開いたときに元のウィンドウを閉じる

-- ====== COLORS ======
vim.api.nvim_set_hl(0, "Function", { fg = "NvimLightBlue" })
vim.api.nvim_set_hl(0, "Identifier", { fg = "NvimLightBlue" })
vim.api.nvim_set_hl(0, "Constant", { fg = "NvimLightCyan" })
vim.api.nvim_set_hl(0, "Statement", { fg = "NvimLightBlue", bold = true })
vim.api.nvim_set_hl(0, "Special", { link = "Constant" })
vim.api.nvim_set_hl(0, "@string.documentation", { fg = "NvimLightGreen", bold = true })
vim.api.nvim_set_hl(0, "@variable.parameter", { fg = "NvimLightCyan", italic = true })

-- ====== PLUGIN ======
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyrepo = "https://github.com/folke/lazy.nvim.git"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "github/copilot.vim", event = "BufRead" },
  {
    "folke/flash.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, "<cmd>lua require('flash').jump()<cr>" },
      { "S", mode = { "n", "x", "o" }, "<cmd>lua require('flash').treesitter()<cr>" },
    }
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    keys = {
      { "<leader>hd", mode = "n", "<cmd>Gitsigns diffthis<cr>" },
      { "<leader>hp", mode = "n", "<cmd>Gitsigns preview_hunk<cr>" },
    },
    opts = {}
  },
  { "nvim-lualine/lualine.nvim", event = "BufRead", opts = {} },
  {
    "williamboman/mason.nvim",
    event = "BufRead",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
          })
        end,
      })
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({}),
        sources = cmp.config.sources({ { name = "nvim_lsp" } }),
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "jay-babu/mason-null-ls.nvim" },
    event = "BufRead",
    opts = {}
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    main = "nvim-treesitter.configs",
    opts = { highlight = { enable = true }, indent = { enable = true } }
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", mode = "n", "<cmd>Telescope find_files<cr>" },
      { "<leader>fg", mode = "n", "<cmd>Telescope live_grep<cr>" },
      { "<leader>fb", mode = "n", "<cmd>Telescope buffers<cr>" },
    }
  },
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm direction=float<cr>" },
      { "<leader>tj", "<cmd>ToggleTerm direction=horizontal<cr>" },
    },
    opts = {}
  },
  defaults = { lazy = true },
})
