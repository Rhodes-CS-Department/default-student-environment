local builtin = require('telescope.builtin')

local set = vim.keymap.set

-- Telescope (fuzzy finder)
set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
set('n', '<leader>fg', builtin.live_grep,  { desc = "Grep in project" })
set('n', '<leader>fb', builtin.buffers,    { desc = "List open buffers" })
set('n', '<leader>fh', builtin.help_tags,  { desc = "Search help tags" })

-- File tree
set('n', '<leader>e', '<Cmd>Neotree toggle<CR>', { desc = "Toggle file tree" })

-- Clear search highlight
set('n', '<Esc>', '<Cmd>nohlsearch<CR>', { desc = "Clear search highlight" })

-- Move between windows
set("n", "<c-j>", "<c-w><c-j>", { desc = "Move to window below" })
set("n", "<c-k>", "<c-w><c-k>", { desc = "Move to window above" })
set("n", "<c-l>", "<c-w><c-l>", { desc = "Move to window right" })
set("n", "<c-h>", "<c-w><c-h>", { desc = "Move to window left" })

-- Resize windows (leader-based; Alt bindings are unreliable across terminals)
set("n", "<leader>w,", "<c-w>5<", { desc = "Shrink window horizontally" })
set("n", "<leader>w.", "<c-w>5>", { desc = "Grow window horizontally" })
set("n", "<leader>w+", "<c-W>+",  { desc = "Grow window vertically" })
set("n", "<leader>w-", "<c-W>-",  { desc = "Shrink window vertically" })

-- Toggle between light and dark background (reloads the colorscheme)
set("n", "<leader>tb", function()
  vim.o.background = (vim.o.background == "dark") and "light" or "dark"
  local scheme = (vim.o.background == "light") and "tokyonight-day" or "tokyonight-storm"
  vim.cmd.colorscheme(scheme)
end, { desc = "Toggle light/dark background" })
