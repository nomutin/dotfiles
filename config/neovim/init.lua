-- ====== OPTIONS ======
vim.loader.enable()
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.title = true                            -- ウィンドウのタイトルを現在開いているファイル名で更新
vim.opt.clipboard = "unnamedplus"               -- システムのクリップボードを直接使用
vim.opt.completeopt = { "menuone", "noselect" } -- 補完メニューを表示し、自動で選択しない
vim.opt.ignorecase = true                       -- 検索時に大文字小文字を区別しない
vim.opt.pumheight = 10                          -- ポップアップメニューの高さを10行に設定
vim.opt.showtabline = 2                         -- タブラインを常に表示
vim.opt.smartcase = true                        -- 検索パターンに大文字が含まれている場合は大文字小文字を区別
vim.opt.smartindent = true                      -- 自動インデントを有効に
vim.opt.swapfile = false                        -- スワップファイルを作成しないように
vim.opt.timeoutlen = 500                        -- キーマッピングの待ち時間を300ミリ秒に設定
vim.opt.undofile = true                         -- アンドゥ情報をファイルに保存
vim.opt.writebackup = false                     -- 書き込み時のバックアップファイルを作成しないように
vim.opt.expandtab = true                        -- タブをスペースに展開
vim.opt.shiftwidth = 2                          -- シフト幅を2に設定
vim.opt.tabstop = 2                             -- タブ文字を2文字分として扱う
vim.opt.cursorline = true                       -- カーソル行をハイライト
vim.opt.number = true                           -- 行番号を表示
vim.opt.wrap = false                            -- 折り返しを無効に
vim.opt.wildoptions = "pum"                     -- コマンドライン補完でポップアップメニューを使用
vim.opt.pumblend = 20                           -- ポップアップメニューの透過度を20に設定
vim.opt.scrolloff = 8                           -- スクロール時に画面の端から8行分余裕を持たせる
vim.opt.sidescrolloff = 8                       -- スクロール時に画面の端から8列分余裕を持たせる
vim.opt.splitbelow = true                       -- 新しいウィンドウを水平分割する時、現在のウィンドウの下に開く
vim.opt.splitright = true                       -- 新しいウィンドウを垂直分割する時、現在のウィンドウの右に開く
vim.opt.laststatus = 3                          -- ステータスラインを常に表示し、現在のウィンドウだけでなく全てのウィンドウに適用
vim.opt.list = true                             -- 制御文字を表示

-- ====== KEYMAP ======

-- jkでノーマルモードに戻る
vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true })

-- インサートモード時ctrl+hjklでカーソル移動
vim.keymap.set("i", "<C-h>", "<Left>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-j>", "<Down>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-k>", "<Up>", { noremap = true, silent = true })
vim.keymap.set("i", "<C-l>", "<Right>", { noremap = true, silent = true })

-- ターミナルモード時jkでノーマルモードに戻る
vim.keymap.set("t", "jk", [[<C-\><C-n>]], { noremap = true })

-- ノーマル/ビジュアルモード時alt+jkで行移動
vim.keymap.set("n", "<M-j>", "<Cmd>move .+1<CR>==")
vim.keymap.set("x", "<M-j>", ":move '>+1<CR>gv=gv")
vim.keymap.set("n", "<M-k>", "<Cmd>move .-2<CR>==")
vim.keymap.set("x", "<M-k>", ":move '<-2<CR>gv=gv")

-- ノーマルモード時-=_+` でウィンドウのリサイズ
vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]])
vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]])
vim.keymap.set("n", "+", [[<cmd>horizontal resize +2<cr>]])
vim.keymap.set("n", "_", [[<cmd>horizontal resize -2<cr>]])

-- build-in LSP
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.formatting()<CR>")
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
vim.keymap.set("n", "<leader>ll", "<cmd>LspInfo<CR>")
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>lf", function()
  vim.lsp.buf.format { timeout_ms = 200, async = true }
end)

-- ====== PLUGIN ======
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
local lazyrepo = "https://github.com/folke/lazy.nvim.git"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  -- ===== APPEAEANCE =====
  { "shaunsingh/nord.nvim", lazy = false },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "BufReadPre",
    config = true,
  },
  { "petertriho/nvim-scrollbar",   event = "BufReadPre", config = true },
  {
    "nvim-tree/nvim-tree.lua",
    keys = { { "<leader>n", "<CMD>NvimTreeToggle<CR>" } },
    opts = { filters = { git_ignored = false, dotfiles = false } },
  },

  -- ===== MOTION =====
  {
    "folke/flash.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, "<cmd>lua require('flash').jump()<cr>" },
      { "S", mode = { "n", "x", "o" }, "<cmd>lua require('flash').treesitter()<cr>" },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- ===== LSP =====
  { "github/copilot.vim", event = "BufRead" },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
    },
  },
  {
    "williamboman/mason.nvim",
    event = "BufRead",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "jay-babu/mason-null-ls.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "bashls",        -- bash
          "dockerls",      -- dockerfile
          "html",          -- html
          "lua_ls",        -- lua
          "tsserver",      -- typescript
          "pyright",       -- python
          "ruff",          -- python
          "rust_analyzer", -- rust
          "yamlls",        -- yaml
        },
      }
      require("mason-null-ls").setup {
        ensure_installed = {
          "hadolint",     -- dockerfile
          "stylua",       -- lua
          "markdownlint", -- markdown
          "shellcheck",   -- sh
          "shfmt",        -- sh
          "actionlint",   -- yaml
          "prettier",     -- javascript etc.
        },
        automatic_installation = false,
        handlers = {},
      }
      require("null-ls").setup()
      require("mason-lspconfig").setup_handlers {
        function(server_name)
          require("lspconfig")[server_name].setup {
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
          }
        end,
      }
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local cmp = require "cmp"
      cmp.setup {
        mapping = cmp.mapping.preset.insert {},
        sources = cmp.config.sources { { name = "nvim_lsp" } },
      }
    end,
  },

  -- ===== MISC =====
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    keys = {
      { "<leader>hd", "<cmd>Gitsigns diffthis<cr>" },
      { "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>" },
    },
    config = function()
      require("gitsigns").setup()
      require("scrollbar.handlers.gitsigns").setup()
    end,
  },
  { "akinsho/toggleterm.nvim", keys = { { "<c-\\>", "<cmd>ToggleTerm<cr>" } }, config = true },
  defaults = { lazy = true },
  performance = { cache = { enabled = true } },
}

vim.cmd "colorscheme nord"
