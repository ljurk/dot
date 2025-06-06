vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.relativenumber = true
-- tabs
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Save undo history
vim.opt.undofile = true

-- from chatgpt
-- General Settings
vim.opt.laststatus = 2
vim.opt.termguicolors = true
--vim.cmd 'colorscheme habamax'
vim.opt.shell = "/bin/zsh"
vim.cmd("syntax on")
vim.cmd("filetype plugin on")
vim.opt.number = true
vim.opt.listchars = { eol = "$", tab = ">-", trail = "~", extends = ">", precedes = "<", space = "^" }

vim.opt.mouse = ""
-- Additional Settings
vim.opt.hidden = true
vim.opt.so = 999
vim.cmd("au BufReadPost vagrantfile set syntax=ruby")

require("keybinds")

-- lazy

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

vim.api.nvim_create_user_command("GitKeepFirstCommit", function()
    local start = vim.fn.search("^# This is the commit message #2:", "n")
    local finish = vim.fn.search("^# Please enter", "n")

    if start > 0 and finish > start then
        vim.cmd(string.format("%d,%dd", start - 1, finish - 1))
    end

    -- Remove remaining comment lines
    vim.cmd([[silent! g/^#.*$/d]])
    vim.cmd([[silent! g/^$/d]])
    vim.cmd([[silent! wq]])
end, {})
