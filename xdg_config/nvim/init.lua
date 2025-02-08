-- Minimalist neovim configuration by @nomutin

-- ====== OPTIONS ======
vim.loader.enable()
vim.g.mapleader = " "
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.ignorecase, vim.opt.smartcase = true, true
vim.opt.scrolloff, vim.opt.sidescrolloff = 8, 8
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.undofile = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.list = true
vim.opt.number = true

-- ====== CLIPBOARD ======
vim.opt.clipboard = "unnamedplus"
local osc52 = require("vim.ui.clipboard.osc52")
local function paste(_)
  return vim.split(vim.fn.getreg('"'), "\n")
end
vim.g.clipboard = {
  copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
  paste = { ["+"] = paste, ["*"] = paste },
}

-- ====== COMPLETION ======
vim.opt.completeopt = { "menu", "menuone", "noselect", "popup" }
vim.opt.pumheight = 10
local function lsp_attach(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if not client or not client:supports_method("textDocument/completion") then
    return
  end
  vim.lsp.completion.enable(true, args.data.client_id, args.buf, { autotrigger = true })
  vim.api.nvim_create_autocmd("TextChangedI", { callback = vim.lsp.completion.trigger })

  local function complete_changed(_)
    client:request(
      "completionItem/resolve",
      vim.tbl_get(vim.v.completed_item, "user_data", "nvim", "lsp", "completion_item"),
      function(err, result)
        if err then
          return
        end
        local docs = vim.tbl_get(result, "documentation", "value")
        local win = vim.api.nvim__complete_set(vim.fn.complete_info().selected, { info = docs })
        if win.winid and vim.api.nvim_win_is_valid(win.winid) then
          vim.treesitter.start(win.bufnr, "markdown")
          vim.wo[win.winid].conceallevel = 3
        end
      end
    )
  end
  vim.api.nvim_create_autocmd("CompleteChanged", { callback = complete_changed })
end
vim.api.nvim_create_autocmd("LspAttach", { callback = lsp_attach })

-- ====== KEYMAP ======
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")
vim.keymap.set("n", "<leader>e", vim.diagnostic.setqflist, { noremap = true, desc = "Show Diagnostic" })
vim.keymap.set("n", "<leader>E", vim.diagnostic.setloclist, { noremap = true, desc = "Show Buf Diagnostic" })

-- ====== COLOR ======
vim.api.nvim_set_hl(0, "PreProc", { bold = true })
vim.api.nvim_set_hl(0, "Statement", { fg = "NvimLightBlue", bold = true })
vim.api.nvim_set_hl(0, "Operator", { link = "Statement" })
vim.api.nvim_set_hl(0, "Number", { fg = "NvimLightBlue" })

-- ====== PLUGIN ======
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyrepo = "https://github.com/folke/lazy.nvim.git"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "lewis6991/gitsigns.nvim", event = "BufRead", opts = {} },
  {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    config = function()
      local lsps = { "bashls", "biome", "jsonls", "lua_ls", "pyright", "ruff", "taplo", "yamlls" }
      for _, lsp in ipairs(lsps) do
        require("lspconfig")[lsp].setup({})
      end
    end,
  },
  {
    "folke/snacks.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>f", "<cmd>lua require('snacks').picker.files()<cr>", desc = "Find Files" },
      { "<leader>/", "<cmd>lua require('snacks').picker.grep()<cr>", desc = "Live Grep" },
      { "<leader>n", "<cmd>lua require('snacks').explorer()<cr>", desc = "Explorer" },
      { "<leader>d", "<cmd>lua require('gitsigns').diffthis()<cr>", desc = "Git Diff" }
    },
    opts = { dashboard = { enabled = true } },
  },
  { "supermaven-inc/supermaven-nvim", event = "InsertEnter", opts = {} },
})
