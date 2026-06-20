return {
  {
    "ellisonleao/glow.nvim",
    config = function()
      require("glow").setup({
        style = "dark",
        width = 120,
        border = "rounded",
      })
    end,
    cmd = "Glow",
  },
}
