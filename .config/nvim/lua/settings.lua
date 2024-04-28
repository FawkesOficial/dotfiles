-- Make Neovim share the clipboard with the system
vim.opt.clipboard = "unnamedplus"

-- Display line number on the left
vim.opt.number = true

-- Enable mouse mode
vim.opt.mouse = "a"

-- Enable undofile
vim.opt.undodir = vim.fn.expand("$XDG_CACHE_HOME/.vim/undodir")
vim.opt.undofile = true

-- Tell Neovim that we have a Nerd Font installed
vim.g.have_nerd_font = true

-- [REQUIRES PLUGINS]
-- Don"t show the mode, since it"s already in the status line
-- vim.opt.showmode = false

-- Enable break indent
vim.opt.breakindent = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- [REQUIRES PLUGINS]
-- Keep signcolumn on by default
-- vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help "list"`
--  and `:help "listchars"`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- [REQUIRES PLUGINS (?)]
-- Show which line your cursor is on
-- vim.opt.cursorline = true
-- vim.opt.cursorlineopt = "number"

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search
-- See "keymaps" for clearing highlight by pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- Highlight when yanking (copying) text
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- [REQUIRES CUSTOM KEYBIND TO TOGGLE ON/OFF]
-- Display a vertical bar as a reference to line width
-- vim.opt.colorcolumn = "120"

-- Use spaces instead of tabs. the only correct way. as it should be
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
