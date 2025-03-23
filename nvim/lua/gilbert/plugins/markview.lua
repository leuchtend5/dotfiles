return {
	"oxy2dev/markview.nvim",
	lazy = false, -- recommended
	-- ft = "markdown" -- if you decide to lazy-load anyway

	commit = "4d549f68b5d6d4edc2447bbbd0b650d5c8039942",
	dependencies = {
		-- You will not need this if you installed the
		-- parsers manually
		-- Or if the parsers are in your $RUNTIMEPATH
		"nvim-treesitter/nvim-treesitter",
		{ "echasnovski/mini.nvim", version = "*" },
		{ "nvim-tree/nvim-web-devicons", opt = {} },
	},
	config = function()
		local markview = require("markview")
		local presets = require("markview.presets").headings
		--
		markview.setup({
			-- preview = {
			-- 	icon_provider = "mini",
			-- },
			markdown = {
				enable = true,
				block_quotes = {
					enable = true,
					wrap = true,
					["^NOTE$"] = {},
					default = {
						border = "▋",
						hl = "MarkviewBlockQuoteDefault",
					},
				},
				code_blocks = {
					enable = true,

					style = "block",

					label_direction = "right",

					border_hl = "MarkviewCode",
					info_hl = "MarkviewCodeInfo",

					min_width = 60,
					pad_amount = 2,
					pad_char = " ",

					sign = true,

					default = {
						block_hl = "MarkviewCode",
						pad_hl = "MarkviewCode",
					},

					["diff"] = {
						block_hl = function(_, line)
							if line:match("^%+") then
								return "MarkviewPalette4"
							elseif line:match("^%-") then
								return "MarkviewPalette1"
							else
								return "MarkviewCode"
							end
						end,
						pad_hl = "MarkviewCode",
					},
				},
				headings = presets.marker,
				horizontal_rules = {},
				list_items = { indent_size = 2 },
				tables = {},
			},
			html = {
				enable = true,
				container_elements = {},
				headings = {},
				void_elements = {},
			},
		})

		vim.keymap.set("n", "<leader>mt", "<cmd>Markview toggle<CR>", { desc = "Toggle Markview" })
		vim.cmd("Markview Enable")
	end,
}
