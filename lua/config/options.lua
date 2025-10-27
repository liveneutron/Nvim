-- basic settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.syntax = on
vim.o.showcmd = true
vim.o.wrap = true
vim.o.cursorline = false
vim.o.scrolloff = 10
vim.o.sidescroll = 8

-- indentation settings
vim.o.softtabstop = 4
vim.o.smartindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

--search settings
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true

-- visual settings
vim.o.termguicolors = true
vim.o.showtabline = 1
vim.o.showmode = false
vim.cmd("colorscheme retrobox")

-- file handling
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.autoread = true
vim.o.autowrite = false

-- cursor setting
vim.opt.guicursor = "n-v-c:block,i-ci-ve:block"

