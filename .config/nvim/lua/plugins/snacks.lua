return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		dashboard = { enabled = true },
		explorer = { enabled = false },
		indent = { enabled = true },
		input = { enabled = true },
		picker = {
			enabled = true,
			sources = {
				files = { hidden = true },
				grep = { hidden = true },
				buffers = {
					format = function(item, picker)
						local ret = {}
						local buf = item.buf
						local modified = buf and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].modified
						if modified then
							ret[#ret + 1] = { "[+] ", "DiagnosticWarn" }
						else
							ret[#ret + 1] = { "    " }
						end
						vim.list_extend(ret, Snacks.picker.format.filename(item, picker))
						return ret
					end,
				},
			},
		},
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		terminal = {
			win = {
				border = "rounded",
				position = "float",
			},
		},
	},
	keys = {
		{
			"<leader>t",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle terminal",
			mode = { "n", "t" },
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Fuzzy find files in cwd",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Fuzzy find recent files",
		},
		{
			"<leader>fs",
			function()
				Snacks.picker.grep()
			end,
			desc = "Find string in cwd",
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Find string under cursor in cwd",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Find open buffers",
		},
		{
			"<leader>go",
			function()
				local line = vim.api.nvim_win_get_cursor(0)[1]
				local file = vim.api.nvim_buf_get_name(0)
				if file == "" then
					Snacks.notify.warn("No file")
					return
				end
				local blame = vim.fn.system(
					string.format("git blame -L %d,%d --porcelain -- %s", line, line, vim.fn.shellescape(file))
				)
				if vim.v.shell_error ~= 0 then
					Snacks.notify.error("git blame failed")
					return
				end
				local hash = blame:match("^([0-9a-f]+)")
				if not hash or hash == string.rep("0", 40) then
					Snacks.notify.warn("Line not committed yet")
					return
				end
				Snacks.gitbrowse({ what = "commit", commit = hash })
			end,
			desc = "Open blame commit in browser",
		},
	},
}
