return {
  -- status bar line packages
  {
    "echasnovski/mini.statusline",
    enabled = true,
    version = false,
    config = function()
      require("mini.statusline").setup({
        use_icons = false,
      })
    end,
  },
}
