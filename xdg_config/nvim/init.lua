-- Minimalist neovim configuration by @nomutin

-- ====== OPTIONS ======
vim.loader.enable()
vim.g.mapleader = " "
vim.opt.title = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menu", "menuone", "noselect", "popup" }
vim.opt.pumheight = 10
vim.opt.ignorecase, vim.opt.smartcase = true, true
vim.opt.scrolloff, vim.opt.sidescrolloff = 8, 8
vim.opt.showtabline, vim.opt.laststatus = 1, 3
vim.opt.smartindent, vim.opt.expandtab = true, true
vim.opt.undofile = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.wrap = false
vim.opt.list = true
vim.api.nvim_set_hl(0, "Type", { fg = "NvimLightBlue" })

-- ====== COMPLETION ======
local methods = vim.lsp.protocol.Methods
local function enable_completion(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if client and client.supports_method(methods.textDocument_completion) then
    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
  end
end
vim.api.nvim_create_autocmd("LspAttach", { callback = enable_completion })

local function show_document(args)
  local clients = vim.lsp.get_clients({ bufnr = args.buf, methods.completionItem_resolve })
  if vim.tbl_isempty(clients) then
    return
  end
  local item = vim.tbl_get(vim.v.completed_item, "user_data", "nvim", "lsp", "completion_item") or {}
  local resolved_item = clients[1].request_sync(methods.completionItem_resolve, item, 500, args.buf) or {}
  local docs = vim.tbl_get(resolved_item, "result", "documentation", "value") or ""
  local win = vim.api.nvim__complete_set(vim.fn.complete_info().selected, { info = docs })
  if win.winid and vim.api.nvim_win_is_valid(win.winid) then
    vim.treesitter.start(win.bufnr, "markdown")
    vim.wo[win.winid].conceallevel = 2
  end
end
vim.api.nvim_create_autocmd("CompleteChanged", { callback = show_document })

-- ====== STATUSLINE ======
vim.api.nvim_create_autocmd({ "LspAttach", "BufWritePost" }, {
  callback = function(_)
    local head, status = vim.b.gitsigns_head or "NULL", vim.b.gitsigns_status or "No Diff"
    local lsp = "LSP:" .. #vim.lsp.get_clients({ bufnr = 0 })
    local diag_counts = vim.diagnostic.count(0)
    local diag = ("E:%d W:%d"):format(diag_counts[1] or 0, diag_counts[2] or 0)
    vim.opt.statusline = table.concat({" %f%h%w%m%r", head, status, "%=", lsp, diag, "%P "}, " │ ")
  end,
})

-- ====== CLIPBOARD ======
local function paste(_)
  return function(_)
    return vim.split(vim.fn.getreg('"'), "\n")
  end
end

if os.getenv("SSH_CLIENT") ~= nil or os.getenv("SSH_TTY") ~= nil then
  local osc52 = require("vim.ui.clipboard.osc52")
  vim.g.clipboard = {
    name = "OSC 52",
    copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
    paste = { ["+"] = paste("+"), ["*"] = paste("*") },
  }
end

-- ====== KEYMAP ======
vim.keymap.set("i", "jk", "<ESC>", { desc = "Return to Normal Mode" })
vim.keymap.set("i", "<C-j>", vim.lsp.completion.trigger, { desc = "Trigger Completion" })

-- ====== PLUGIN ======
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyrepo = "https://github.com/folke/lazy.nvim.git"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)
local servers = {"bashls", "biome", "jsonls", "lua_ls", "pyright", "ruff", "rust_analyzer", "yamlls" }

require("lazy").setup({
  { "github/copilot.vim", event = "BufRead" },
  {
    "folke/flash.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, "<cmd>lua require('flash').jump()<cr>" },
      { "S", mode = { "n", "x", "o" }, "<cmd>lua require('flash').treesitter()<cr>" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    keys = { { "<leader>d", "<cmd>lua require('gitsigns').diffthis()<cr>" } },
    config = function()
      require("gitsigns").setup({})
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    config = function()
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
  { "nvim-tree/nvim-tree.lua",
    keys = { { "<leader>n", "<cmd>NvimTreeToggle<cr>" } },
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>f", "<cmd>Telescope find_files<cr>" },
      { "<leader>/", "<cmd>Telescope live_grep<cr>" },
    },
  },
})
