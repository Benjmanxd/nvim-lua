local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local global_config = require("telescope.config")
local vimgrep_arguments = { unpack(global_config.values.vimgrep_arguments) }

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fx", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>x",  "<CMD>Telescope file_browser<CR>", { noremap = true })

table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!.git/*")

local config = {
    defaults = {
        -- :help telescope.layout
        vimgrep_arguments = vimgrep_arguments,
        path_display = { truncate = 5 },
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        scroll_strategy = "limit",
        color_devicons = true,
        layout_strategy = "horizontal",
        layout_config = { 
            prompt_position = "top",
            height = 0.85,
            width = 0.85,
        },
        mappings = {
            i = {
                ["<ESC>"] = actions.close,
            },
        },
    },
    pickers = {
		find_files = {
			-- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
		},
	},
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
        file_browser = {
            path_display = { truncate = 5 },
            selection_strategy = "reset",
            sorting_strategy = "ascending",
            scroll_strategy = "limit",
            borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            --layout_strategy = "horizontal",
            --layout_config = { 
            --    prompt_position = "top",
            --    height = 0.85,
            --    width = 0.85,
            --},
            theme = "ivy",
            hijack_netrw = true,
        },
    },
}

telescope.setup(config)

telescope.load_extension "file_browser"

--[[
** Default mappings **
Mappings 	    Action
<C-n>/<Down> 	Next item
<C-p>/<Up> 	    Previous item
j/k 	        Next/previous (in normal mode)
H/M/L 	        Select High/Middle/Low (in normal mode)
gg/G 	        Select the first/last item (in normal mode)
<CR> 	        Confirm selection
<C-x> 	        Go to file selection as a split
<C-v> 	        Go to file selection as a vsplit
<C-t> 	        Go to a file in a new tab
<C-u> 	        Scroll up in preview window
<C-d> 	        Scroll down in preview window
<C-/> 	        Show mappings for picker actions (insert mode)
? 	            Show mappings for picker actions (normal mode)
<C-c> 	        Close telescope
<Esc> 	        Close telescope (in normal mode)
<Tab> 	        Toggle selection and move to next selection
<S-Tab> 	    Toggle selection and move to prev selection
<C-q> 	        Send all items not filtered to quickfixlist (qflist)
<M-q> 	        Send all selected items to qflist
--]]
