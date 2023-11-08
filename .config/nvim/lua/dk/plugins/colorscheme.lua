return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            -- flavors:  catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
            vim.cmd([[colorscheme catppuccin-mocha]])
        end,
        opts = {
            flavour = "mocha", -- latte, frappe, macchiato, mocha
            integrations = {
                alpha = true,
                cmp = true,
                gitsigns = true,
                illuminate = true,
                indent_blankline = { enabled = true },
                lsp_trouble = true,
                mason = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                semantic_tokens = true,
                telescope = true,
                treesitter = true,
                which_key = true,
            },
        }
    }
}
