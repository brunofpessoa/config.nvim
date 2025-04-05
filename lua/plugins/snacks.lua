return {
    "folke/snacks.nvim",
    -- keys = {
    --     { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    --     { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" }
    -- },
    disabled = true,
    opts = {
        indent = {
            chunk = {
                enabled = true,
                char = {
                    corner_top = "╭",
                    corner_bottom = "╰",
                    arrow = "",
                },
            }
        },
        scratch = {},
        bigfile = {},
    },
    -- config = function ()
    --
    -- end
}
