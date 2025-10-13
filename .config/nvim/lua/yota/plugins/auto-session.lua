return {
	"rmagatti/auto-session",
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			auto_save_enable = true,
			auto_restore_enabled = false,
			auto_session_suppress_dirs = { "~/", "~/Dev/", "~/Downloads", "~/Documents", "~/Desktop/" },

			-- post_restore_cmds = {
			-- 	"Neotree toggle left",
			-- },
		})
		vim.api.nvim_create_autocmd("SessionLoadPost", {
			callback = function()
				-- セッション復元が終わったあと、0.1秒遅らせて処理
				vim.defer_fn(function()
					-- Neo-treeを左に開く
					vim.cmd("Neotree show left")

					-- すべてのウィンドウを均等にする（Neo-treeはwidth=35固定なので右側が整う）
					vim.cmd("wincmd =")
				end, 100) -- ← 100ミリ秒後に実行
			end,
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>wr", "<cmd>SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
		keymap.set("n", "<leader>ws", "<cmd>SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
	end,
}
