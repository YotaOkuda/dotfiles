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

-- OSに応じたクリップボード設定
if vim.fn.has "mac" == 1 then
  vim.g.clipboard = {
    name = "macOS-clipboard",
    copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
    paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
    cache_enabled = 0,
  }
elseif vim.fn.has "wsl" == 1 then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "/mnt/c/Users/yotao/tools/win32yank/win32yank.exe -i --crlf",
      ["*"] = "/mnt/c/Users/yotao/tools/win32yank/win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "/mnt/c/Users/yotao/tools/win32yank/win32yank.exe -o --lf",
      ["*"] = "/mnt/c/Users/yotao/tools/win32yank/win32yank.exe -o --lf",
    },
    cache_enabled = 0,
  }
end
