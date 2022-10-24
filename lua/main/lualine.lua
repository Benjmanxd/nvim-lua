local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

-- local function
local progress = function()
	local current_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")
	local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
	local line_ratio = current_line / total_lines
	local index = math.ceil(line_ratio * #chars)
	return chars[index]
end

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end


local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
    diagnostics_color = {
        error = "DiagnosticError",
        warm = "DiagnosticWarn",
    },
	symbols = { error = " ", warn = " " },
	colored = false,
	update_in_insert = false,
	always_visible = false,
}

local diff = {
	"diff",
    diff_color = {
        added = "DiffAdd",
        modified = "DiffChange",
        removed = "DiffDelete",
    },
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	colored = false,
    always_visible = false,
    cond = hide_in_width,
}

local fileformat = {
    "fileformat",
    symbols = {
        unix = '', -- e712
        dos = '',  -- e70f
        mac = '',  -- e711
    },
}

local filename_statusline = {
    "filename",
    file_status = false,      -- Displays file status (readonly status, modified status)
    newfile_status = false,  -- Display new file status (new file means no write after created)
    path = 3,                -- 0: Just the filename
                           -- 1: Relative path
                           -- 2: Absolute path
                           -- 3: Absolute path, with tilde as the home directory

    shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
                           -- for other components. (terrible name, any suggestions?)
    symbols = {
        modified = '[+]',      -- Text to show when the file is modified.
        readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
        unnamed = '[No Name]', -- Text to show for unnamed buffers.
        newfile = '[New]',     -- Text to show for new created file before first writting
    }
}

local filename_tabline = {
    "filename",
    file_status = true,      -- Displays file status (readonly status, modified status)
    newfile_status = true,  -- Display new file status (new file means no write after created)
    path = 3,                -- 0: Just the filename
                           -- 1: Relative path
                           -- 2: Absolute path
                           -- 3: Absolute path, with tilde as the home directory

    shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
                           -- for other components. (terrible name, any suggestions?)
    symbols = {
        modified = '[+]',      -- Text to show when the file is modified.
        readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
        unnamed = '[No Name]', -- Text to show for unnamed buffers.
        newfile = '[New]',     -- Text to show for new created file before first writting
    }
}

local filetype = {
    "filetype",
    colored = true,
    icon_only = true,
    icon = { align = 'right' }, -- Display filetype icon on the right hand side
	icons_enabled = false,
    -- icon =    {'X', align='right'}
    -- Icon string ^ in table is ignored in filetype component
}

local mode = {
	"mode",
	fmt = function(str)
		return "-- " .. str .. " --"
	end,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local location = {
	"location",
    padding = 1,
}

local encoding = {
    "encoding",
}

local date = "os.date('%a, %d %b %Y %H:%M:%S')"

local lsp = {
    function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = ' LSP:',
    --color = { fg = '#ffffff', gui = 'bold' },
}

local config = {
	options = {
		icons_enabled = true,
		--theme = "auto",
        --theme = "seoul256",
        --theme = "onedark",
        theme = "palenight",
		--component_separators = { left = "", right = "" },
		--section_separators = { left = "", right = "" },
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "neo-tree", "aerial" },
		always_divide_middle = true,
        padding = { left = 2, right = 2, },
	},
	sections = {
		lualine_a = { mode },
		lualine_b = { branch },
		lualine_c = { lsp, diagnostics },
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		-- lualine_x = { diff, spaces, "encoding", filetype },
		lualine_x = { diff },
		lualine_y = { location, encoding, filetype },
		lualine_z = { progress },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { filename_statusline },
		lualine_x = { location },
		lualine_y = {},
		lualine_z = {},
	},
    --[[
	tabline = {
        lualine_a = { filename_tabline },
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { date },
    },
    --]]
    winbar = {},
	extensions = {},
}

local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end

lualine.setup(config)

--  terminal = {
--    a = { fg = colors.black, bg = colors.yellow, gui = 'bold' },
--    b = { fg = colors.yellow, bg = colors.menu_grey },
--  },
--  command = {
--    a = { fg = colors.black, bg = colors.dark_yellow, gui = 'bold' },
--    b = { fg = colors.dark_yellow, bg = colors.menu_grey },
--  },
