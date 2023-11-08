-- Mark and navigate to files
return {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local map = require("dk.core.utils").map
        local ui = require("harpoon.ui")

        map("n", "<leader>hm", require("harpoon.mark").add_file, { desc = "Mark file with harpoon" })
        map("n", "<leader>hq", ui.toggle_quick_menu, { desc = "Open the harpoon quick menu" })
        map("n", "<leader>hn", ui.nav_next, { desc = "Go to the next harpoon mark" })
        map("n", "<leader>hp", ui.nav_prev, { desc = "Go to the previous harpoon mark" })

        -- Switch to any mark (from 1 - 5)
        for i = 1, 5 do
            map("n", string.format("<space>%s", i), function() ui.nav_file(i) end,
                { desc = "Switch to any mark (from 1 - 5)" })
        end
    end
}
