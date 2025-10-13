return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,

	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		icons = {
			-- group = "",
		},
	},

	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.add({
			{ "<leader>b", group = "2 Bufferline" },
			{ "<leader>f", group = "5 Fuzzy Find" },
			{ "<leader>g", group = "6 Tmux-Navigator" },
			{ "<leader>h", group = "10 Hunk" },
			{ "<leader>n", group = "4 Neotree" },
			{ "<leader>s", group = "5 Split Window" },
			{ "<leader>t", group = "5 Tab" },
			{ "<leader>w", group = "2 Auto-session" },
			{ "<leader>x", group = "5 Trouble" },
		})
	end,
}
