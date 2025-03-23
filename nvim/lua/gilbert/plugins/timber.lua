return {
	"Goose97/timber.nvim",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
		require("timber").setup({
			-- Configuration here, or leave empty to use defaults
			log_templates = {
				default = {
					lua = [[print("%watcher_marker_start" .. %log_target .. "%watcher_marker_end")]],
				},
			},
			log_watcher = {
				enabled = true,
				-- A table of source id and source configuration
				sources = {
					log_file = {
						type = "filesystem",
						name = "Log file",
						path = "/tmp/debug.log",
					},
					neotest = {
						-- Test runner
						type = "neotest",
						name = "Neotest",
					},
				},
			},
		})

		vim.keymap.set("n", "gll", function()
			return require("timber.actions").insert_log({ position = "below", operator = true }) .. "_"
		end, {
			desc = "[G]o [L]og: Insert below log statements the current line",
			expr = true,
		})
	end,
}
