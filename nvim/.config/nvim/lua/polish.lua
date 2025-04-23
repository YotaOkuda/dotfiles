-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit inthe normal config locations above can go here

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
