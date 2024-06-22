-- set up packer for plugin management
require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	-- nvim-tree
	use 'nvim-tree/nvim-web-devicons'
	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- optional
		 },
	}
	use { 
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8'
	}
	-- required for telescope (1)
	use 'nvim-lua/plenary.nvim'
	-- required for telescope (2)
	use {
        'nvim-treesitter/nvim-treesitter'
    }
end)

require('nvim-web-devicons').setup()
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive"
  },
  view = {
    width = 50,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})
require('telescope').setup()
require('nvim-treesitter').setup()