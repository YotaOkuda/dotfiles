return {
	"christoomey/vim-tmux-navigator",
	lazy = false, -- 起動時ロード
	init = function()
		-- デフォルトマッピングを無効化
		vim.g.tmux_navigator_no_mappings = 1
	end,
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
		"TmuxNavigatorProcessList",
	},
	keys = {
		-- Leader + hjkl で tmux-navigator ペイン移動
		{ "<leader>gh", "<cmd>TmuxNavigateLeft<CR>", desc = "Navigate Left Pane" },
		{ "<leader>gj", "<cmd>TmuxNavigateDown<CR>", desc = "Navigate Down Pane" },
		{ "<leader>gk", "<cmd>TmuxNavigateUp<CR>", desc = "Navigate Up Pane" },
		{ "<leader>gl", "<cmd>TmuxNavigateRight<CR>", desc = "Navigate Right Pane" },
		{ "<leader>gp", "<cmd>TmuxNavigatePrevious<CR>", desc = "Navigate Previous Pane" },
	},
}
