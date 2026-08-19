return {
  -- Tokyo Night theme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      if vim.o.background == "light" then
        vim.cmd [[ colorscheme tokyonight-day ]]
      else
        vim.cmd [[ colorscheme tokyonight-storm ]]
      end
    end
  },
}
