local constants = require("constants")

-- set leader to SPACE
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- enable the live preview of substitution commands in a split window
vim.opt.inccommand = "split"

-- use system clipboard
vim.opt.clipboard = "unnamedplus"

-- fold config
-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

-- disable netrw for nvim-tree
-- :help nvim-tree-netrw
-- https://github.com/nvim-tree/nvim-tree.lua?tab=readme-ov-file#install
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set python to use
vim.g.python3_host_prog = constants.PYTHON_PATH

-- no splash screen on startup
-- vim.opt.shortmess:append("I")

-- enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
vim.opt.breakindent = true

-- decrease updatetime to 250ms
vim.opt.updatetime = 250

-- set completeopt to have a better completion experience
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- enable the sign column to prevent the screen from jumping
vim.opt.signcolumn = "yes"

-- enable syntax highlighting
vim.cmd("syntax on")

-- line padding with H and L
vim.opt.scrolloff = 5

-- show line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- enable 24-bit RGB colors
vim.opt.termguicolors = true

-- always show the sign column
vim.opt.signcolumn = "yes"

-- disable compatibility with vi which can cause unexpected issues.
vim.opt.compatible = false

-- case insensitive search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- makes backspace work
vim.opt.backspace = { "indent", "eol", "start" }

-- enable filetype plugin and indent
vim.cmd("filetype plugin indent on")

-- highlight cursor line underneath the cursor horizontally.
vim.opt.cursorline = true

-- incremental search
vim.opt.incsearch = true

-- highlight matching parentheses/brackets/etc.
vim.opt.showmatch = true

-- persist undos even after closing file
vim.opt.undofile = true

-- do not wrap lines
vim.opt.wrap = false

-- show partial command in the last line of the screen
vim.opt.showcmd = true

-- set the commands to save in history, default number is 20.
vim.opt.history = 1000

-- ignore specific file types in wildmenu
vim.opt.wildignore = "*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx"

-- number of spaces per tab
vim.opt.softtabstop = 4

-- enable smart tab and indent
vim.opt.smarttab = true
vim.opt.smartindent = true

-- -- literal (not regex) searches
-- vim.opt.magic = false

-- disable perl
vim.g.loaded_perl_provider = 0
-- disable ruby
vim.g.loaded_ruby_provider = 0

-- stop things like Lazy from formatting
vim.g.autoformat = false
