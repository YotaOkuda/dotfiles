-- 診断メッセージの表示
vim.diagnostic.config({
	virtual_text = true,
})

-- 全角スペースをハイライトする
vim.cmd([[
  hi DoubleByteSpace term=underline ctermbg=blue guibg=#e0af68
  match DoubleByteSpace /　/
]])
