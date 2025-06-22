return {
	{
		"keaising/im-select.nvim",
		config = function()
			local is_mac = vim.fn.has("macunix") == 1
			local is_wsl = vim.fn.has("wsl") == 1
			local is_win = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1

			local im_select_cmd = ""
			local default_ime = ""

			if is_mac then
				im_select_cmd = "im-select"
				default_ime = "com.apple.keylayout.ABC"
			elseif is_wsl then
				im_select_cmd = "/mnt/c/Users/yotao/tools/im-select/im-select.exe"
				default_ime = "1033"
			elseif is_win then
				im_select_cmd = "C:\\Users\\yotao\\tools\\im-select\\im-select.exe"
				default_ime = "1033"
			end

			require("im_select").setup({
				default_command = im_select_cmd,
				default_im_select = default_ime,
				set_default_events = { "VimEnter", "InsertEnter", "InsertLeave" },
				set_previous_events = {},
			})
		end,
	},
}
