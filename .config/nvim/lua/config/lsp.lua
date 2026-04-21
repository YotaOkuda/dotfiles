local capabilities = require("blink.cmp").get_lsp_capabilities()

-- 1. 全サーバー共通の設定 (0.11以降の書き方)
vim.lsp.config("*", {
	capabilities = capabilities,
})

-- 2. 使用するLanguage Serverをリストアップして有効化
-- 設定は ~/.config/nvim/after/lsp/{name}.lua から自動で読み込まれます
local servers = {
	"ruby_lsp",
	-- "solargraph",
	-- "graphql",
	"emmet_ls",
	"eslint",
	"lua_ls",
	-- "pyright",
	"ts_ls",
	"html",
	"cssls",
	-- "tailwindcss",
}

for _, server in ipairs(servers) do
	vim.lsp.enable(server)
end

-- 3. 診断（Diagnostic）の表示設定
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "󰠠",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
})

-- 4. LSPがバッファにアタッチした時の処理 (キーマップ設定)
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf, silent = true }
		local keymap = vim.keymap

		-- Snacks.pickerを使ったリッチな機能
		opts.desc = "Show LSP references"
		keymap.set("n", "gR", function() Snacks.picker.lsp_references() end, opts)

		opts.desc = "Show LSP definitions"
		keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, opts)

		opts.desc = "Show LSP implementations"
		keymap.set("n", "gi", function() Snacks.picker.lsp_implementations() end, opts)

		opts.desc = "Show LSP type definitions"
		keymap.set("n", "gt", function() Snacks.picker.lsp_type_definitions() end, opts)

		opts.desc = "Show buffer diagnostics"
		keymap.set("n", "<leader>D", function() Snacks.picker.diagnostics_buffer() end, opts)

		-- LSP標準機能
		opts.desc = "Go to declaration"
		keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

		opts.desc = "See available code actions"
		keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

		opts.desc = "Smart rename"
		keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

		opts.desc = "Show line diagnostics"
		keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

		opts.desc = "Go to previous diagnostic"
		keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

		opts.desc = "Go to next diagnostic"
		keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

		opts.desc = "Show documentation for what is under cursor"
		keymap.set("n", "K", vim.lsp.buf.hover, opts)

		opts.desc = "Restart LSP"
		keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
	end,
})
