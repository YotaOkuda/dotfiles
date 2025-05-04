--luaファイルの自動リロード
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.lua" },
  callback = function(args)
    local fp = args.file
    if fp:match "%.lua$" then vim.cmd("luafile" .. fp) end
    print("Reloaded" .. fp)
  end,
})

--[[
vim.api.nvim_create_autocmd("VimEnter", {
  command = "Neotree toggle",
})
]]

-- 共通のリフレッシュ関数
local function refresh_git_status()
  if package.loaded["neo-tree.sources.git_status"] then
    -- neo-tree の manager モジュール名が違う場合は適宜読み替えてください
    local manager = require "neo-tree.sources.manager"
    local state = manager.get_state "git_status"
    require("neo-tree.sources.git_status.commands").refresh(state)
  end
end

-- 1. ToggleTerm Open/Close の User イベントをキャッチ
vim.api.nvim_create_autocmd("User", {
  pattern = { "ToggleTermOpen", "ToggleTermClose" },
  callback = refresh_git_status,
})

-- 2. Git のインデックス (.git/index) が書き換わったとき
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = ".git/index",
  callback = refresh_git_status,
})

-- ファイル保存全般やフォーカス復帰時
vim.api.nvim_create_autocmd({ "BufWritePost", "FocusGained" }, {
  pattern = "*",
  callback = refresh_git_status,
})
