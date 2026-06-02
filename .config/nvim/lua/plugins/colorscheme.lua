-- アクティブなカラースキームを切り替えるにはここを変更: "tokyonight" or "catppuccin"
local active = "tokyonight"

return {
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		lazy = active ~= "tokyonight",
		config = function()
			require("tokyonight").setup({
				transparent = true,
				styles = {
					sidebars = "transparent",
					floats = "transparent",
				},
			})
			if active == "tokyonight" then
				vim.cmd([[colorscheme tokyonight]])
				vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#7aa2f7", bg = "NONE" })
			end
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = active ~= "catppuccin",
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- latte, frappe, macchiato, mocha
				transparent_background = true,
				integrations = {
					treesitter = true,
					native_lsp = {
						enabled = true,
					},
				},
			})
			if active == "catppuccin" then
				vim.cmd([[colorscheme catppuccin]])
				vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
				vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#89b4fa", bg = "NONE" })
			end
		end,
	},
}
