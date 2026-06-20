return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_installed = { "lua", "javascript", "python", "c", "php", "blade", "html", "css", "javascript", "typescript", "json", },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
