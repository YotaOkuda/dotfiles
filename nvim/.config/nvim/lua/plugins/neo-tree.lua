---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    -- 既存の設定をマージ
    opts = opts or {}

    -- ファイラーの設定
    opts.filesystem = opts.filesystem or {}

    -- 隠しファイルを表示する設定
    opts.filesystem.filtered_items = {
      visible = true, -- 隠しファイルを表示する
      hide_dotfiles = false, -- ドットファイルを隠さない
      hide_gitignored = false, -- .gitignoreに記載されているファイルを隠さない
    }

    -- ダッシュボードを維持するための設定
    opts.close_if_last_window = false

    return opts
  end,
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
