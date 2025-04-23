---@type LazySpec
return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  -- 起動時ではなく、ファイル操作時に読み込む
  cmd = "Telescope",
  config = function()
    local fb_actions = require "telescope._extensions.file_browser.actions"
    require("telescope").setup {
      extensions = {
        file_browser = {
          theme = "ivy", -- 好きなテーマに
          hijack_netrw = true, -- netrw の代わりに使う
          mappings = {
            ["i"] = {
              -- Insert モードで <C-n> を押すと「新規作成プロンプト」を呼び出し
              ["<C-n>"] = fb_actions.create_from_prompt,
            },
            ["n"] = {
              -- Normal モードでも同じく <C-n> で新規作成
              ["<C-n>"] = fb_actions.create_from_prompt,
            },
          },
        },
      },
    }
    -- Telescope 本体に拡張をロード
    require("telescope").load_extension "file_browser"
  end,
}
