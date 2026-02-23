return {
	{
		"folke/tokyonight.nvim",
		priority = 1000,
		config = function()
			-- カスタムカラーの定義（変更なし）
			-- local bg = "#011628"
			-- local bg_dark = "#011423"
			-- local bg_highlight = "#143652"
			-- local bg_search = "#0A64AC"
			-- local bg_visual = "#275378"
			-- local fg = "#CBE0F0"
			-- local fg_dark = "#B4D0E9"
			-- local fg_gutter = "#627E97"
			-- local border = "#547998"

			require("tokyonight").setup({
				transparent = true,
				styles = {
					sidebars = "transparent",
					floats = "transparent",
				},
				on_colors = function(colors)
					-- --- 既存の透過設定 ---
					-- colors.bg = bg
					-- colors.bg_dark = bg_dark

					-- Popups/Sidebars を透過 (nilで背景色を設定しない)
					-- colors.bg_float = nil
					-- colors.bg_popup = nil
					-- colors.bg_sidebar = nil

					-- --- LSP/その他の透過設定の追加 ⭐ NEW ⭐ ---

					-- LSPポップアップの一般的な背景を透過させる
					-- colors.NormalFloat = { bg = nil }

					-- Pmenu (補完メニュー) の背景を透過させる（必要であれば）
					-- colors.Pmenu = { bg = nil }

					-- Telescopeの背景を透過させる（nil設定が効かない場合の最終手段）
					-- colors.TelescopeNormal = { bg = nil }

					-- --- その他の設定（変更なし） ---
					-- colors.bg_highlight = bg_highlight
					-- colors.bg_search = bg_search
					-- colors.bg_statusline = bg_dark
					-- colors.bg_visual = bg_visual
					-- colors.border = border
					-- colors.fg = fg
					-- colors.fg_dark = fg_dark
					-- colors.fg_float = fg
					-- colors.fg_gutter = fg_gutter
					-- colors.fg_sidebar = fg_dark
				end,
			})
			vim.cmd([[colorscheme tokyonight]])
			vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#7aa2f7", bg = "NONE" })
		end,
	},
}
