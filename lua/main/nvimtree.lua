local status_ok, nvimtree = pcall(require, "nvim-tree")
if not status_ok then
    return
end

vim.keymap.set("n", "<leader>tt", "<CMD>NvimTreeToggle<CR>", {})

local g = vim.g
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

local config = {
    sort_by = "case_sensitive",
    disable_netrw = true,
    hijack_netrw = true,
    view = {
        adaptive_size = true,
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
            },
        },
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
}


nvimtree.setup(config)
