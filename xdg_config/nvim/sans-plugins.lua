-- ====== OPTIONS ======
vim.loader.enable()
vim.g.mapleader = " "
vim.opt.title = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "noselect" }
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
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("t", "fd", [[<C-\><C-n>]])
vim.keymap.set("n", "<leader>n", ":Lexplore<CR>")
vim.keymap.set("x", "<M-k>", ":move '<-2<CR>gv=gv")
vim.keymap.set("x", "<M-j>", ":move '>+1<CR>gv=gv")
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)

-- ====== COLORS ======
vim.api.nvim_set_hl(0, "Function", { fg = "NvimLightBlue" })
vim.api.nvim_set_hl(0, "Identifier", { fg = "NvimLightBlue" })
vim.api.nvim_set_hl(0, "Constant", { fg = "NvimLightCyan" })
vim.api.nvim_set_hl(0, "Statement", { fg = "NvimLightBlue", bold = true })
vim.api.nvim_set_hl(0, "Special", { link = "Constant" })
vim.api.nvim_set_hl(0, "@string.documentation", { fg = "NvimLightGreen", bold = true })
vim.api.nvim_set_hl(0, "@variable.parameter", { fg = "NvimLightCyan", italic = true })

-- ====== NETRW ======
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_showhide = 1
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_winsize = -28
vim.g.netrw_keepdir = 1

-- ====== LSP ======

-- ====== COMPLETION ======
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.lsp.completion.enable(true, args.data.client_id, args.buf, { autotrigger = true })

    vim.api.nvim_create_autocmd("CompleteChanged", {
      buffer = args.buf,
      callback = function()
        local info = vim.fn.complete_info({ "selected" })
        local completionItem = vim.tbl_get(vim.v.completed_item, "user_data", "nvim", "lsp", "completion_item")
        if nil == completionItem then
          return
        end

        local resolvedItem =
            vim.lsp.buf_request_sync(args.buf, vim.lsp.protocol.Methods.completionItem_resolve, completionItem, 500)
        if nil == resolvedItem then
          return
        end

        local docs = vim.tbl_get(resolvedItem[args.data.client_id], "result", "documentation", "value")
        if nil == docs then
          return
        end

        local winData = vim.api.nvim__complete_set(info["selected"], { info = docs })
        if not winData.winid or not vim.api.nvim_win_is_valid(winData.winid) then
          return
        end

        vim.api.nvim_win_set_config(winData.winid, { border = "rounded" })
        vim.treesitter.start(winData.bufnr, "markdown")
        vim.wo[winData.winid].conceallevel = 3

        vim.api.nvim_create_autocmd({ "TextChangedI" }, {
          buffer = args.buf,
          callback = function()
            vim.lsp.completion.trigger()
          end,
        })
      end,
    })
  end,
})

-- ====== TERMINAL ======


-- ====== STATUS LINE ======
vim.cmd([[
    highlight default link DiagnosticStatusLineError StatusLineNC
    highlight default link DiagnosticStatusLineHint StatusLineNC
    highlight default link DiagnosticStatusLineInfo StatusLineNC
    highlight default link DiagnosticStatusLineWarn StatusLineNC
    highlight default link User1 IncSearch
    highlight default link User2 StatusLine
    highlight default link User3 StatusLineNC
    highlight default link User4 StatusLineNC
    highlight default link User5 StatusLineNC
    highlight default link User6 StatusLineNC
    highlight default link User7 StatusLineNC
    highlight default link User8 StatusLineNC
    highlight default link User9 StatusLineNC
]])

local function branch_name_display()
  local head = vim.b.gitsigns_head --[[@as any]]
  if head == nil or head == "" then
    return ""
  else
    return string.format("  %s ", head)
  end
end

local function lsp_diagnostics()
  local diagnostics = vim.diagnostic.get(0)
  local count = { 0, 0, 0, 0 }
  for _, diagnostic in ipairs(diagnostics) do
    if vim.startswith(vim.diagnostic.get_namespace(diagnostic.namespace).name, "vim.lsp") then
      count[diagnostic.severity] = count[diagnostic.severity] + 1
    end
  end
  local icons = { error = "󰅚", warn = "󰀪", info = "󰋽", hint = "󰌶" }
  local hl = {
    error = "DiagnosticStatusLineError",
    warn = "DiagnosticStatusLineWarn",
    info = "DiagnosticStatusLineInfo",
    hint = "DiagnosticStatusLineHint",
  }
  local info = {
    error = count[vim.diagnostic.severity.ERROR],
    warn = count[vim.diagnostic.severity.WARN],
    info = count[vim.diagnostic.severity.INFO],
    hint = count[vim.diagnostic.severity.HINT],
  }
  local reprs = {}
  for key, value in pairs(info) do
    if value ~= 0 then
      table.insert(reprs, string.format("%%#%s#%s %s", hl[key], icons[key], value))
    end
  end
  local repr = table.concat(reprs, " ")
  return repr == "" and "" or (" " .. repr .. " ")
end

local function lsp_name()
  local clients = {}
  for _, client in ipairs(vim.lsp.get_clients()) do
    if client.attached_buffers[vim.api.nvim_get_current_buf()] then
      table.insert(clients, client.name)
    end
  end
  local icon = #clients == 0 and "" or "⦿ "
  return icon .. table.concat(clients, ", ")
end

function Statusline()
  local pad = function(s)
    return (s == "" or s == nil) and "" or (" " .. s .. " ")
  end
  local fileformat = { dos = "CRLF", unix = "LF", mac = "CR" }
  return table.concat({
    "%1*", "  ", "%2*",
    branch_name_display(),
    "%3*",
    pad(" " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")),
    "%4*",
    lsp_diagnostics(),
    "%=", "%3*",
    pad(lsp_name()),
    "%2*",
    pad(fileformat[vim.bo.fileformat]),
    pad(vim.o.fileencoding:upper()),
    pad(vim.bo.expandtab and string.format("Spaces: %d", vim.bo.tabstop) or "Tab"),
    "%1*", pad("%l:%c"),
  })
end

vim.opt.statusline = "%!v:lua.Statusline()"

-- ====== PLUGIN ======
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lazyrepo = "https://github.com/folke/lazy.nvim.git"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "williamboman/mason.nvim",
    event = "BufRead",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      })
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm direction=float<cr>" },
      { "<leader>tj", "<cmd>ToggleTerm direction=horizontal<cr>" },
    },
    opts = {},
  },
  defaults = { lazy = true },
})
