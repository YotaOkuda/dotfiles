-- 起動時に英字入力へ
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.fn.system("im-select com.apple.keylayout.ABC")
	end,
})

-- 挿入モードを抜けたら英字入力へ
vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		vim.fn.system("im-select com.apple.keylayout.ABC")
	end,
})

-- 挿入モードに入るときに前回の入力ソースに戻したいなら：
vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		vim.fn.system("im-select") -- 直前の入力ソースを復元
	end,
})
