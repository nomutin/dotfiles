-- ====== BUILTIN ======
vim.loader.enable()
vim.g.mapleader = " "
vim.opt.autocomplete = true
vim.opt.clipboard = "unnamedplus"
vim.opt.complete = "o"
vim.opt.completeopt = { "menuone", "noselect", "popup" }
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.laststatus = 3
vim.opt.list = true
vim.opt.pumheight = 10
vim.opt.scrolloff = 8
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = -30
vim.g.netrw_banner = 0
vim.g.netrw_usetab = 1
vim.diagnostic.config({ virtual_text = true })
vim.cmd.colorscheme("catppuccin")

-- ====== PLUGIN ======
vim.pack.add({
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
})
require("fzf-lua").setup{}
require("gitsigns").setup{}

-- ====== KEYMAP ======
vim.keymap.set("i", "jk", "<ESC>", { desc = "Remap Esc" })
vim.keymap.set("n", "<leader>f", require("fzf-lua").files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>/", require("fzf-lua").grep_project, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>g", require("fzf-lua").git_status, { desc = "Git Status" })
vim.keymap.set("n", "<leader>d", require("gitsigns").diffthis, { desc = "Git diff" })
vim.keymap.set("n", "<leader>n", "<Plug>NetrwShrink", { desc = "Explorer" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.setloclist, { desc = "Diagnostics" })
