local map = vim.keymap.set

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function(args)
    vim.cmd "startinsert"
    local opts = { buffer = args.buf, silent = true }
    map("t", "<Esc>", "<C-\\><C-n>", opts)
    map("n", "q", "<cmd>bd!<CR>", opts)
  end,
})
