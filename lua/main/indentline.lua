local g = vim.g

g.indentLine_enabled = 0
g.indentLine_setColors = 1
g.indentLine_color_dark = 1
g.indentLine_char_list = { '|', '¦', '┆', '┊' }

vim.keymap.set("n", "<leader>ii", "<CMD>IndentLinesToggle<CR>", { noremap = true })
