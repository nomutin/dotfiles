-- Minimalist neovim configuration by @nomutin

-- ====== OPTIONS ======
vim.loader.enable()
vim.g.mapleader = " "
vim.opt.title = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menu", "menuone", "noselect", "popup" }
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
vim.opt.path = "**"
vim.opt.diffopt:append("vertical,context:999999")
vim.api.nvim_set_hl(0, "Type", { fg = "NvimLightBlue" })

-- ====== NETRW ======
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.showhide = 1
vim.g.netrw_altv = 1
vim.g.netrw_winsize = -28
vim.g.netrw_keepdir = 1

-- ====== GIT DIFF ======
function ShowGitDiff()
  local diff_file = vim.fn.expand("%:h") .. "/__" .. vim.fn.expand("%:t")
  vim.cmd(string.format("silent !git show HEAD:%s > %s", vim.fn.expand("%"), diff_file))
  vim.cmd(string.format("vertical diffsplit %s", diff_file))
  vim.cmd(string.format("autocmd BufWinLeave <buffer> silent! !rm %s", diff_file))
end

-- ====== STATUSLINE ======
local function show_info(tbl)
  local result = {}
  for key, value in pairs(tbl) do
    table.insert(result, key .. value)
  end
  return #result > 0 and " [" .. table.concat(result, " ") .. "]" or ""
end

local function git_status()
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null")
  local diff = vim.fn.system("git diff --numstat " .. vim.fn.expand("%") .. " 2>/dev/null")
  local added, deleted = diff:match("(%d+)%s+(%d+)%s+")
  return branch == "" and "NULL" or branch .. show_info({ ["+"] = added, ["-"] = deleted })
end

local function lsp_status()
  local clients = {}
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    table.insert(clients, client.name)
  end
  local diag = vim.diagnostic.count(0)
  local count = { ["E:"] = diag[1], ["W:"] = diag[2], ["I:"] = diag[3], ["H:"] = diag[4] }
  return #clients > 0 and table.concat(clients, ", ") .. show_info(count) or "NULL"
end

local function update_statusline()
  local line = table.concat({ " %f%h%w%m%r", git_status(), "%=", lsp_status(), "%l:%c", "%P " }, " │ ")
  vim.opt.statusline = line
end
vim.api.nvim_create_autocmd({ "VimEnter", "BufWritePost" }, { callback = update_statusline })

-- ====== KEYMAP ======
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("n", "<leader>n", "<cmd>Lexplore<cr>")
vim.keymap.set("n", "<leader>d", ShowGitDiff)

-- ====== PLUGIN ======
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyrepo = "https://github.com/folke/lazy.nvim.git"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)
local servers = { "bashls", "biome", "jsonls", "lua_ls", "pyright", "ruff", "rust_analyzer", "yamlls" }

require("lazy").setup({
  defaults = { lazy = true },
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
    dependencies = { "hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      for _, server in ipairs(servers) do
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("lspconfig")[server].setup({ capabilities = capabilities })
      end
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
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>f", "<cmd>Telescope find_files<cr>" },
      { "<leader>/", "<cmd>Telescope live_grep<cr>" },
    },
  },
})
