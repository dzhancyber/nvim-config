return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		-- 1. Run the Neo-tree setup with custom, non-square icons
		require("neo-tree").setup({
			default_component_configs = {
				git_status = {
					symbols = {
						-- Clean icons with NO squares, eliminating "broken box" confusion
						added = " ", -- Plus icon
						modified = "", -- Clean dot (shows when file has changes)
						deleted = " ", -- Cross icon
						renamed = " ", -- Rename arrow
						untracked = " ", -- Question mark (for untracked files)
						ignored = " ", -- Ignored line
						unstaged = " ", -- Pencil icon (Changes are not staged yet - NO MORE BOX!)
						staged = " ", -- Double checkmark (Changes are staged)
						conflict = " ", -- Fork/conflict icon
					},
				},
				diagnostics = {
					symbols = {
						hint = " ",
						info = " ",
						warn = " ",
						error = " ",
					},
				},
			},
		})

		-- 2. Set your custom keymap right here
		vim.keymap.set("n", "<leader>n", ":Neotree filesystem reveal right<CR>", { desc = "Toggle Neo-tree on Right" })
	end,
}
