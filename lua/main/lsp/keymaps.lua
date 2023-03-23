local diag = vim.diagnostic
vim.keymap.set("n", "[d", diag.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", diag.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "gl", diag.open_float, { desc = "Open flating diagnostic message" })
vim.keymap.set("n", "gs", diag.setloclist, { desc = "Open diagnostic list" })

local buf = vim.lsp.buf
vim.keymap.set("n", "<leader>rn", buf.rename, { desc = "[R]e[n]ame" })
vim.keymap.set("n", "<leader>ca", buf.code_action, { desc = "[C]ode [A]ction" })
vim.keymap.set("n", "gd", buf.definition, { desc = "[G]oto [D]efinition" })
vim.keymap.set("n", "gi", buf.implementation, { desc = "[G]oto [I]mplementation" })
vim.keymap.set("n", "gt", buf.type_definition, { desc = "[G]oto [T]ype Definition" })
