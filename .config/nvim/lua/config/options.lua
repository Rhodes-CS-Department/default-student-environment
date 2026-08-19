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

-- ---------------------------------------------------------------------------
-- REMOTE CLIPBOARD OVER SSH (OSC 52)
-- ---------------------------------------------------------------------------
-- Over SSH, use OSC 52 escape sequences so yanks reach the *local* clipboard
-- (works in iTerm2, kitty, wezterm, alacritty, Windows Terminal, and tmux with
-- set-clipboard on).
--
-- HOW TO DISABLE THIS:
-- If your terminal does NOT support OSC 52, you may see symptoms such as:
--   * stray escape junk like "]52;c;..." printed on screen when you yank
--   * nvim freezing for a few seconds when you paste with "+p or "*p
--     (the terminal never answers the OSC 52 read request)
--   * the system clipboard simply never updating
--
-- To turn the remote clipboard off, pick ONE of the following:
--
--   1. DISABLE IT ENTIRELY (simplest): change the `if` condition below to
--      `if false then`, or comment out the whole `if ... end` block (select
--      the lines and press `gc` to toggle comments). Yank/paste then stays
--      inside nvim and the remote machine only.
--
--   2. KEEP COPY, DROP PASTE (recommended if only pasting misbehaves): most
--      terminals implement the OSC 52 *write* but not the *read*. Delete or
--      comment out the entire `paste = { ... },` table below. Copying to your
--      local clipboard keeps working; use your terminal's normal paste
--      shortcut (Cmd-V / Ctrl-Shift-V) to paste into nvim.
--
--   3. DISABLE IT PER-MACHINE without editing this file: set the environment
--      variable NVIM_NO_OSC52 (e.g. `export NVIM_NO_OSC52=1` in your shell
--      rc file) -- that is what the `vim.env.NVIM_NO_OSC52` check below does.
--
-- After disabling, `vim.opt.clipboard = "unnamedplus"` above still applies. On
-- a remote box with no local clipboard provider that just means yanks stay in
-- nvim's registers; if you also want nvim's registers kept separate from any
-- system clipboard, comment out that `vim.opt.clipboard` line too.
--
-- To verify OSC 52 is active, run `:echo g:clipboard` inside nvim -- it prints
-- the "OSC 52" table when enabled, and errors/prints nothing when disabled.
-- ---------------------------------------------------------------------------
if not vim.env.NVIM_NO_OSC52 and (vim.env.SSH_TTY or vim.env.SSH_CONNECTION) then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    -- Remove/comment out this `paste` table (through its closing `},`) if your
    -- terminal supports OSC 52 copy but hangs on paste. See option 2 above.
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
else
  vim.g.clipboard = false
  vim.g.termfeatures = {
    osc52 = false,
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
if not vim.env.NVIM_NO_OSC52 then
vim.opt.termguicolors = true
else
vim.opt.termguicolors = false
end

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
