-- Set leader to SPACE
vim.g.mapleader = ' '

-- toggle on / focus on explorer (<LEADER>e)
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeFocus<cr>', { noremap = true, silent = true })
-- close explorer (<LEADER>x)
vim.api.nvim_set_keymap('n', '<leader>x', ':NvimTreeToggle<cr>', { noremap = true, silent = true })
-- fuzzy find (<LEADER>ff)
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files<cr>', { noremap = true, silent = true })