---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      position = "left",
      width = 30,
    },
    close_if_last_window = false,
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
    -- 起動時にneo-treeを開く
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        -- ダッシュボードが表示された後にneo-treeを開く
        vim.defer_fn(function() vim.cmd "Neotree show" end, 100)
      end,
      once = true,
    })
  end,
}
