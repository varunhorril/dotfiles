return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local mason = require("mason")
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

        -- Enable Mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        -- List of LSP servers to install
        mason_lspconfig.setup({
            -- list of servers for mason to install
            ensure_installed = {
                "gopls",
                "lua_ls",
                "pyright",
                "rust_analyzer"
            },
            -- auto-install configured servers (with lspconfig)
            automatic_installation = true, -- not the same as ensure_installed
        })

        -- List of tools/formatters/linters to install
        mason_tool_installer.setup({
            ensure_installed = {
                "black",     -- Python formatter
                "gofumpt",   -- Stricter Go formatter (gofmt)
                "goimports", -- Go imports formatter
                "isort",     -- Python imports formatter
                "prettier",  -- Opiniated code formatter
                "pylint",    -- Python linter
                "stylua",    -- Lua formatter
            },
        })
    end
}
