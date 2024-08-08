-- Minimalist neovim configuration by @nomutin

-- ====== OPTIONS ======
vim.loader.enable()
vim.g.mapleader = " "
vim.opt.title = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menu", "menuone", "noselect", "fuzzy", "popup" }
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
vim.api.nvim_set_hl(0, "Type", { fg = "NvimLightBlue" })

-- ====== NETRW ======
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_browse_split = 4
vim.g.showhide = 1
vim.g.netrw_altv = 1
vim.g.netrw_winsize = -28
vim.g.netrw_keepdir = 1
vim.g.netrw_preview = 1

-- ====== GIT GUTTER ======
vim.fn.sign_define("GAdd", { text = "+", texthl = "DiffAdd" })
vim.fn.sign_define("GDel", { text = "-", texthl = "DiffDelete" })
vim.fn.sign_define("GUpd", { text = "~", texthl = "DiffChange" })

local function put_signs(diff)
  local _, old_lines, new_start, new_lines = unpack(diff)
  local function place_signs(name, start, lines)
    for lnum = start, start + lines - 1 do
      vim.fn.sign_place(0, "gutter", name, vim.api.nvim_get_current_buf(), { lnum = lnum, priority = 1 })
    end
  end
  place_signs("GUpd", new_start, math.min(old_lines, new_lines))
  place_signs("GDel", new_start + new_lines, old_lines - new_lines)
  place_signs("GAdd", new_start + old_lines, new_lines - old_lines)
end

local function show_hunk()
  vim.fn.sign_unplace("gutter")
  local cmd = "git --no-pager diff -U0 --no-color --no-ext-diff "
    .. vim.fn.expand("%")
    .. ' | grep "^@@" '
    .. ' | sed -r "s/[-+]([0-9]+) /\\1,1,/g" '
    .. ' | sed -r "s/^[-@ ]*([0-9]+,[0-9]+)[ ,+]+([0-9]+,[0-9]+)[, ].*/\\1,\\2/"'
  local output = vim.fn.systemlist(cmd)
  for _, line in ipairs(output) do
    put_signs(vim.split(line, ","))
  end
end
vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, { callback = show_hunk })

-- ====== STATUSLINE ======
local function count_signs(sign_name, prefix)
  local signs = vim.fn.sign_getplaced(vim.api.nvim_get_current_buf(), { group = "*" })[1].signs
  local count = vim.tbl_count(vim.tbl_filter(function(sign)
    return sign.name == sign_name
  end, signs))
  return count > 0 and string.format("%s%s", prefix or "", count) or nil
end

local function additional_info(tbl)
  local result = {}
  for key, value in pairs(tbl) do
    if value then
      table.insert(result, string.format("%s%s", key, value))
    end
  end
  return #result > 0 and " [" .. table.concat(result, " ") .. "]" or ""
end

local function lsp_status()
  local clients = {}
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
    table.insert(clients, client.name)
  end
  local diag = vim.diagnostic.count(0)
  local count = { ["E:"] = diag[1], ["W:"] = diag[2], ["I:"] = diag[3], ["H:"] = diag[4] }
  local client_names = #clients > 0 and table.concat(clients, ", ") or "NULL"
  return client_names .. additional_info(count)
end

local function git_status()
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null")
  local hunks = { ["+"] = count_signs("GAdd"), ["-"] = count_signs("GDel"), ["~"] = count_signs("GUpd") }
  return branch == "" and "NULL" or branch .. additional_info(hunks)
end

local function update_statusline()
  local line = table.concat({ " %f%h%w%m%r", git_status(), "%=", lsp_status(), "%l:%c", "%P " }, " │ ")
  vim.opt.statusline = line
end
vim.api.nvim_create_autocmd({ "VimEnter", "BufWritePost" }, { callback = update_statusline })

-- ====== KEYMAP ======
vim.keymap.set("i", "jk", "<ESC>", { desc = "Return to normal mode" })
vim.keymap.set("n", "<leader>n", "<cmd>Lexplore<cr>", { desc = "Open file explorer" })

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
