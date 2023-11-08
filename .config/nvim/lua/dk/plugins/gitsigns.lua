-- Git decorations for buffers
return {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
        signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
        }
    },
    on_attach = function(bufnr)
        local map = require("dk.core.utils").map
        local gs = package.loaded.gitsigns

        map("n", "<leader>ph", require("gitsigns").preview_hunk, { buffer = bufnr, desc = "Preview git hunk" })

        map({ "n", "v" }, "]c", function()
            if vim.wo.diff then
                return "]c"
            end
            vim.schedule(function()
                gs.next_hunk()
            end)
            return "<Ignore>"
        end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })

        map({ "n", "v" }, "[c", function()
            if vim.wo.diff then
                return "[c"
            end
            vim.schedule(function()
                gs.prev_hunk()
            end)
            return "<Ignore>"
        end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
    end
}
