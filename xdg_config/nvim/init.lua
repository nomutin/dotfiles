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

-- ====== NETRW ======
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.showhide = 1
vim.g.netrw_altv = 1
vim.g.netrw_winsize = -28
vim.g.netrw_keepdir = 1

-- ====== GIT DIFF ======
local function show_git_diff(_)
  local diff_file = vim.fn.expand("%:h") .. "/__" .. vim.fn.expand("%:t")
  vim.fn.system("git show HEAD:" .. vim.fn.expand("%") .. " > " .. diff_file)
  vim.cmd("vertical diffsplit " .. diff_file)
  vim.cmd("autocmd BufWinLeave <buffer> silent! !rm " .. diff_file)
end

-- ====== COMPLETION ======
local methods = vim.lsp.protocol.Methods
local function get_client(bufnr, method)
  local clients = vim.lsp.get_clients({ bufnr = bufnr, method = method })
  return vim.tbl_get(clients, 1)
end

local function lsp_attach(args)
  local client = get_client(args.bufnr, methods.textDocument_completion)
  if client then
    vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
  end
end

local function complete_changed(args)
  local client = get_client(args.buf, methods.completionItem_resolve)
  if not client then
    return
  end
  local item = vim.tbl_get(vim.v.completed_item, "user_data", "nvim", "lsp", "completion_item") or {}
  item = client.request_sync(methods.completionItem_resolve, item, 100, args.buf) or {}
  local docs = vim.tbl_get(item, "result", "documentation", "value") or ""
  local win = vim.api.nvim__complete_set(vim.fn.complete_info().selected, { info = docs })
  if win.winid and vim.api.nvim_win_is_valid(win.winid) then
    vim.treesitter.start(win.bufnr, "markdown")
    vim.wo[win.winid].conceallevel = 3
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

local function update_statusline(_)
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null")
  local diff = vim.fn.system("git diff --numstat " .. vim.fn.expand("%") .. " 2>/dev/null")
  local added, deleted = diff:match("(%d+)%s+(%d+)%s+")
  local git = branch == "" and "NULL" or branch .. show_info({ ["+"] = added, ["-"] = deleted })

  local clients = {}
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    table.insert(clients, client.name)
  end
  local diag = vim.diagnostic.count(0)
  local count = { ["E:"] = diag[1], ["W:"] = diag[2], ["I:"] = diag[3], ["H:"] = diag[4] }
  local lsp = #clients > 0 and table.concat(clients, ", ") .. show_info(count) or "NULL"

  vim.opt.statusline = " %f%h%w%m%r │ " .. git .. " │ %= │ " .. lsp .. " │ %l:%c │ %P "
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
vim.api.nvim_create_autocmd("LspAttach", { callback = lsp_attach })
vim.api.nvim_create_autocmd("CompleteChanged", { callback = complete_changed })
vim.api.nvim_create_autocmd({ "VimEnter", "BufWritePost" }, { callback = update_statusline })

-- ====== KEYMAP ======
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("n", "<leader>n", "<cmd>Lexplore<cr>")
vim.keymap.set("n", "<leader>d", show_git_diff)
vim.keymap.set("i", "<C-j>", vim.lsp.completion.trigger)

-- ====== PLUGIN ======
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyrepo = "https://github.com/folke/lazy.nvim.git"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  defaults = { lazy = true },
  { "github/copilot.vim", event = "BufRead" },
  {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    config = function()
      local servers = { "bashls", "biome", "jsonls", "lua_ls", "pyright", "ruff", "rust_analyzer", "yamlls" }
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
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>f", "<cmd>Telescope find_files<cr>" },
      { "<leader>/", "<cmd>Telescope live_grep<cr>" },
    },
  },
})
