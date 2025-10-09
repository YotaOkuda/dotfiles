-- オートセーブ
return {
	"okuuva/auto-save.nvim",
	version = "*", -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
	cmd = "ASToggle", -- :ASToggle コマンドで機能をon/off
	event = { "InsertLeave", "TextChanged" },
	-- auto-saveの切り替えコマンド
	keys = {
		{ "<leader>as", "<cmd>ASToggle<CR>", desc = "Toggle auto-save" },
	},
	opts = {
		enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
		-- auto-saveのトリガーイベント
		trigger_events = {
			immediate_save = { "BufLeave", "FocusLost", "QuitPre", "VimSuspend" }, -- 即時保存
			defer_save = { "InsertLeave", "TextChanged" }, -- 遅延保存 (saves after `debounce_delay`)
			cancel_deferred_save = { "InsertEnter" }, -- 遅延保存の対象外イベント
		},
		debounce_delay = 1500, -- 遅延保存
	},

	-- saveしたファイルをメッセージ表示する
	config = function(opts)
		-- 最初にプラグインをセットアップ
		require("auto-save").setup(opts)

		-- その後、自動コマンドを設定する
		local group = vim.api.nvim_create_augroup("autosave", {})

		vim.api.nvim_create_autocmd("User", {
			pattern = "AutoSaveWritePost",
			group = group,
			callback = function(opts)
				if opts.data.saved_buffer ~= nil then
					local filename = vim.api.nvim_buf_get_name(opts.data.saved_buffer)
					vim.notify(
						"AutoSave: saved " .. filename .. " at " .. vim.fn.strftime("%H:%M:%S"),
						vim.log.levels.INFO
					)
				end
			end,
		})
	end,
}
-- test
