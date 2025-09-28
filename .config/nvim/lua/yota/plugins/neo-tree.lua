return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false, -- neo-tree will lazily load itself

	opts = function(_, opts)
		-- 既存の設定をマージ
		opts = opts or {}

		-- 自動更新に関するグローバル設定
		opts.enable_git_status = true
		opts.enable_diagnostics = true
		opts.enable_modified_markers = true
		opts.enable_opened_markers = true
		opts.enable_refresh_on_write = true
		opts.git_status_async = true
		opts.use_libuv_file_watcher = true

		-- ファイラーの設定
		opts.filesystem = opts.filesystem or {}

		-- ファイルシステムの自動更新設定
		opts.filesystem.use_libuv_file_watcher = true
		opts.filesystem.follow_current_file = {
			enabled = true, -- 現在のファイルを自動的にフォーカス
			leave_dirs_open = false, -- 自動展開されたディレクトリを閉じる
		}

		-- 隠しファイルを表示する設定
		opts.filesystem.filtered_items = {
			visible = true, -- 隠しファイルを表示する
			hide_dotfiles = false, -- ドットファイルを隠さない
			hide_gitignored = false, -- .gitignoreに記載されているファイルを隠さない
		}

		-- ダッシュボードを維持するための設定
		opts.close_if_last_window = false

		return opts
	end,

	-- neo-tree の起動時設定
	config = function(_, opts)
		require("neo-tree").setup(opts)

		vim.api.nvim_create_autocmd("VimEnter", {
			once = true,
			callback = function()
				-- 1) Neo-Tree を開く（100ms 後）
				vim.defer_fn(function()
					vim.cmd("Neotree show")

					-- 2) さらに 50ms 後にフォーカス移動
					vim.defer_fn(function()
						for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
							local buf = vim.api.nvim_win_get_buf(w)
							if vim.bo[buf].filetype == "neo-tree" then
								vim.api.nvim_set_current_win(w)
								break
							end
						end
					end, 100)
				end, 100)
			end,
		})
	end,
}
