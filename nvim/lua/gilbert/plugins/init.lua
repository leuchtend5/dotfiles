return {
	"nvim-lua/plenary.nvim", -- lua functions that many plugins use
	"christoomey/vim-tmux-navigator", -- tmux & split window navigation
	vim.filetype.add({
		extension = {
			["http"] = "http",
		},
	}),

	vim.api.nvim_create_autocmd("FileType", {
		pattern = "markdown",
		callback = function()
			vim.opt.shiftwidth = 2
			vim.opt.tabstop = 2
			vim.opt.softtabstop = 2
		end,
	}),
}
