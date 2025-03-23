return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-jest",
		"marilari88/neotest-vitest",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-jest")({
					jestCommand = "npm test --",
					jestConfigFile = "custom.jest.config.ts",
					env = { CI = true },
					cwd = function(path)
						return vim.fn.getcwd()
					end,
				}),
				require("neotest-vitest"),
			},
		})
	end,

	vim.api.nvim_set_keymap(
		"n",
		"<leader>tr",
		"<cmd>lua require('neotest').run.run()<CR>",
		{ noremap = true, silent = true, desc = "Run nearest test" }
	),
	vim.api.nvim_set_keymap(
		"n",
		"<leader>tt",
		"<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
		{ noremap = true, silent = true, desc = "Run current file" }
	),
	vim.api.nvim_set_keymap(
		"n",
		"<leader>tT",
		"<cmd>lua require('neotest').run.run(vim.uv.cwd())<CR>",
		{ noremap = true, silent = true, desc = "Run all test files" }
	),
	vim.api.nvim_set_keymap(
		"n",
		"<leader>ts",
		"<cmd>lua require('neotest').summary.toggle()<CR>",
		{ noremap = true, silent = true, desc = "Toggle Summary" }
	),
	vim.api.nvim_set_keymap(
		"n",
		"<leader>tl",
		"<cmd>lua require('neotest').output_panel.toggle()<CR>",
		{ noremap = true, silent = true, desc = "Toggle output panel" }
	),
	vim.api.nvim_set_keymap(
		"n",
		"<leader>tS",
		"<cmd>lua require('neotest').run.stop()<CR>",
		{ noremap = true, silent = true, desc = "Stop" }
	),
	vim.api.nvim_set_keymap(
		"n",
		"<leader>tw",
		"<cmd>lua require('neotest').watch.toggle(vim.fn.expand('%'))<CR>",
		{ noremap = true, silent = true, desc = "Toggle Watch" }
	),
}
