-- Minimalist neovim configuration by @nomutin

-- ====== OPTIONS ======
vim.loader.enable()
vim.g.mapleader = " "
vim.opt.title = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "noselect", "popup"}
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

-- ====== KEYMAP ======
vim.keymap.set("i", "jk", "<ESC>", { desc = "Restore from insert mode" })
vim.keymap.set("t", "fd", [[<C-\><C-n>]], { desc = "Restore from terminal mode" })
vim.keymap.set("n", "<leader>n", ":Lexplore<CR>", { desc = "Open Netrw" })

-- ====== NETRW ======
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_showhide = 1
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = -28
vim.g.netrw_keepdir = 1

-- ====== COLORS ======
vim.api.nvim_set_hl(0, "Function", { fg = "NvimLightBlue" })
vim.api.nvim_set_hl(0, "Identifier", { fg = "NvimLightBlue" })
vim.api.nvim_set_hl(0, "Constant", { fg = "NvimLightCyan" })
vim.api.nvim_set_hl(0, "Statement", { fg = "NvimLightBlue", bold = true })
vim.api.nvim_set_hl(0, "Special", { link = "Constant" })
vim.api.nvim_set_hl(0, "@string.documentation", { fg = "NvimLightGreen", bold = true })
vim.api.nvim_set_hl(0, "@variable.parameter", { fg = "NvimLightCyan", italic = true })

-- ====== Git Gutter ======
local function place_signs(name, start, lines, buffer)
  for lnum = start, start + lines - 1 do
    vim.fn.sign_place(0, '', name, buffer, { lnum = lnum })
  end
end

local function put_signs(diff)
  local _, old_lines, new_start, new_lines = unpack(diff)
  local buffer = vim.api.nvim_get_current_buf()
  if old_lines == 0 then
    place_signs('HunkSignAdd', new_start, new_lines, buffer)
  elseif new_lines == 0 then
    place_signs('HunkSignDel', new_start, old_lines, buffer)
  else
    place_signs('HunkSignUpd', new_start, math.min(old_lines, new_lines), buffer)
    place_signs('HunkSignDel', new_start + new_lines, old_lines - new_lines, buffer)
    place_signs('HunkSignAdd', new_start + old_lines, new_lines - old_lines, buffer)
  end
end

local function show_hunk()
  vim.fn.sign_define('HunkSignAdd', { text = '+', texthl = 'DiffAdd' })
  vim.fn.sign_define('HunkSignDel', { text = '-', texthl = "DiffDelete" })
  vim.fn.sign_define('HunkSignUpd', { text = '~', texthl = "DiffChange" })
  local cmd = 'git --no-pager diff -U0 --no-color --no-ext-diff ' .. vim.fn.expand('%')
              .. ' | grep "^@@" '
              .. ' | sed -r "s/[-+]([0-9]+) /\\1,1,/g" '
              .. ' | sed -r "s/^[-@ ]*([0-9]+,[0-9]+)[ ,+]+([0-9]+,[0-9]+)[, ].*/\\1,\\2/"'
  local output = vim.fn.systemlist(cmd)
  for _, line in ipairs(output) do
    put_signs(vim.split(line, ','))
  end
end
vim.api.nvim_create_autocmd( {"BufReadPost", "BufWritePost"}, { callback = show_hunk })

-- ====== COMPLETION ======
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
    local function trigger_completion_and_insert_space()
      vim.lsp.completion.trigger()
      vim.api.nvim_feedkeys(" ", "n", true)
    end
    vim.keymap.set("i", " ", trigger_completion_and_insert_space)
    vim.keymap.set("i", "<C-j>", vim.lsp.completion.trigger )
  end,
})

-- ====== PLUGIN ======
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyrepo = "https://github.com/folke/lazy.nvim.git"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
  defaults = { lazy = true },
  spec = {
    { "github/copilot.vim", event = "BufRead" },
    {
      "folke/flash.nvim",
      keys = {
        { "s", mode = { "n", "x", "o" }, "<cmd>lua require('flash').jump()<cr>" },
        { "S", mode = { "n", "x", "o" }, "<cmd>lua require('flash').treesitter()<cr>" },
      },
    },
    { "nvim-lualine/lualine.nvim", event = "BufRead", opts = {} },
    {
      "nvim-lspconfig",
      event = "BufRead",
      config = function()
        local server_names = {
          "bashls", "biome", "cssls", "dockerls", "html", "jsonls", "luals",
          "marksman", "pyright", "ruff", "rust_analyzer", "taplo", "tsserver", "yamlls",
        }
        for _, server_name in ipairs(server_names) do
          require("lspconfig")[server_name].setup({})
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
        {"<leader>ff", mode = "n", "<cmd>Telescope find_files<cr>" },
        {"<leader>fg", mode = "n", "<cmd>Telescope live_grep<cr>" },
      },
    },
  },
})
