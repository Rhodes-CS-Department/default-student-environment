return {
  -- status bar line packages
  {
    "nvim-tree/nvim-web-devicons",
  },
  {
    "echasnovski/mini.statusline",
    enabled = true,
    version = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("mini.statusline").setup()
    end,
  },
}
