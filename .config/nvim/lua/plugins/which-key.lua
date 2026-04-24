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
			{ "<leader>b", group = "Buffer" },
			{ "<leader>c", group = "Code Action" },
			{ "<leader>d", group = "Diagnostics" },
			{ "<leader>f", group = "Fuzzy Find" },
			{ "<leader>g", group = "Tmux Navigator" },
			{ "<leader>h", group = "Git Hunk" },
			{ "<leader>l", group = "LazyGit" },
			{ "<leader>n", group = "Neotree" },
			{ "<leader>r", group = "Rename / Restart" },
			{ "<leader>s", group = "Split Window" },
			{ "<leader>t", group = "Tab" },
			{ "<leader>x", group = "Trouble" },
		})
	end,
}
