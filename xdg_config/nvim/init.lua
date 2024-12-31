-- Minimalist neovim configuration by @nomutin

-- ====== OPTIONS ======
vim.loader.enable()
vim.g.mapleader = " "
vim.opt.title = true
vim.opt.termguicolors = true
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

-- ====== NETRW ======
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_showhide = 1
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = -28
vim.g.netrw_keepdir = 1
vim.g.netrw_preview = 1

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

-- ====== LSP ======
vim.lsp.config.bashls = { cmd = { "bash-language-server", "start" }, filetypes = { "sh" } }
vim.lsp.config.biome = {
  cmd = { "biome", "lsp-proxy" },
  filetypes = { "css", "javascript", "javascriptreact", "json", "typescript", "typescript.tsx" },
}
vim.lsp.config.jsonls = { cmd = { "vscode-json-languageserver", "--stdio" }, filetypes = { "json" } }
vim.lsp.config.lua_ls =
  { cmd = { "lua-language-server" }, filetypes = { "lua" }, root_markers = { ".luarc.json", "stylua.toml" } }
vim.lsp.config.pyright = { cmd = { "pyright-langserver", "--stdio" }, filetypes = { "python" } }
vim.lsp.config.ruff = { cmd = { "ruff", "server" }, filetypes = { "python" } }
vim.lsp.config.taplo = { cmd = { "taplo", "lsp", "stdio" }, filetypes = { "toml" } }
vim.lsp.config.yamls = { cmd = { "yaml-language-server", "--stdio" }, filetypes = { "yaml" } }
vim.lsp.enable({ "bashls", "biome", "jsonls", "lua_ls", "pyright", "ruff", "taplo", "yamls" })

-- ====== COMPLETION ======
vim.opt.completeopt = { "menu", "menuone", "noselect", "popup" }
local function lsp_attach(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if not client or not client:supports_method("textDocument/completion") then
    return
  end
  vim.lsp.completion.enable(true, args.data.client_id, args.buf, { autotrigger = true })
  vim.keymap.set("i", "<C-k>", vim.lsp.completion.trigger, { desc = "Trigger LSP" })

  local function complete_changed(_)
    client:request(
      "completionItem/resolve",
      vim.tbl_get(vim.v.completed_item, "user_data", "nvim", "lsp", "completion_item"),
      function(err, result)
        if not err then
          local docs = vim.tbl_get(result, "documentation", "value")
          local win = vim.api.nvim__complete_set(vim.fn.complete_info().selected, { info = docs })
          vim.treesitter.start(win.bufnr, "markdown")
          vim.wo[win.winid].conceallevel = 3
        end
      end
    )
  end
  vim.api.nvim_create_autocmd("CompleteChanged", { callback = complete_changed })
end
vim.api.nvim_create_autocmd("LspAttach", { callback = lsp_attach })

-- ====== MAPPING ======
vim.api.nvim_set_hl(0, "Type", { fg = "NvimLightBlue" })
vim.keymap.set("i", "jk", "<ESC>", { noremap = true, desc = "Return to Normal Mode" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.setloclist, { noremap = true, desc = "Show Diagnostic" })
vim.keymap.set("n", "<leader>n", "<cmd>Lexplore<CR>", { desc = "Open Netrw" })
vim.keymap.set("n", "<leader>d", "<cmd>Gitsigns diffthis<cr>", { noremap = true, desc = "Git Diff" })

-- ====== PLUGIN ======
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyrepo = "https://github.com/folke/lazy.nvim.git"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>f", "<cmd>FzfLua files<cr>", desc = "Find Files" },
      { "<leader>/", "<cmd>FzfLua live_grep_native<cr>", desc = "Search Word" },
    },
  },
  { "lewis6991/gitsigns.nvim", event = "BufRead", opts = {} },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    main = "nvim-treesitter.configs",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = { node_incremental = "<CR>", node_decremental = "<Space>" },
      },
    },
  },
  { "supermaven-inc/supermaven-nvim", event = "InsertEnter", opts = {} },
})
