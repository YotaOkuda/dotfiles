-- ^M をなくす
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    if vim.bo.fileformat == "dos" then vim.bo.fileformat = "unix" end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\r\+$//e]],
})

-- ウィンドウズでもクリップボードを使う
vim.g.clipboard = {
  nama = "win32yank-wsl",
  copy = {
    ["+"] = "clip.exe",
    ["*"] = "clip.exe",
  },
  paste = {
    ["+"] = "powershell.exe -c Get-Clipboard",
    ["*"] = "powershell.exe -c Get-Clipboard",
  },
  cache_enabled = false,
}
vim.opt.clipboard:append { "unnamed", "unnamedplus" }

-- Terminal をデフォルトでインサートモードにする
-- autocmd TermOpen * startinsert
