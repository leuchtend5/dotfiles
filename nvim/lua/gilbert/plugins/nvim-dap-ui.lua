return {
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },

	config = function()
		vim.api.nvim_set_keymap(
			"n",
			"<leader>dt",
			"<cmd>lua require('dapui').toggle()<CR>",
			{ noremap = true, silent = true, desc = "Toggle Dap UI" }
		)
	end,
}
