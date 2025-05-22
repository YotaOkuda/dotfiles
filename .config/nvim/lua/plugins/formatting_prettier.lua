---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local null_ls = require "null-ls"
    opts.sources = vim.tbl_extend("force", opts.sources or {}, {
      null_ls.builtins.formatting.prettier.with {
        extra_args = {
          "--insert-final-newline",
          "true",
          "--end-of-line",
          "auto",
          "--trailing-comma",
          "none",
        },
      },
    })
  end,
}
