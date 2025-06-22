local map = vim.keymap.set

-- keymap
map("n", "h", "b", { silent = true })
map("n", "l", "w", { silent = true })
map("v", "h", "b", { silent = true })
map("v", "l", "w", { silent = true })
map("n", "<C-u>", "<C-u>zz", { silent = true })
map("n", "<C-d>", "<C-d>zz", { silent = true })
map("n", "y", "yy", { silent = true })

-- Terminal 用の設定
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*toggleterm#*",
  callback = function(args)
    local opts = { buffer = args.buf, silent = true }
    map("t", "<Esc>", "<C-\\><C-n>", opts)

    local manager = require("neo-tree.sources.manager")
    -- ToggleTermのキーマッピングを更新
    map("n", "q", function()
      vim.cmd("ToggleTerm")
      -- 次のイベントループで Neo-Tree の git_status をリフレッシュ
      vim.schedule(function()
        if package.loaded["neo-tree.sources.git_status"] then
          local gs = manager.get_state("git_status")
          require("neo-tree.sources.git_status.commands").refresh(gs)
        end
      end)
    end, opts)
  end,
})
