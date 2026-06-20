return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.clang_format.with({
          filetypes = { "c" },
          extra_args = { "-style={BasedOnStyle: LLVM, IndentWidth: 4}" }, -- Optional: Customize style (e.g., LLVM, Google, etc.)
        }),
      },
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
