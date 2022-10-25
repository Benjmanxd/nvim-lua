local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then
    return
end

-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
vim.keymap.set("n", "<leader>tt", "<CMD>Neotree toggle<CR>", { noremap = true })
vim.keymap.set("n", "<leader>tb", "<CMD>Neotree buffers toggle<CR>", { noremap = true })
vim.keymap.set("n", "<leader>tg", "<CMD>Neotree git_status toggle<CR>", { noremap = true })

-- If you want icons for diagnostic errors, you'll need to define them somewhere:
vim.fn.sign_define("DiagnosticSignError",
{text = utils.get_icon("DiagnosticError"), texthl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticSignWarn",
{text = utils.get_icon("DiagnosticWarn"), texthl = "DiagnosticSignWarn"})
vim.fn.sign_define("DiagnosticSignInfo",
{text = utils.get_icon("DiagnosticInfo"), texthl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticSignHint",
{text = utils.get_icon("DiagnosticHint"), texthl = "DiagnosticSignHint"})

local config = {
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    sort_case_insensitive = false, -- used when sorting files and directories in the tree
    sort_function = nil , -- use a custom function for sorting files and directories in the tree 
    -- sort_function = function (a,b)
    --       if a.type == b.type then
    --           return a.path > b.path
    --       else
    --           return a.type > b.type
    --       end
    --   end , -- this sorts files and directories descendantly
    source_selector = {
        winbar = false,
        content_layout = "center",
        tab_labels = {
            filesystem = utils.get_icon("FolderClosed") .. " File",
            buffers = utils.get_icon("DefaultFile") .. " Bufs",
            git_status = utils.get_icon("Git") .. " Git",
            diagnostics = utils.get_icon("Diagnostic") .. " Diagnostic",
        },
    },
    default_component_configs = {
        container = {
            enable_character_fade = true
        },
        indent = {
            indent_size = 2,
            padding = 2, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = utils.get_icon("FolderCollapsed"),
            expander_expanded = utils.get_icon("FolderExpanded"),
            expander_highlight = "NeoTreeExpander",
        },
        icon = {
            folder_closed = utils.get_icon("FolderClosed"),
            folder_open = utils.get_icon("FolderOpen"),
            folder_empty = utils.get_icon("FolderEmpty"),
            default = utils.get_icon("DefaultFile"),
            highlight = "NeoTreeFileIcon"
        },
        modified = {
            symbol = utils.get_icon("FileModified"),
            highlight = "NeoTreeModified",
        },
        name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
        },
        git_status = {
            symbols = {
                added = utils.get_icon("GitAdd"),
                deleted = utils.get_icon("GitDelete"),
                modified = utils.get_icon("GitChange"),
                renamed = utils.get_icon("GitRenamed"),
                untracked = utils.get_icon("GitUntracked"),
                ignored = utils.get_icon("GitIgnored"),
                unstaged = utils.get_icon("GitUnstaged"),
                staged = utils.get_icon("GitStaged"),
                conflict = utils.get_icon("GitConflict"),
            },
        },
    },
    window = {
        position = "left",
        width = 30,
        mapping_options = {
            noremap = true,
            nowait = true,
        },
        mappings = {
            ["<space>"] = { 
                "toggle_node", 
                nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use 
            },
            ["<2-LeftMouse>"] = "open",
            --["<cr>"] = "open",
            ["o"] = "open",
            ["<esc>"] = "revert_preview",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            -- ["S"] = "split_with_window_picker",
            -- ["s"] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            ["w"] = "open_with_window_picker",
            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            --["Z"] = "expand_all_nodes",
            ["a"] = { 
                "add",
                -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                config = {
                    show_path = "none" -- "none", "relative", "absolute"
                }
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add".
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            -- ["c"] = {
            --  "copy",
            --  config = {
            --    show_path = "none" -- "none", "relative", "absolute"
            --  }
            --}
            ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
        }
    },
    nesting_rules = {},
    filesystem = {
        filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_hidden = false, -- only works on Windows for hidden files/directories
            hide_by_name = {
                --"node_modules"
            },
            hide_by_pattern = { -- uses glob style patterns
                ".git",
                --"*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
                --".gitignored",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                --".DS_Store",
                --"thumbs.db"
            },
            never_show_by_pattern = { -- uses glob style patterns
                --".null-ls_*",
            },
        },
        follow_current_file = true, -- This will find and focus the file in the active buffer everytime the current file is changed while the tree is open.
        group_empty_dirs = false, -- when true, empty folders will be grouped together
        hijack_netrw_behavior = "open_current",
        --"open_default", -- netrw disabled, opening a directory opens neo-tree
        -- in whatever position is specified in window.position
        -- "open_current",  -- netrw disabled, opening a directory opens within the
        -- window like netrw would, regardless of window.position
        -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
        use_libuv_file_watcher = true, -- This will use the OS level file watchers to detect changes
        -- instead of relying on nvim autocmd events.
        window = {
            mappings = {
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
                ["H"] = "toggle_hidden",
                ["/"] = "fuzzy_finder",
                ["D"] = "fuzzy_finder_directory",
                ["f"] = "filter_on_submit",
                ["<c-x>"] = "clear_filter",
                ["[g"] = "prev_git_modified",
                ["]g"] = "next_git_modified",
            }
        },
    },
    buffers = {
        follow_current_file = true, -- This will find and focus the file in the active buffer every
        -- time the current file is changed while the tree is open.
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        show_unloaded = true,
        window = {
            mappings = {
                ["bd"] = "buffer_delete",
                ["<bs>"] = "navigate_up",
                ["."] = "set_root",
            }
        },
    },
    git_status = {
        window = {
            position = "float",
            mappings = {
                ["A"]  = "git_add_all",
                ["gu"] = "git_unstage_file",
                ["ga"] = "git_add_file",
                ["gr"] = "git_revert_file",
                ["gc"] = "git_commit",
                ["gp"] = "git_push",
                ["gg"] = "git_commit_and_push",
            }
        }
    },
    event_handlers = {
        { event = "neo_tree_buffer_enter", handler = function(_) vim.opt_local.signcolumn = "auto" end },
    },
}

neotree.setup(config)
