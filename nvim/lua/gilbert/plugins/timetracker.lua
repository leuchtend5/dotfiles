return {
	"ptdewey/pendulum-nvim",
	config = function()
		require("pendulum").setup({
			log_file = vim.fn.expand("$HOME/Documents/nvim_time_tracker.csv"),
			timeout_len = 300, -- 5 minutes
			timer_len = 60, -- 1 minute
			gen_reports = true, -- Enable report generation (requires Go)
			top_n = 10, -- Include top 10 entries in the report
		})
	end,
}
