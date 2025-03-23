return {
	"mistweaverco/kulala.nvim",
	config = function()
		require("kulala").setup({
			-- default_view, body or headers
			default_view = "body",
			-- dev, test, prod, can be anything
			-- see: https://learn.microsoft.com/en-us/aspnet/core/test/http-files?view=aspnetcore-8.0#environment-files
			default_env = "dev",
			-- enable/disable debug mode
			debug = false,
			-- default formatters for different content types
			formatters = {
				json = { "jq", "." },
				xml = { "xmllint", "--format", "-" },
				html = { "xmllint", "--format", "--html", "-" },
			},
			-- default icons
			icons = {
				inlay = {
					loading = "⏳",
					done = "✅",
					error = "❌",
				},
				lualine = "🐼",
			},
			-- additional cURL options
			-- see: https://curl.se/docs/manpage.html
			additional_curl_options = {},
			-- scratchpad default contents
			scratchpad_default_contents = {
				"@MY_TOKEN_NAME=my_token_value",
				"",
				"POST https://httpbin.org/post HTTP/1.1",
				"accept: application/json",
				"content-type: application/json",
				"# @name scratchpad",
				"",
				"{",
				'  "foo": "bar"',
				"}",
			},
			-- enable winbar
			winbar = false,
		})

		vim.api.nvim_set_keymap(
			"n",
			"<leader>kj",
			":lua require('kulala').jump_prev()<CR>",
			{ noremap = true, silent = true, desc = "Jump Prev" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>kk",
			":lua require('kulala').jump_next()<CR>",
			{ noremap = true, silent = true, desc = "Jump Next" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>kr",
			":lua require('kulala').run()<CR>",
			{ noremap = true, silent = true, desc = "Run Kulala" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>kp",
			":lua require('kulala').replay()<CR>",
			{ noremap = true, silent = true, desc = "Replay Test" }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>kt",
			":lua require('kulala').toggle_view()<CR>",
			{ noremap = true, silent = true, desc = "Toggle View" }
		)
	end,
}
