require('plugins.lazydev')

local lspkind = require('lspkind')

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

local cmp = require('cmp')

cmp.setup({
  -- formatting = {
  --   format = lspkind.cmp_format({
  --     mode = 'symbol', -- show only symbol annotations
  --     maxwidth = {
  --       -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
  --       -- can also be a function to dynamically calculate max width such as
  --       -- menu = function() return math.floor(0.45 * vim.o.columns) end,
  --       menu = 50, -- leading text (labelDetails)
  --       abbr = 50, -- actual suggestion item
  --     },
  --     ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
  --     show_labelDetails = true, -- show labelDetails in menu. Disabled by default
  --
  --     -- The function below will be called before any actual modifications from lspkind
  --     -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
  --     before = function (entry, vim_item)
  --       -- ...
  --       return vim_item
  --     end
  --   })
  -- },
  sources = {
    { name = 'nvim_lsp', group_index = 2 },
    { name = 'buffer', group_index = 2 },
    { name = 'luasnip', group_index = 2 },
    { name = 'path', group_index = 2 },
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
      ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ["<C-e>"] = cmp.mapping.close(),
      ["<C-y>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),


    -- --cmp.mapping.preset.insert({}),
    -- ["<Tab>"] = vim.schedule_wrap(function(fallback)
    --   if cmp.visible() and has_words_before() then
    --     cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
    --   else
    --     fallback()
    --   end
    -- end),
  },
  window = { completion = cmp.config.window.bordered(), },
})

local ls = require('luasnip')
ls.config.set_config({
  history = false,
  updateevents = 'TextChanged,TextChangedI',
})

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
  loadfile(ft_path)()
end

vim.keymap.set({ "i", "s" }, '<c-k>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
  end, { silent = true })

vim.keymap.set({ "i", "s" }, '<c-j>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
  end, { silent = true })
