return {
    "lewis6991/gitsigns.nvim",
    opts = {
        signs = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "" },
            topdelete = { text = "" },
            changedelete = { text = "▎" },
            untracked = { text = "▎" },
        },
        signs_staged = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "" },
            topdelete = { text = "" },
            changedelete = { text = "▎" },
        },
        on_attach = function(buffer)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, desc)
                vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
            end

            -- stylua: ignore start
            map("n", "]h", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gs.nav_hunk("next")
                end
            end, "Next Hunk")
            map("n", "[h", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gs.nav_hunk("prev")
                end
            end, "Prev Hunk")
            require("util.keymap").set_all({
                { { "n", "v" }, "<leader>g", "", "+Git" },
                { { "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk" },
                { { "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk" },
                { "n", "<leader>gd", gs.diffthis, "Diff This" },
                { "n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~" },
                { "n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk" },
                { "n", "<leader>gp", gs.preview_hunk_inline, "Preview Hunk Inline" },
                { "n", "<leader>gb", function() gs.blame_line({ full = false }) end, "Blame Line" },
                { "n", "<leader>gS", gs.stage_buffer, "Stage Buffer" },
                { "n", "<leader>gR", gs.reset_buffer, "Reset Buffer" },
                { "n", "<leader>gB", function() gs.blame() end, "Blame Buffer" },
            })
        end,
    }
}
