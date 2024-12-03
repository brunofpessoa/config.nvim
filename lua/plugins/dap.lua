return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            -- "leoluz/nvim-dap-go",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
        },
        keys = {
            { "<Leader>d",   "",                                                                         desc = "+Debugger" },
            { "<Leader>dc",  "<CMD>DapContinue<CR>",                                                     desc = "Start/Continue" },
            { "<Leader>db",  "<CMD>DapToggleBreakpoint<CR>",                                             desc = "Toggle Brackpoint" },
            { "<Leader>di",  "<CMD>DapStepInto<CR>",                                                     desc = "Step Into" },
            { "<Leader>do",  "<CMD>DapStepOut<CR>",                                                      desc = "Step Out" },
            { "<Leader>dO",  "<CMD>DapStepOver<CR>",                                                     desc = "Step Over" },
            { "<Leader>dt",  "<CMD>DapTerminate<CR>",                                                    desc = "Terminate" },
            { "<Leader>d?",  "<CMD>lua require('dapui').eval(nil, { enter = true })<CR>",                desc = "Inspect under cursor" },
            { "<Leader>du",  "<CMD>lua require('dapui').toggle()<CR>",                                   desc = "+UI" },
            { "<Leader>dut", "<CMD>lua require('dapui').toggle()<CR>",                                   desc = "Toggle" },
            { "<Leader>duc", "<CMD>lua require('dapui').close()<CR>",                                    desc = "Close UI" },
            { "<Leader>duw", "<CMD>lua require('dapui').float_element('watches', { enter = true })<CR>", desc = "Watches" },
            { "<Leader>dus",  "<CMD>lua require('dapui').float_element('scopes', { enter = true })<CR>",  desc = "Scopes" },
        },
        config = function()
            local dap = require "dap"
            local ui = require "dapui"

            require("dapui").setup()
            -- require("dap-go").setup()
            require("nvim-dap-virtual-text").setup()

            dap.adapters.chrome = {
                type = "executable",
                command = "node",
                args = { vim.fn.stdpath("data") .. "/mason/packages/chrome-debug-adapter/out/src/chromeDebug.js" },
            }
            -- to launch chrome manually: `google-chrome --remote-debugging-port=9222`

            local js_based = { "javascript", "javascriptreact", "typescript", "typescriptreact", "angular" }

            for _, lang in pairs(js_based) do
                dap.configurations[lang] = {
                    {
                        name = "launch chrome",
                        type = "chrome",
                        request = "launch",
                        program = "${file}",
                        cwd = vim.fn.getcwd(),
                        sourceMaps = true,
                        protocol = "inspector",
                        port = 9222,
                        webRoot = "${workspaceFolder}"
                    },
                    {
                        name = "attach to chrome",
                        type = "chrome",
                        request = "attach",
                        program = "${file}",
                        cwd = vim.fn.getcwd(),
                        sourceMaps = true,
                        protocol = "inspector",
                        port = 9222,
                        webRoot = "${workspaceFolder}"
                    }

                }
            end

            dap.listeners.before.attach.dapui_config = ui.open
            dap.listeners.before.launch.dapui_config = ui.open
            dap.listeners.before.event_terminated.dapui_config = ui.close
            dap.listeners.before.event_exited.dapui_config = ui.close
        end,
    },
}
