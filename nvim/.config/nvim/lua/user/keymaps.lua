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
    map("n", "q", "<cmd>ToggleTerm<CR>", opts)
  end,
})
