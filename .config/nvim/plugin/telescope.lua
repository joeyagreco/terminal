local actions = require("telescope.actions")
local telescope = require("telescope")
local previewers = require("telescope.previewers")

local handle_large_files = function(filepath, bufnr, opts)
	-- size limit for previews (MB)
	local max_file_size_mb = 1
	local max_size = max_file_size_mb * 1024 * 1024
	vim.loop.fs_stat(filepath, function(_, stat)
		if not stat then
			return
		end
		if stat.size > max_size then
			-- skip showing preview
			return
		else
			previewers.buffer_previewer_maker(filepath, bufnr, opts)
		end
	end)
end

telescope.setup({
	defaults = {
		-- don't show preview for large files
		buffer_previewer_maker = handle_large_files,
		path_display = { "smart" },
		file_ignore_patterns = {
			"build/",
			"dist/",
			"node_modules/",
			".git/",
		},
		hidden = true,
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--ignore-case",
			"--fixed-strings",
			"--hidden", -- Include hidden files
		},
		mappings = {
			i = {
				["<esc>"] = actions.close,
			},
		},
	},
	pickers = {
		find_files = {
			hidden = true,
		},
	},
	extensions = {
		live_grep_args = {},
	},
})

-- this must be last
telescope.load_extension("live_grep_args")
