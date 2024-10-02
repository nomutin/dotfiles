-- Minimalist neovim configuration by @nomutin

-- ====== OPTIONS ======
vim.loader.enable()
vim.g.mapleader = " "
vim.opt.title = true
vim.opt.termguicolors = true
vim.opt.completeopt = { "menu", "menuone", "noselect", "popup" }
vim.opt.pumheight = 10
vim.opt.ignorecase, vim.opt.smartcase = true, true
vim.opt.scrolloff, vim.opt.sidescrolloff = 8, 8
vim.opt.showtabline = 1
vim.opt.laststatus = 3
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.undofile = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.wrap = false
vim.opt.list = true
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
local servers = { "bashls", "biome", "jsonls", "lua_ls", "pyright", "ruff", "taplo", "rust_analyzer", "yamlls" }

require("lazy").setup({
  { "github/copilot.vim", event = "BufRead" },
  { "folke/flash.nvim", lazy = true },
  { "lewis6991/gitsigns.nvim", event = "BufRead", opts = {} },
  { "nvim-lualine/lualine.nvim", event = "BufRead", dependencies = { "nvim-tree/nvim-web-devicons" }, opts = {} },
  {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    dependencies = { "hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      for _, server in ipairs(servers) do
        require("lspconfig")[server].setup({})
      end
      require("cmp").setup({
        mapping = require("cmp").mapping.preset.insert({}),
        sources = { { name = "nvim_lsp" } },
      })
    end,
  },
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" }, lazy = true, opts = {} },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    main = "nvim-treesitter.configs",
    opts = { highlight = { enable = true }, indent = { enable = true } },
  },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim", }, lazy = true },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      spec = {
        { "jk", "<ESC>", mode = "i", desc = "Return to Normal Mode" },
        { "s", "<cmd>lua require('flash').jump()<cr>", desc = "Flash" },
        { "S", "<cmd>lua require('flash').treesitter()<cr>", desc = "Flash Treesitter" },
        { "<leader>?", "<cmd>lua require('which-key').show()", desc = "Keymaps"},
        { "<leader>f", "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = "Find Files" },
        { "<leader>/", "<cmd>lua require('telescope.builtin').live_grep()<cr>", desc = "Search Word" },
        { "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>", desc = "List Buffers" },
        { "<leader>n", "<cmd>lua require('nvim-tree.api').tree.toggle()<cr>", desc = "File Explorer" },
        { "<leader>d", "<cmd>lua require('gitsigns').diffthis()<cr>", desc = "Git Diff" },
      }
    },
  },
})
