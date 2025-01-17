return {
  -- fuzzy finder (Telescope)
  {
    "nvim-lua/plenary.nvim",
  },
  {
    "nvim-telescope/telescope.nvim", -- fuzzy finder
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
    },
  },
}
