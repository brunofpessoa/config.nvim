local function execute_command(opts)
    require("neo-tree.command").execute(opts or {})
end
return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    keys = {
        { "<leader>e",  function() execute_command({ toggle = true, dir = vim.uv.cwd() }) end,    desc = "File Explorer" },
        { "<leader>be", function() execute_command({ source = "buffers", toggle = true }) end,    desc = "File Explorer (Buffers)" },
        { "<leader>ge", function() execute_command({ source = "git_status", toggle = true }) end, desc = "File Explorer (Git)" },
    },
    opts = {
        close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        filesystem = {
            filtered_items = {
                hide_by_pattern = {
                    ".node_modules",
                },

            },
            bind_to_cwd = false,
            use_libuv_file_watcher = true,
            follow_current_file = {
                enabled = true,
                leave_dirs_open = true,
            },
            group_empty_dirs = false,
            buffers = {
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = true,
                },
                group_empty_dirs = false,
            },
        },
        window = {
            mappings = {
                ["l"] = "open",
                ["h"] = "close_node",
                ["<space>"] = "none",
                ["O"] = {
                    function(state)
                        require("lazy.util").open(state.tree:get_node().path, { system = true })
                    end,
                    desc = "Open with System Application",
                },
                ["P"] = { "toggle_preview", config = { use_float = true } },
            },
        },
        default_component_configs = {
            container = {
                enable_character_fade = true
            },
            indent = {
                with_markers = false,
                with_expanders = true,
            },
        },
    }
}
