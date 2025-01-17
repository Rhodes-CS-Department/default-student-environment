return {
  -- comment control
  {
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup()
    end,
    lazy = false,
  },
}
