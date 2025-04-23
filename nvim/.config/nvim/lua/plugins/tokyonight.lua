-- ~/.config/nvim/lua/plugins/tokyonight.lua
---@type LazySpec
return {
  "folke/tokyonight.nvim", -- GitHub からプラグインを取得
  lazy = false, -- 起動時に即ロード
  priority = 1000, -- カラースキームは早めに適用させる
  config = function()
    require("tokyonight").setup {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    }
    vim.cmd [[colorscheme tokyonight-night]]
  end,
}
