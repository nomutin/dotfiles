-- ====== OPTIONS ======
vim.loader.enable()
vim.g.mapleader = " "
vim.opt.title = true
vim.opt.termguicolors = true
vim.opt.completeopt = { "menuone", "noselect", "popup" }
vim.opt.ignorecase = true
vim.opt.pumheight = 10
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.writebackup = false
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.laststatus = 3
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.list = true
vim.opt.clipboard = "unnamedplus"

-- ====== PLUGIN ======
vim.pack.add({
  { src = 'https://github.com/github/copilot.vim' },
  { src = 'https://github.com/ibhagwan/fzf-lua' },
  { src = 'https://github.com/lewis6991/gitsigns.nvim' },
  { src = 'https://github.com/sainnhe/gruvbox-material' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
})
require("fzf-lua").setup{}
require("gitsigns").setup{}
require("nvim-tree").setup{}
vim.cmd.colorscheme("gruvbox-material")

-- ====== KEYMAP ======
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("n", "<leader>f", require("fzf-lua").files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>/", require("fzf-lua").grep_project, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<cr>", { desc = "Explorer" })
vim.keymap.set("n", "<leader>d", require("gitsigns").diffthis, { desc = "Git diff" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.setloclist, { desc = "Diagnostics" })

-- ====== LSP ======
vim.diagnostic.config({ virtual_text = true })
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    client = vim.lsp.get_client_by_id(ev.data.client_id)
    local completion_provider = client.server_capabilities.completionProvider
    if completion_provider then
      completion_provider.triggerCharacters = vim.list_extend(
        completion_provider.triggerCharacters or {},
        vim.split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", "")
      )
    end
    vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = true })
  end,
})
