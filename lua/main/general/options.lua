-- vim option
local o = vim.opt
local home = vim.fn.expand('~')

o.backup = false
o.swapfile = false
o.undofile = true
o.writebackup = false
o.ruler = true
o.number = true
o.relativenumber = true
o.showmode = false
o.mouse = "a"
o.wrap = false
o.background = "dark"
o.splitbelow = true
o.splitright = true
--o.cmdheight = 2
o.swapfile = false
o.cursorline = true
o.smartindent = true
o.autoindent = true
o.shiftwidth = 4
o.tabstop = 4
o.expandtab = true
o.showtabline = 2
--o.scrolloff = 8
o.sidescrolloff = 8
o.encoding = "utf-8"
o.fileencoding = "utf-8"
--o.clipboard = "unnamedplus"
--o.ignorecase = true
o.signcolumn = "yes"
o.guifont = "monospace:h17"
o.termguicolors = true
o.completeopt = { "menu", "menuone", "noselect" }
o.shortmess:append "c"
o.backupdir = home .. "/.nvim/backups"
o.undodir = home .. "/.nvim/undos"

