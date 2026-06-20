return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "tsx",
        "python",
        "c",
        "php",
        "blade",
        "html",
        "css",
        "json",
        "hcl",
        "terraform",
        "yaml",
        "dockerfile",
        "bash",
        "markdown",
        "markdown_inline",
        "sql",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
