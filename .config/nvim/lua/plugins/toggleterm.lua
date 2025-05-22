---@type LazySpec
return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup {
      persist_mode = false, -- モードを保持しない
      start_in_insert = true, -- 常にインサートモードで開始
    }
  end,
}
