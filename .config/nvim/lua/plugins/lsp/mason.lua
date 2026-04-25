return {
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			automatic_enable = false,
			-- list of servers for mason to install
			ensure_installed = {
				"ts_ls", -- TypeScript / JavaScript
				"html", -- HTML
				"cssls", -- CSS
				-- "tailwindcss", -- Tailwind CSS
				"lua_ls", -- Lua
				-- "graphql",    -- GraphQL
				"emmet_ls", -- HTML / CSS (Emmet)
				-- "prismals",   -- Prisma
				-- "pyright",    -- Python
				"eslint", -- TypeScript / JavaScript
			},
		},
		dependencies = {
			{
				"williamboman/mason.nvim",
				opts = {
					ui = {
						border = "rounded",
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
			"neovim/nvim-lspconfig",
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"prettier", -- TypeScript / JavaScript / CSS / HTML / JSON / YAML (formatter)
				"stylua", -- Lua (formatter)
				-- "isort",     -- Python import 整理 (formatter)
				-- "black",     -- Python (formatter)
				-- "pylint",    -- Python (linter)
				"eslint_d", -- TypeScript / JavaScript (linter)
			},
		},
		dependencies = {
			"williamboman/mason.nvim",
		},
	},
}
