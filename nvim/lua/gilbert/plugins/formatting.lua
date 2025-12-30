return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				-- markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
				blade = { "blade-formatter" },
				php = { "intelephense" }, -- optional, you can format PHP separately
			},
			-- format_on_save = {
			-- 	lsp_fallback = true,
			-- 	async = false,
			-- 	timeout_ms = 1000,
			-- },
		})

		local format_on_save_enabled = true -- Start with format-on-save enabled

		function ToggleFormatOnSave()
			format_on_save_enabled = not format_on_save_enabled
			require("conform").setup({
				format_on_save = format_on_save_enabled and {
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				} or nil,
			})
			print("Format on save: " .. (format_on_save_enabled and "enabled" or "disabled"))
		end

		vim.keymap.set("n", "<leader>tF", ToggleFormatOnSave, { desc = "Toggle Format-on-Save" })

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
