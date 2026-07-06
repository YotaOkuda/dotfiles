-- explorerでファイル名/パスをクリップボードにコピーする
local function copy_to_clipboard(item, mod)
	if not item then
		return
	end
	local value = vim.fn.fnamemodify(item.file, mod)
	vim.fn.setreg("+", value)
	Snacks.notify.info("Copied: " .. value)
end

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
		dashboard = {
			enabled = true,
			preset = {
				-- alpha-nvimから移植
				header = [[
 ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
 ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
 ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
 ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
 ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
				keys = {
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{ icon = " ", key = "e", desc = "Explorer", action = ":lua Snacks.explorer()" },
					{ icon = "󰱼 ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "g", desc = "Find Word", action = ":lua Snacks.dashboard.pick('live_grep')" },
					{ icon = "󰁯 ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
					{ icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy" },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
		},
		explorer = {
			enabled = true,
			replace_netrw = true, -- netrwの代わりにexplorerを使う
		},
		indent = {
			enabled = true,
			indent = { char = "│" }, -- 実線のガイド
			-- カーソルがいるスコープを丸角+矢印の枠で表示(scope表示の代わり)
			chunk = {
				enabled = true,
				char = {
					corner_top = "╭",
					corner_bottom = "╰",
					horizontal = "─",
					vertical = "│",
					arrow = ">",
				},
			},
		},
		input = { enabled = true },
		picker = {
			enabled = true,
			icons = {
				git = {
					modified = "M ", -- 変更あり(未ステージ)
					staged = "S ", -- ステージ済み
					untracked = "U ", -- 未追跡
				},
			},
			sources = {
				explorer = {
					-- neo-treeの設定を移植
					hidden = true, -- ドットファイルを表示
					ignored = true, -- .gitignoreに記載されているファイルも表示
					follow_file = true, -- fzf等で開いたファイルを自動的にフォーカス・展開
					auto_close = false, -- ファイルを開いてもexplorerを閉じない
					jump = { close = false },
					watch = true, -- ファイルシステムを監視して自動更新(libuv watcher相当)
					git_status = true, -- gitの変更を表示

					git_status_open = true, -- 開いているディレクトリ内のgit statusも表示
					git_untracked = true, -- 未追跡ファイルもマーク
					diagnostics = true, -- 診断情報を表示
					diagnostics_open = true,
					layout = {
						preset = "sidebar",
						layout = { width = 35 },
						preview = false,
					},
					actions = {
						copy_name = function(_, item)
							copy_to_clipboard(item, ":t") -- ファイル名のみ
						end,
						copy_rel_path = function(_, item)
							copy_to_clipboard(item, ":.") -- cwdからの相対パス
						end,
						copy_abs_path = function(_, item)
							copy_to_clipboard(item, ":p") -- 絶対パス
						end,
					},
					win = {
						list = {
							keys = {
								-- h/l はデフォルトで ディレクトリを閉じる/開く(確定)、j/k で上下移動
								-- y はデフォルトでフルパスをコピー(pで貼り付け用も兼ねる)
								["t"] = "tab", -- tキーで新しいタブで開く
								["<C-t>"] = "terminal",
								["Y"] = "copy_name", -- ファイル名のみコピー
								["gy"] = "copy_rel_path", -- 相対パスをコピー
								["gY"] = "copy_abs_path", -- 絶対パスをコピー
							},
						},
					},
					format = function(item, picker)
						local ret = Snacks.picker.format.file(item, picker)
						-- :wで保存されていないバッファに ○ を表示
						if item.file and not item.dir then
							for _, buf in ipairs(vim.api.nvim_list_bufs()) do
								if vim.bo[buf].modified and vim.api.nvim_buf_get_name(buf) == item.file then
									ret[#ret + 1] = { "○ ", "DiagnosticWarn" }
									break
								end
							end
						end
						return ret
					end,
				},
				lsp_references = { jump_to_single = false },
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
			"<leader>ne",
			function()
				Snacks.explorer()
			end,
			desc = "Toggle Explorer",
		},
		{
			"<leader>nf",
			function()
				Snacks.explorer.reveal()
			end,
			desc = "Reveal Current File in Explorer",
		},
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
			"<leader>fd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Find diagnostics (workspace)",
		},
		{
			"<leader>lg",
			function()
				Snacks.lazygit()
			end,
			desc = "Open lazy git",
		},
		{
			"<leader>lf",
			function()
				Snacks.lazygit.log_file()
			end,
			desc = "Lazygit log for current file",
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

	config = function(_, opts)
		require("snacks").setup(opts)
		-- lazygit終了時にexplorerのgit statusを更新
		vim.api.nvim_create_autocmd("BufLeave", {
			pattern = "*lazygit*",
			group = vim.api.nvim_create_augroup("git_refresh_snacks_explorer", { clear = true }),
			callback = function()
				for _, picker in ipairs(Snacks.picker.get({ source = "explorer" })) do
					picker:action("explorer_update")
				end
			end,
		})
		-- 保存/変更でmodifiedフラグが切り替わったらexplorerを再描画(○マーカー更新)
		vim.api.nvim_create_autocmd("BufModifiedSet", {
			group = vim.api.nvim_create_augroup("modified_marker_snacks_explorer", { clear = true }),
			callback = function(ev)
				if vim.bo[ev.buf].buftype ~= "" or vim.api.nvim_buf_get_name(ev.buf) == "" then
					return
				end
				vim.schedule(function()
					for _, picker in ipairs(Snacks.picker.get({ source = "explorer" })) do
						picker:action("explorer_update")
					end
				end)
			end,
		})
	end,
}
