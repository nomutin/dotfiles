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
vim.opt.showtabline, vim.opt.laststatus = 2, 3
vim.opt.smartindent, vim.opt.expandtab = true, true
vim.opt.undofile = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.wrap = false
vim.opt.list = true
vim.api.nvim_set_hl(0, "Type", { fg = "NvimLightBlue" })

-- ====== GIT DIFF ======
local function show_git_diff(_)
  local diff_file = vim.fn.expand("%:h") .. "/__" .. vim.fn.expand("%:t")
  vim.fn.system("git show HEAD:" .. vim.fn.expand("%") .. " > " .. diff_file)
  vim.cmd("vertical diffsplit " .. diff_file)
  vim.cmd("autocmd BufWinLeave <buffer> silent! !rm " .. diff_file)
end

-- ====== COMPLETION ======
local methods = vim.lsp.protocol.Methods
local function enable_completion(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if client and client.supports_method(methods.textDocument_completion) then
    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
  end
end

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

-- ====== STATUSLINE ======
local function show_info(tbl)
  local result = {}
  for key, value in pairs(tbl) do
    table.insert(result, key .. value)
  end
  return #result > 0 and " [" .. table.concat(result, " ") .. "]" or ""
end

local function git_status(_)
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null")
  local diff = vim.fn.system("git diff --numstat " .. vim.fn.expand("%"))
  local added, deleted = diff:match("(%d+)%s+(%d+)%s+")
  return branch == "" and "NULL" or branch .. show_info({ ["+"] = added, ["-"] = deleted })
end

local function lsp_status(_)
  local clients = {}
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    table.insert(clients, client.name)
  end
  local diag = vim.diagnostic.count(0)
  local count = { ["E:"] = diag[1], ["W:"] = diag[2], ["I:"] = diag[3], ["H:"] = diag[4] }
  return #clients > 0 and table.concat(clients, ", ") .. show_info(count) or "NULL"
end

local function update_statusline(_)
  vim.opt.statusline = " %f%h%w%m%r │ " .. git_status() .. " │ %= │ " .. lsp_status() .. " │ %l:%c │ %P "
end

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

-- ====== AUTOCMD ======
vim.api.nvim_create_autocmd("LspAttach", { callback = enable_completion })
vim.api.nvim_create_autocmd("CompleteChanged", { callback = show_document })
vim.api.nvim_create_autocmd({ "VimEnter", "LspAttach", "BufWritePost" }, { callback = update_statusline })

-- ====== KEYMAP ======
vim.keymap.set("i", "jk", "<ESC>", { desc = "Return to Normal Mode" })
vim.keymap.set("n", "<leader>d", show_git_diff, { desc = "Show Git Diff" })
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
