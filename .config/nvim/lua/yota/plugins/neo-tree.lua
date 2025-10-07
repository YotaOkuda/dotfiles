return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	-- lazy = false, -- neo-tree will lazily load itself

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
		opts.auto_open_after_session_restore = true

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

	config = function(_, opts)
		require("neo-tree").setup(opts)
		-- git更新でneo-treeを自動更新
		vim.api.nvim_create_autocmd({ "BufLeave" }, {
			pattern = { "*lazygit*" },
			group = vim.api.nvim_create_augroup("git_refresh_neotree", { clear = true }),
			callback = function()
				require("neo-tree.sources.filesystem.commands").refresh(
					require("neo-tree.sources.manager").get_state("filesystem")
				)
			end,
		})

		-- neo-treeの自動起動設定
		-- vim.api.nvim_create_autocmd("VimEnter", {
		-- 	command = "Neotree toggle",
		-- })

		-- neotreeの自動起動設定
		-- vim.api.nvim_create_autocmd("VimEnter", {
		-- 	desc = "Open Neotree automatically on startup if no files are opened",
		-- 	once = true, -- 一度実行したら解除
		-- 	callback = function()
		-- 		-- 100msの遅延を設定
		-- 		vim.defer_fn(function()
		-- 			-- if vim.fn.argc() == 0 and not vim.fn.exists("s:std_in") then
		-- 			-- nvim-treeのときのように、vim.cmdを使う方が確実な場合がある
		-- 			vim.cmd("Neotree show")
		-- 			-- end
		-- 		end, 100) -- 100ms後に実行
		-- 	end,
		-- })
		--
		-- neotreeの自動起動設定
		-- vim.api.nvim_create_autocmd("VimEnter", {
		-- 	once = true,
		-- 	callback = function()
		-- 		-- 1) Neo-Tree を開く（100ms 後）
		-- 		vim.defer_fn(function()
		-- 			vim.cmd("Neotree show")
		--
		-- 			-- 2) さらに 50ms 後にフォーカス移動
		-- 			vim.defer_fn(function()
		-- 				for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		-- 					local buf = vim.api.nvim_win_get_buf(w)
		-- 					if vim.bo[buf].filetype == "neo-tree" then
		-- 						vim.api.nvim_set_current_win(w)
		-- 						break
		-- 					end
		-- 				end
		-- 			end, 100)
		-- 		end, 100)
		-- 	end,
		-- })
	end,
}
