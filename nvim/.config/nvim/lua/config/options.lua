-- options
--------------------------------------------------------------------------------
-- Relative and absolute line numbers combined
vim.opt.number = true
vim.opt.relativenumber = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Cursorline
vim.opt.cursorline = true

-- Show whitespace characters
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Preview substitutions
vim.opt.inccommand = "split"

-- Text wrapping
vim.opt.wrap = true
vim.opt.breakindent = true

-- Tabstops
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

-- Window splitting
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Save undo history
vim.opt.undofile = true

-- Set the default border for all floating windows
vim.opt.winborder = "rounded"

-- from chatgpt
-- General Settings
vim.opt.laststatus = 2
vim.opt.termguicolors = true
--vim.cmd 'colorscheme habamax'
vim.opt.shell = "/bin/zsh"
vim.cmd("syntax on")
vim.cmd("filetype plugin on")
vim.opt.listchars = { eol = "$", tab = ">-", trail = "~", extends = ">", precedes = "<", space = "^" }

vim.opt.mouse = ""
-- Additional Settings
vim.opt.hidden = true
vim.opt.so = 999
vim.cmd("au BufReadPost vagrantfile set syntax=ruby")
