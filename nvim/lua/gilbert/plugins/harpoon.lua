return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup()

		-- local conf = require("telescope.config").values
		-- local function toggle_telescope(harpoon_files)
		-- 	local file_paths = {}
		-- 	for _, item in ipairs(harpoon_files.items) do
		-- 		table.insert(file_paths, item.value)
		-- 	end
		--
		-- 	require("telescope.pickers")
		-- 		.new({}, {
		-- 			prompt_title = "Harpoon",
		-- 			finder = require("telescope.finders").new_table({
		-- 				results = file_paths,
		-- 			}),
		-- 			previewer = conf.file_previewer({}),
		-- 			sorter = conf.generic_sorter({}),
		-- 		})
		-- 		:find()
		-- end

		-- vim.keymap.set("n", "<leader>ha", function()
		-- 	toggle_telescope(harpoon:list())
		-- end, { desc = "Open harpoon telescope" })

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end, { desc = "Add list", noremap = true, silent = true })

		vim.keymap.set("n", "<leader>1", function()
			harpoon:list():select(1)
		end, { desc = "Select list 1", noremap = true, silent = true })

		vim.keymap.set("n", "<leader>2", function()
			harpoon:list():select(2)
		end, { desc = "Select list 2", noremap = true, silent = true })

		vim.keymap.set("n", "<leader>3", function()
			harpoon:list():select(3)
		end, { desc = "Select list 3", noremap = true, silent = true })

		vim.keymap.set("n", "<leader>4", function()
			harpoon:list():select(4)
		end, { desc = "Select list 4", noremap = true, silent = true })

		vim.keymap.set("n", "<leader>5", function()
			harpoon:list():select(5)
		end, { desc = "Select list 5", noremap = true, silent = true })

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<D-h>", function()
			harpoon:list():prev()
		end, { desc = "Previous list" })
		vim.keymap.set("n", "<D-l>", function()
			harpoon:list():next()
		end, { desc = "Next list" })

		vim.keymap.set("n", "<leader>ha", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Open harpoon window" })
	end,
}
