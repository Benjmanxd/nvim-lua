local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

-- space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
-- normal_mode = "n"
-- insert_mode = "i"
-- visual_mode = "v"
-- visual_block_mode = "x"
-- term_mode = "t"
-- command_mode = "c"

-- <CR> -> enter

-- Normal mode
-- explorer
--keymap("n", "<leader>x", ":Lex 30<CR>", opts)
-- window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
-- window resize
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
-- cursor navigation
--keymap("n", "W", "$", opts)
--keymap("n", "B", "^", opts)
-- buffer navigation
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
-- move line up and down
keymap("n", "<C-S-j>", ":m .+1<CR>==", opts)
keymap("n", "<C-S-k>", ":m .-2<CR>==", opts)
-- indentation
keymap("n", "<", "<<", opts)
keymap("n", ">", ">>", opts)
keymap("n", "<C-S-f>", "gg=G", opts)
keymap("n", "<TAB>", "i<TAB><ESC>l", opts)


-- Visual mode
-- indentation
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
-- move text up and down
keymap("v", "<C-S-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<C-S-k>", ":m '<-2<CR>gv=gv", opts)
keymap("v", "p", '"_dP', opts)
