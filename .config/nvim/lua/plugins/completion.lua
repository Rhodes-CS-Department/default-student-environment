return {
  {
    'hrsh7th/nvim-cmp',
    lazy = false,
    priority = 100,
    dependencies = {
      'onsails/lspkind-nvim',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'L3MON4D3/LuaSnip',
    },
    config = function()
      require("custom.completion")
    end,
  }
}
