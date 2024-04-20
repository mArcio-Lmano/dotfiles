return { -- Harpoon
	"ThePrimeagen/harpoon",
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = true,
	keys = {
		{
			"<leader>ha",
			function()
				require("harpoon.mark").add_file()
			end,
			desc = "[H]arpoon: [A]dd file",
		},
		{
			"<leader>hm",
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			desc = "[H]arpoon: Show [m]arks",
		},
		{
			"<leader>hq",
			function()
				require("harpoon.ui").nav_file(1)
			end,
			desc = "[H]arpoon: Go to file 1 [Q]",
		},
		{
			"<leader>hw",
			function()
				require("harpoon.ui").nav_file(2)
			end,
			desc = "[H]arpoon: Go to file 2 [W]",
		},
		{
			"<leader>he",
			function()
				require("harpoon.ui").nav_file(3)
			end,
			desc = "[H]arpoon: Go to file 3 [E]",
		},
		{
			"<leader>hr",
			function()
				require("harpoon.ui").nav_file(4)
			end,
			desc = "[H]arpoon: Go to file 4 [R]",
		},
	},
}
