-- -- custom theme discussion here: https://github.com/goolord/alpha-nvim/discussions/16
-- -- this specific theme: https://github.com/mohammedbabiker/dotfiles/blob/main/.config/nvim/lua/plugins/alpha.lua
--
-- local alpha = require("alpha")
-- local dashboard = require("alpha.themes.dashboard")
--
-- dashboard.section.header.val = {
-- 	[[                                                                       ]],
-- 	[[                                                                       ]],
-- 	[[                                                                       ]],
-- 	[[                                                                       ]],
-- 	[[                                                                       ]],
-- 	[[                                                                       ]],
-- 	[[                                                                       ]],
-- 	[[                                                                     ]],
-- 	[[       ████ ██████           █████      ██                     ]],
-- 	[[      ███████████             █████                             ]],
-- 	[[      █████████ ███████████████████ ███   ███████████   ]],
-- 	[[     █████████  ███    █████████████ █████ ██████████████   ]],
-- 	[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
-- 	[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
-- 	[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
-- 	-- [[                                                                       ]],
-- 	-- [[                                                                       ]],
-- 	-- [[                                                                       ]],
-- 	-- [[                                                                       ]],
-- 	-- [[                                                                       ]],
-- }
--
-- -- dashboard.section.header.val = {
-- -- 	[[                                                                              ]],
-- -- 	[[                                                                              ]],
-- -- 	[[                                                                              ]],
-- -- 	[[                                                                              ]],
-- -- 	[[                                                                              ]],
-- -- 	[[                                                                              ]],
-- -- 	[[                                                                              ]],
-- -- 	[[░▒▓███████▓▒░░▒▓████████▓▒░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓██████████████▓▒░ ]],
-- -- 	[[░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░]],
-- -- 	[[░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░]],
-- -- 	[[░▒▓█▓▒░░▒▓█▓▒░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░]],
-- -- 	[[░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░]],
-- -- 	[[░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▓█▓▒░ ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░]],
-- -- 	[[░▒▓█▓▒░░▒▓█▓▒░▒▓████████▓▒░▒▓██████▓▒░   ░▒▓██▓▒░  ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░]],
-- -- 	[[                                                                              ]],
-- -- 	[[                                                                              ]],
-- -- 	[[                                                                              ]],
-- -- 	[[                                                                              ]],
-- -- }
--
-- -- menu
-- dashboard.section.buttons.val = {}
-- -- dashboard.section.buttons.val = {
-- -- 	--dashboard.button("n", "   New file", ":ene <BAR> startinsert <CR>"),
-- -- 	dashboard.button("f", "   Find file", ":Telescope find_files<CR>"),
-- -- 	dashboard.button("r", "   Recent", ":Telescope oldfiles<CR>"),
-- -- 	dashboard.button(
-- -- 		"p",
-- -- 		"󰂖   Clean and update plugins",
-- -- 		":lua require('helpers').clean_and_update_plugins()<CR>",
-- -- 		{ silent = true }
-- -- 	),
-- -- 	dashboard.button("q", "   Quit NVIM", ":qa<CR>", { silent = true }),
-- -- }
--
-- -- footer
--
-- local function footer()
-- 	local hour = tonumber(os.date("%H"))
-- 	local greeting
--
-- 	if hour < 4 then
-- 		greeting = "  good night"
-- 	elseif hour < 12 then
-- 		greeting = "󰼰  good morning"
-- 	elseif hour < 17 then
-- 		greeting = "  good afternoon"
-- 	elseif hour < 20 then
-- 		greeting = "󰖝  good evening"
-- 	else
-- 		greeting = "󰖔  good night"
-- 	end
--
-- 	return greeting .. ", joey"
-- end
--
-- dashboard.section.footer.val = footer()
--
-- alpha.setup(dashboard.opts)
--
-- -- Auto-close Alpha buffer when opening a file
-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	pattern = "*",
-- 	callback = function()
-- 		if vim.bo.filetype ~= "alpha" and vim.fn.bufname() ~= "" and #vim.fn.getbufinfo({ buflisted = 1 }) > 1 then
-- 			for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
-- 				if buf.name:match("alpha") then
-- 					vim.cmd("bdelete " .. buf.bufnr)
-- 				end
-- 			end
-- 		end
-- 	end,
-- })
