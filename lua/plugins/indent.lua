return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = {
        char = "│", -- try "┆" or "┊" if you want thinner lines
      },
      scope = {
        enabled = true, -- highlights active indent scope (e.g., matching brackets)
        show_start = true,
        show_end = false,
      },
    },
  },
}
