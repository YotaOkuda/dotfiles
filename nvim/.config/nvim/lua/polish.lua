require "user.options"
require "user.keymaps"

-- lua/polish.lua
vim.keymap.set("n", "<Space>fb", function()
  require("telescope").extensions.file_browser.file_browser {
    path = vim.fn.expand "%:p:h", -- 現在バッファのあるフォルダ
    cwd = vim.fn.expand "%:p:h",
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = true,
  }
end, { desc = "Telescope File Browser" })

-- luaファイルの自動リロード
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.lua" },
  callback = function(args)
    local fp = args.file
    if fp:match "%.lua$" then vim.cmd("luafile" .. fp) end
    print("Reloaded" .. fp)
  end,
})
