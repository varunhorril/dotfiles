return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "j-hui/fidget.nvim", opts = {} }
    },
    event = "VeryLazy",
    config = function()
        local on_attach = function(_, bufnr)
            -- Define specific keymaps for LSP related items
            local keymap = function(keys, func, desc)
                local map = require("dk.core.utils").map
                map("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
            end

            keymap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
            keymap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
            keymap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
            keymap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
            keymap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
            keymap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
            keymap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
            keymap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
            keymap("K", vim.lsp.buf.hover, "Hover Documentation")
            keymap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
            keymap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

            -- Command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_) vim.lsp.buf.format() end,
                { desc = 'Format current buffer with LSP' })
        end

        -- Change the Diagnostic symbols in the sign column
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end


        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

        -- Configure gopls
        lspconfig.gopls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                gopls = {
                    gofumpt = true,
                    completeUnimported = true,
                    staticcheck = true,
                    usePlaceholders = true,
                    analyses = {
                        nilness = true,
                        useany = true,
                        unusedparams = true
                    },
                    codelenses = {
                        gc_details = false,
                        generate = true,
                        run_govulncheck = true,
                        test = true,
                        tidy = true,
                        upgrade_dependency = true,
                        vendor = true,
                    },
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        compositeLiteralTypes = true,
                        constantValues = true,
                        functionTypeParameters = true,
                        parameterNames = true,
                        rangeVariableTypes = true,
                    },
                },
            },
            flags = {
                debounce_text_changes = 150,
            },
        })

        -- Configure lua_ls server
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "/lua"] = true,
                        },
                    },
                },
            },
        })

        -- Configure pyright
        lspconfig.pyright.setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- Configure rust_analyzer
        lspconfig.rust_analyzer.setup({
            capabilities = capabilities,
            on_attach = on_attach,
            cmd = {
                "rustup", "run", "stable", "rust-analyzer",
            }
        })
    end
}
