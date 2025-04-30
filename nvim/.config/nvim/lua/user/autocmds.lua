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

-- Neo-tree のソース管理モジュールを経由して state を取得
local manager = require "neo-tree.sources.manager"
-- TermClose, BufWritePost 時にneo-treeをリフレッシュ（適切なアイコンが表示される）
vim.api.nvim_create_autocmd({ "TermClose", "BufWritePost" }, {
  pattern = "*",
  callback = function()
    if package.loaded["neo-tree.sources.git_status"] then
      local gs = manager.get_state "git_status"
      require("neo-tree.sources.git_status.commands").refresh(gs)
    end
  end,
})
