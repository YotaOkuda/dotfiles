-- ~/.config/nvim/lsp/ruby_lsp.lua
return {
	-- cmd = { "/Users/okudayota/.rbenv/shims/ruby-lsp" },
	cmd = { "bundle", "exec", "ruby-lsp" },
	filetypes = { "ruby" },
	root_markers = { "Gemfile", ".git" },
	init_options = {
		formatter = "standard",
		linters = { "standard" },
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
