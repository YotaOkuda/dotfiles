--[[
vim.api.nvim_create_autocmd("VimEnter", {
  command = "Neotree toggle",
})
]]

local manager = require "neo-tree.sources.manager"

vim.api.nvim_create_autocmd({ "TermClose", "BufWritePost" }, {
  pattern = "*",
  callback = function()
    if package.loaded["neo-tree.sources.git_status"] then
      local gs = manager.get_state "git_status"
      require("neo-tree.sources.git_status.commands").refresh(gs)
    end
  end,
})
