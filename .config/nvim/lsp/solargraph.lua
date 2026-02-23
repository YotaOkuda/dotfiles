return {
	cmd = { "solargraph", "stdio" },
	filetypes = { "ruby" },
	root_markers = { "Gemfile", ".git" },
	settings = {
		solargraph = {
			diagnostics = true,
			completion = true,
			hover = true,
			references = true,
			rename = true,
			symbols = true,
			definitions = true,
			snippets = false,
			enableSnippets = false,
		},
	},
}
