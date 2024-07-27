-- ====== OPTIONS ======
vim.loader.enable()
vim.g.mapleader = " "
vim.opt.title = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "noselect", "popup" }
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

-- ====== Git Gutter ======
local function place_signs(name, start, lines, buffer)
  for lnum = start, start + lines - 1 do
    vim.fn.sign_place(0, "", name, buffer, { lnum = lnum })
  end
end

local function put_signs(diff)
  local _, old_lines, new_start, new_lines = unpack(diff)
  local buffer = vim.api.nvim_get_current_buf()
  if old_lines == 0 then
    place_signs("HunkSignAdd", new_start, new_lines, buffer)
  elseif new_lines == 0 then
    place_signs("HunkSignDel", new_start, old_lines, buffer)
  else
    place_signs("HunkSignUpd", new_start, math.min(old_lines, new_lines), buffer)
    place_signs("HunkSignDel", new_start + new_lines, old_lines - new_lines, buffer)
    place_signs("HunkSignAdd", new_start + old_lines, new_lines - old_lines, buffer)
  end
end

local function show_hunk()
  vim.fn.sign_define("HunkSignAdd", { text = "+", texthl = "DiffAdd" })
  vim.fn.sign_define("HunkSignDel", { text = "-", texthl = "DiffDelete" })
  vim.fn.sign_define("HunkSignUpd", { text = "~", texthl = "DiffChange" })
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

-- ====== COMPLETION ======
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
    local function trigger_completion_and_insert_space()
      vim.lsp.completion.trigger()
      vim.api.nvim_feedkeys(" ", "n", true)
    end
    vim.keymap.set("i", " ", trigger_completion_and_insert_space)
    vim.keymap.set("i", "<C-j>", vim.lsp.completion.trigger)
  end,
})

-- ====== LSP ======
local servers = {
  lua_ls = {
    name = "lua-language-server",
    cmd = { "lua-language-server" },
    root_dir = vim.fs.root(0, { ".luarc.json", ".luacheckrc", ".stylua.toml", "stylua.toml", ".git" }),
    filetypes = { "lua" },
  },
  pyright = {
    name = "pyright",
    cmd = { "pyright-langserver", "--stdio" },
    root_dir = vim.fs.root(0, { "pyproject.toml", "setup.py", ".git" }),
    filetypes = { "python" },
  },
}
for name, config in pairs(servers) do
  if vim.fn.executable(servers[name].cmd[1]) ~= 0 then
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("UserLspStart", { clear = true }),
      pattern = config.filetypes,
      callback = function(ev)
        vim.lsp.start(servers[name], { bufnr = ev.buf })
      end,
    })
  end
end

-- ====== STATUSLINE ======
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
    "%1*",
    "  ",
    "%2*",
    branch_name_display(),
    "%3*",
    pad(" " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")),
    "%4*",
    lsp_diagnostics(),
    "%=",
    "%3*",
    pad(lsp_name()),
    "%2*",
    pad(fileformat[vim.bo.fileformat]),
    pad(vim.o.fileencoding:upper()),
    pad(vim.bo.expandtab and string.format("Spaces: %d", vim.bo.tabstop) or "Tab"),
    "%1*",
    pad("%l:%c"),
  })
end

vim.opt.statusline = "%!v:lua.Statusline()"
