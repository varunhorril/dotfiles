-- Debug Adapter Protocol client
return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "jay-babu/mason-nvim-dap.nvim",

        -- Add additional debuggers here
        "leoluz/nvim-dap-go",
        "mfussenegger/nvim-dap-python",
    },
    event = "VeryLazy",
    config = function()
        local mason_nvim_dap = require("mason-nvim-dap")

        mason_nvim_dap.setup({
            automatic_setup = true,
            handlers = {},       -- Can provide additional configuration to handlers
            ensure_installed = { -- Update debuggers here based on the language being used
                "codelldb",      -- Rust debugger
                "delve",         -- Go debugger
                "debugpy",       -- Python debugger
            }
        })

        local dap = require("dap")
        local map = require("dk.core.utils").map

        map("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
        map("n", "<F7>", dap.step_into, { desc = "Debug: Step Into" })
        map("n", "<F8>", dap.step_over, { desc = "Debug: Step Over" })
        map("n", "<S-F8>", dap.step_out, { desc = "Debug: Step Out" })
        map("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
        map("n", "<leader>B", function() dap.set_breakpoint(vim.fn.input "Breakpoint condition: ") end,
            { desc = "Debug: Set Breakpoint" })

        local dapui = require("dapui")

        dapui.setup({
            -- Set icons to characters that are more likely to work in every terminal.
            icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            controls = {
                icons = {
                    pause = '⏸',
                    play = '▶',
                    step_into = '⏎',
                    step_over = '⏭',
                    step_out = '⏮',
                    step_back = 'b',
                    run_last = '▶▶',
                    terminate = '⏹',
                    disconnect = '⏏',
                },
            },
        })

        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        map("n", "<S-F7>", dapui.toggle, { desc = "Debug: See last session result." })

        dap.listeners.after.event_initialized["dapui_config"] = dapui.open
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close

        -- Install golang specific config
        require("dap-go").setup()
    end
}
