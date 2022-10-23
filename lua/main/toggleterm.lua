local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
    return
end

--vim.keymap.set("n", "<leader>tt", "<CMD>ToggleTerm<CR>", { noremap = true })

local config = {
    -- size can be a number or function which is passed the current terminal
    size = function(term) -- or return 20
        if term.direction == "horizontal" then
            return 15
        elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
        end
    end,
    open_mapping = [[<c-\>]],
    on_open = function(terminal) -- fun(t: Terminal) function to run when the terminal opens
    end,
    on_close = function(terminal) -- fun(t: Terminal) function to run when the terminal closes
    end,
    on_stdout = function(terminal, job, data, name) -- fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
    end,
    on_stderr = function(terminal, job, data, name) -- fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
    end,
    on_exit = function(terminal, job, exit_code, name) -- fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
    end,
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
    -- highlights = {
    --     -- highlights which map to a highlight group name and a table of it's values
    --     -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
    --     Normal = {
    --         guibg = "<VALUE-HERE>",
    --     },
    --     NormalFloat = {
    --         link = 'Normal'
    --     },
    --     FloatBorder = {
    --         guifg = "<VALUE-HERE>",
    --         guibg = "<VALUE-HERE>",
    --     },
    -- },
    shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
    shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    persist_size = true,
    persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
    direction = "float", -- value: 'vertical', 'horizontal', 'tab', 'float'
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    auto_scroll = true, -- automatically scroll to the bottom on terminal output
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = "curved", -- value: 'single', 'double', 'shadow', 'curved'
        -- like `size`, width and height can be a number or function which is passed the current terminal
        width = 150,
        height = 60,
        winblend = 30,
    },
    winbar = {
        enabled = false,
        name_formatter = function(term) --  term: Terminal
            return term.name
        end
    },
}

toggleterm.setup(config)
