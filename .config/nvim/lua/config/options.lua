-- enable line numbers
vim.opt.number        = true

-- open new windows in better locations
vim.opt.splitbelow    = true
vim.opt.splitright    = true

-- don't wrap lines
vim.opt.wrap          = false

-- setup tabs / default spacing
vim.opt.expandtab     = true
vim.opt.tabstop       = 2
vim.opt.shiftwidth    = 2

-- sync nvim / system clipboard
vim.opt.clipboard     = "unnamedplus"

-- over SSH, use OSC 52 escape sequences so yanks reach the *local* clipboard
-- (works in iTerm2, kitty, wezterm, alacritty, and tmux with set-clipboard on)
if vim.env.SSH_TTY or vim.env.SSH_CONNECTION then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end

-- keep screen centered
--vim.opt.scrolloff     = 999

-- persistent undo (survives closing/reopening the file)
vim.opt.undofile = true
vim.opt.undodir  = vim.fn.stdpath("state") .. "/undo"

-- allow ragged edges for visual block mode
vim.opt.virtualedit   = "block"

-- show edit previews in a split window
vim.opt.inccommand    = "split"

-- ignore case in search, unless the search contains a capital letter
vim.opt.ignorecase    = true
vim.opt.smartcase     = true

-- highlight search matches and jump as you type
vim.opt.hlsearch      = true
vim.opt.incsearch     = true

-- let the mouse work in all modes (helpful for new users)
vim.opt.mouse         = "a"

-- allow 24-bit colors / fancy fonts / powerline / nerd fonts
vim.opt.termguicolors = true

-- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.mapleader       = " "

-- reserve space for signs in the gutter
vim.opt.signcolumn = 'yes'

-- block cursor
vim.opt["guicursor"] = ""

-- briefly highlight yanked text as visual feedback
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  callback = function()
    vim.hl.on_yank()
  end,
})
