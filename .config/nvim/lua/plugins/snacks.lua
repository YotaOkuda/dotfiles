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
		explorer = { enabled = true },
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
						local modified = buf
							and vim.api.nvim_buf_is_valid(buf)
							and vim.bo[buf].modified
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
	},
	keys = {
		{ "<leader>ff", function() Snacks.picker.files() end, desc = "Fuzzy find files in cwd" },
		{ "<leader>fr", function() Snacks.picker.recent() end, desc = "Fuzzy find recent files" },
		{ "<leader>fs", function() Snacks.picker.grep() end, desc = "Find string in cwd" },
		{ "<leader>fc", function() Snacks.picker.grep_word() end, desc = "Find string under cursor in cwd" },
		{ "<leader>fb", function() Snacks.picker.buffers() end, desc = "Find open buffers" },
		{ "<leader>ft", function() Snacks.picker.todo_comments() end, desc = "Find todos" },
	},
}
