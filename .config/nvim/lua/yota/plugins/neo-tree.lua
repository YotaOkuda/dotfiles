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

		opts.filesystem.window = {
			width = 35,
			mappings = {
				-- ["<CR>"] = "open_tabnew", -- 通常の開き方（今のウィンドウ）
				["t"] = "open_tabnew", -- tキーで新しいタブで開く
			},
		}
		-- ファイルシステムの自動更新設定
		opts.filesystem.use_libuv_file_watcher = true
		opts.filesystem.follow_current_file = {
			enabled = true, -- 現在のファイルを自動的にフォーカス
			leave_dirs_open = true, -- 自動展開されたディレクトリを閉じる
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

	keys = {
		{ "<leader>ne", "<cmd>Neotree toggle<CR>", desc = "Toggle NeoTree" },
		{ "<leader>nl", "<cmd>Neotree show left<CR>", desc = "Open NeoTree (Left)" },
		{ "<leader>nf", "<cmd>Neotree reveal<CR>", desc = "Reveal Current File in NeoTree" },
	},

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
	end,
}
