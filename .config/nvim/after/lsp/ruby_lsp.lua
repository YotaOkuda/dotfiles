-- ~/.config/nvim/lsp/ruby_lsp.lua
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/ruby-lsp"

local function get_cmd()
	-- Local gem (rbenv shim, system gem) takes priority over Mason
	local sys_path = vim.fn.exepath("ruby-lsp")
	if sys_path ~= "" and sys_path ~= mason_bin then
		return { sys_path }
	end
	-- Fall back to Mason-installed binary
	if vim.fn.filereadable(mason_bin) == 1 then
		return { mason_bin }
	end
	return { "ruby-lsp" }
end

return {
	cmd = get_cmd(),
	filetypes = { "ruby" },
	root_markers = { "Gemfile", ".git" },
	init_options = {
		formatter = "auto",
		linters = {},
		enabledFeatures = {
			"documentHighlights",
			"documentSymbols",
			"foldingRanges",
			"selectionRanges",
			"semanticHighlighting",
			"diagnostics",
			"formatting",
			"codeActions",
			"completion",
			"hover",
			"references",
			"definition",
		},
	},
	settings = {
		rubyLsp = { formatter = "auto", singleFileLibrary = { diagnostics = "on" } },
	},
}
