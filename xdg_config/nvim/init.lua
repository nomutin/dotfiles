-- Minimalist neovim configuration by @nomutin

-- ====== OPTIONS ======
vim.loader.enable()
vim.g.mapleader = " "
vim.opt.title = true
vim.opt.termguicolors = true
vim.opt.completeopt = { "menu", "menuone", "noselect", "popup" }
vim.opt.pumheight = 10
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff, vim.opt.sidescrolloff = 8, 8
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.undofile = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.list = true

-- ====== MAPPING ======
vim.api.nvim_set_hl(0, "Type", { fg = "NvimLightBlue" })
vim.keymap.set("n", "x", '"_x', { noremap = true, silent = true, desc = "Blackhole Delete" })
vim.keymap.set("i", "jk", "<ESC>", { noremap = true, desc = "Return to Normal Mode" })
vim.keymap.set("t", "fd", "<C-\\><C-n>", { noremap = true, desc = "Return to Normal Mode" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.setloclist, { noremap = true, desc = "Show Diagnostic" })
vim.keymap.set("n", "<leader>d", "<cmd>Gitsigns diffthis<cr>", { noremap = true, desc = "Git Diff" })

-- ====== COMPLETION ======
local function enable_completion(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if client and client.supports_method("textDocument/completion") then
    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
  end
end
vim.api.nvim_create_autocmd("LspAttach", { callback = enable_completion })
vim.api.nvim_create_autocmd("InsertCharPre", { callback = vim.lsp.completion.trigger })

-- ====== CLIPBOARD ======
vim.opt.clipboard = "unnamedplus"
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
    "folke/flash.nvim",
    keys = {
      { "s", "<cmd>lua require('flash').jump()<cr>", desc = "Flash" },
      { "S", "<cmd>lua require('flash').treesitter()<cr>", desc = "Flash Treesitter" },
    },
  },
  { "lewis6991/gitsigns.nvim", event = "BufRead", opts = {} },
  {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    config = function()
      local lsps = { "bashls", "biome", "jsonls", "lua_ls", "pyright", "ruff", "rust_analyzer", "taplo", "yamlls" }
      for _, lsp in ipairs(lsps) do
        require("lspconfig")[lsp].setup({})
      end
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    main = "nvim-treesitter.configs",
    opts = { highlight = { enable = true }, indent = { enable = true } },
  },
  { "supermaven-inc/supermaven-nvim", event = "InsertEnter", opts = {} },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>f", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Search Word" },
      { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "List Buffers" },
      { "<leader>n", "<cmd>Telescope file_browser hidden=true path=%:p:h<cr>", desc = "Open File Browser" },
    },
  },
})
