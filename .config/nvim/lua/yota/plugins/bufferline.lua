return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",

	-- Neovim のキーで左右移動
	vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", { silent = true }),
	vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", { silent = true }),
	vim.keymap.set("n", "<leader>bl", ":BufferLineMoveNext<CR>", { silent = true, desc = "Move to next buffer" }),
	vim.keymap.set("n", "<leader>bh", ":BufferLineMovePrev<CR>", { silent = true, desc = "Move to previous buffer" }),
	vim.keymap.set("n", "<leader>bw", ":bdelete<CR>", { silent = true, desc = "Close current buffer" }),

	opts = {
		options = {
			mode = "buffers",
			always_show_bufferline = true,
			color_icons = true,
			indicator = {
				style = "underline", -- ← 選択中のバッファを下線で強調
			},
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level, _, _)
				local icon = level:match("error") and ""
					or level:match("warn") and ""
					or level:match("hint") and "󰠠"
					or level:match("info") and ""
				return " " .. icon .. " " .. count
			end,
			offsets = {
				{
					filetype = "neo-tree",
					text = " NeoTree",
					highlight = "Directory",
					separator = true,
					text_align = "center",
				},
			},
		},
	},
}
