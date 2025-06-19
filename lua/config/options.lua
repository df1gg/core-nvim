-- lua/config/options.lua


local opt = vim.opt

-- Main
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.termguicolors = true
opt.cursorline = true
opt.showmode = false
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Tabs
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Interface
opt.scrolloff = 8
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 300
