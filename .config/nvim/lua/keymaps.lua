-- Shorten function name
local keymap = vim.keymap.set

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Clear search highlight
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Disable arrow keys in normal and visual mode [Hardmode ON]
keymap({"n", "v"}, "<left>",  "<cmd>echo 'Use h to move!!'<CR>")
keymap({"n", "v"}, "<right>", "<cmd>echo 'Use l to move!!'<CR>")
keymap({"n", "v"}, "<up>",    "<cmd>echo 'Use k to move!!'<CR>")
keymap({"n", "v"}, "<down>",  "<cmd>echo 'Use j to move!!'<CR>")

-- [[ Modes]] --
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- [[ Normal ]] --

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Resize with arrows
keymap("n", "<C-Up>",    ":resize +2<CR>")
keymap("n", "<C-Down>",  ":resize -2<CR>")
keymap("n", "<C-Left>",  ":vertical resize +2<CR>")
keymap("n", "<C-Right>", ":vertical resize -2<CR>")
