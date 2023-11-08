return {
    "windwp/nvim-autopairs",
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
    event = { "InsertEnter" },
    config = function()
        local autopairs = require("nvim-autopairs")

        autopairs.setup({
            check_ts = true,                        -- Enable Treesitter
            ts_config = {
                lua = { "string" },                 -- Don't add pairs in lua string treesitter nodes
                javascript = { "template_string" }, -- Don't add pairs in javscript template_string treesitter nodes
                java = false,                       -- Don't check treesitter on java
            },
        })

        local cmp = require("cmp")
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
}
