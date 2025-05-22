---@type LazySpec
return {
  "Pocco81/auto-save.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("auto-save").setup {
      -- プラグイン読み込み直後に有効
      enabled = true,

      -- 保存時のメッセージ設定（必ずテーブルで渡す）
      execution_message = {
        -- 文字列を返す関数 or 直接文字列も可
        message = function() return "" end,
        dim = 0.18, -- ログを薄くする度合い
        cleaning_interval = 2500, -- ミリ秒後に MsgArea をクリア
      },

      -- 保存をトリガーするイベント名
      trigger_events = { "InsertLeave", "BufLeave" },

      -- 保存対象かどうか判定する関数（引数 buf がバッファ番号）
      condition = function(buf)
        local fn = vim.fn
        local utils = require "auto-save.utils.data"
        return fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {})
      end,

      -- 複数バッファ同時保存するかどうか
      write_all_buffers = false,

      -- 保存をデバウンスする時間（ミリ秒）
      debounce_delay = 135,

      -- 保存前後のフック（必要なければ nil のまま）
      callbacks = {
        enabling = nil,
        disabling = nil,
        before_asserting_save = nil,
        before_saving = nil,
        after_saving = nil,
      },
    }
  end,
}
