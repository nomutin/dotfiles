-- Minimalist neovim configuration by @nomutin

-- ====== OPTIONS ======
vim.loader.enable()
vim.g.mapleader = " "
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.showhide = 1
vim.g.netrw_altv = 1
vim.g.netrw_winsize = -28
vim.g.netrw_keepdir = 1
vim.opt.title = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.ignorecase = true
vim.opt.pumheight = 10
vim.opt.showtabline = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.undofile = true
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.laststatus = 3
vim.opt.list = true
vim.api.nvim_set_hl(0, "Function", { fg = "NvimLightBlue" })

-- ====== KEYMAP ======
vim.keymap.set("i", "jk", "<ESC>", { desc = "Return to normal mode" })
vim.keymap.set("t", "fd", [[<C-\><C-n>]], { desc = "Return to normal mode" })
vim.keymap.set("n", "<leader>n", "<cmd>Lexplore<cr>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>e", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set({ "n", "x", "o" }, "s", "<cmd>lua require('flash').jump()<cr>", { desc = "Jump" })
vim.keymap.set({ "n", "x", "o" }, "S", "<cmd>lua require('flash').treesitter()<cr>", { desc = "Select" })

-- ====== PLUGIN ======
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyrepo = "https://github.com/folke/lazy.nvim.git"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "github/copilot.vim", event = "BufRead" },
  { "folke/flash.nvim" },
  { "lewis6991/gitsigns.nvim", event = "BufRead", opts = {} },
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
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    main = "nvim-treesitter.configs",
    opts = { highlight = { enable = true }, indent = { enable = true } },
  },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
  defaults = { lazy = true },
})
