-- Minimalist neovim configuration by @nomutin

-- ====== OPTIONS ======
vim.loader.enable()
vim.g.mapleader = " "
vim.opt.title = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.completeopt = { "menu", "menuone", "noselect", "popup" }
vim.opt.pumheight = 10
vim.opt.ignorecase, vim.opt.smartcase = true, true
vim.opt.scrolloff, vim.opt.sidescrolloff = 8, 8
vim.opt.showtabline = 2
vim.opt.laststatus = 3
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.undofile = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.wrap = false
vim.opt.list = true
vim.keymap.set("i", "jk", "<ESC>", { noremap = true })
vim.api.nvim_set_hl(0, "Type", { fg = "NvimLightBlue" })

-- ====== CLIPBOARD ======
local function paste(_)
  return vim.split(vim.fn.getreg('"'), "\n")
end
local osc52 = require("vim.ui.clipboard.osc52")
vim.g.clipboard = {
  copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
  paste = { ["+"] = paste, ["*"] = paste },
}

-- ====== PLUGIN ======
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyrepo = "https://github.com/folke/lazy.nvim.git"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "saghen/blink.cmp",
    lazy = false,
    version = "v0.*",
    opts = {
      trigger = { signature_help = { enabled = true } },
      windows = { autocomplete = { selection = "auto_insert" } },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = { suggestion = { auto_trigger = true, hide_during_completion = false } },
  },
  {
    "folke/flash.nvim",
    keys = {
      { "s", "<cmd>lua require('flash').jump()<cr>", desc = "Flash" },
      { "S", "<cmd>lua require('flash').treesitter()<cr>", desc = "Flash Treesitter" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    keys = { { "<leader>d", "<cmd>Gitsigns diffthis<cr>", desc = "Git Diff" } },
    opts = {},
  },
  { "nvim-lualine/lualine.nvim", dependencies = "nvim-tree/nvim-web-devicons", event = "BufRead", opts = {} },
  {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    config = function()
      local servers = { "bashls", "biome", "jsonls", "lua_ls", "pyright", "ruff", "taplo", "rust_analyzer", "yamlls" }
      for _, server in ipairs(servers) do
        require("lspconfig")[server].setup({})
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    main = "nvim-treesitter.configs",
    opts = { highlight = { enable = true }, indent = { enable = true } },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-file-browser.nvim" },
    keys = {
      { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Search Word" },
      { "<leader>n", "<cmd>Telescope file_browser hidden=true path=%:p:h<cr>", desc = "Open File Browser" },
    },
  },
})
