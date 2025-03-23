return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local colors = {
			blue = "#8ba4b0",
			green = "#87a987",
			violet = "#a292a3",
			yellow = "#c4b28a",
			red = "#c4746e",
			fg = "#949fb5",
			grey = "#414658",
			inactive_bg = "#2c3043",
		}

		local my_lualine_theme = {
			normal = {
				a = { bg = colors.blue, fg = "#000000" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			insert = {
				a = { bg = colors.green, fg = "#000000" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			visual = {
				a = { bg = colors.violet, fg = "#000000" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			command = {
				a = { bg = colors.yellow, fg = "#000000" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			replace = {
				a = { bg = colors.red, fg = "#000000" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
			},
			inactive = {
				a = { bg = colors.inactive_bg, fg = colors.semilightgray },
				b = { bg = colors.inactive_bg, fg = colors.semilightgray },
				c = { bg = colors.inactive_bg, fg = colors.semilightgray },
			},
		}

		-- configure lualine with modified theme
		lualine.setup({
			options = {
				theme = my_lualine_theme,
				section_separators = { left = "", right = "" },
				component_separators = { left = "" },
			},
			sections = {
				lualine_a = {
					"mode",
				},
				lualine_b = {
					{
						"branch",
						color = function()
							local mode = vim.fn.mode() -- get the current mode
							local mode_color_map = {
								n = colors.blue, -- normal mode
								i = colors.green, -- insert mode
								v = colors.violet, -- visual mode
								V = colors.violet, -- visual line mode
								["\22"] = colors.violet, -- visual block mode
								c = colors.yellow, -- command mode
								r = colors.red, -- replace mode
								R = colors.red, -- replace mode
							}
							return { fg = mode_color_map[mode] or colors.blue, bg = colors.grey }
						end,
						separator = { left = "", right = "" },
					},
					{
						"diff",
						color = function()
							local mode = vim.fn.mode() -- get the current mode
							local mode_color_map = {
								n = colors.blue, -- normal mode
								i = colors.green, -- insert mode
								v = colors.violet, -- visual mode
								V = colors.violet, -- visual line mode
								["\22"] = colors.violet, -- visual block mode
								c = colors.yellow, -- command mode
								r = colors.red, -- replace mode
								R = colors.red, -- replace mode
							}
							return { fg = mode_color_map[mode] or colors.blue, bg = colors.grey }
						end,
						separator = { left = "", right = "" },
					},
					{
						"diagnostics",
						color = function()
							local mode = vim.fn.mode() -- get the current mode
							local mode_color_map = {
								n = colors.blue, -- normal mode
								i = colors.green, -- insert mode
								v = colors.violet, -- visual mode
								V = colors.violet, -- visual line mode
								["\22"] = colors.violet, -- visual block mode
								c = colors.yellow, -- command mode
								r = colors.red, -- replace mode
								R = colors.red, -- replace mode
							}
							return { fg = mode_color_map[mode] or colors.blue, bg = colors.grey }
						end,
						separator = { left = "", right = "" },
					},
				},
				lualine_c = {
					{
						"filename",
						-- color = function()
						-- 	local mode = vim.fn.mode() -- get the current mode
						-- 	local mode_color_map = {
						-- 		n = colors.blue, -- normal mode
						-- 		i = colors.green, -- insert mode
						-- 		v = colors.violet, -- visual mode
						-- 		V = colors.violet, -- visual line mode
						-- 		["\22"] = colors.violet, -- visual block mode
						-- 		c = colors.yellow, -- command mode
						-- 		r = colors.red, -- replace mode
						-- 		R = colors.red, -- replace mode
						-- 	}
						-- 	return { fg = mode_color_map[mode] or colors.blue, bg = colors.grey }
						-- end,
						color = { fg = "#7dc4e4" },
						-- fmt = function(str)
						-- 	local parts = vim.split(str, "/", { plain = true })
						-- 	local len = #parts
						-- 	-- Return last 3 parts: 2 parents + filename
						-- 	if len > 2 then
						-- 		return table.concat(parts, "/", len - 2, len)
						-- 	end
						-- 	return str -- Return full path if it’s already short
						-- end,
					},
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					-- { "encoding" },
					{
						"fileformat",
						symbols = {
							unix = "", -- e712
						},
					},
					{ "filetype" },
				},
				lualine_y = {},
				lualine_z = {},
			},
		})
	end,
}
