local builtin = require('telescope.builtin')

local set = vim.keymap.set
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

set('n', '<leader>ff', builtin.find_files, {})
set('n', '<leader>fg', builtin.live_grep, {})
set('n', '<leader>fb', builtin.buffers, {})
set('n', '<leader>fh', builtin.help_tags, {})

-- Move between windows
set("n", "<c-j>", "<c-w><c-j>")
set("n", "<c-k>", "<c-w><c-k>")
set("n", "<c-l>", "<c-w><c-l>")
set("n", "<c-h>", "<c-w><c-h>")
-- Resize windows
set("n", "<M-,>", "<c-w>5<")
set("n", "<M-.>", "<c-w>5>")
set("n", "<M-t>", "<c-W>+")
set("n", "<M-s>", "<c-W>-")



-- barbar keymaps
--
-- Move to previous/next
-- map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
-- map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
-- Goto pinned/unpinned buffer
--                 :BufferGotoPinned
--                 :BufferGotoUnpinned
-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
--map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
-- Sort automatically by...
map('n', '<leader>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<leader>bn', '<Cmd>BufferOrderByName<CR>', opts)
map('n', '<leader>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<leader>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<leader>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)
