-- Set Leader key --> " "
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Turn off builtin plugins.
require("dk.core.disable_builtin")
require("dk.core.options")
require("dk.core.keymap")
require("dk.core.autocmd")

-- Install `Lazy.nvim`
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    }
end
vim.opt.runtimepath:prepend(lazypath)

-- Setup `Lazy.nvim`
require("lazy").setup({ { import = "dk.plugins" }, { import = "dk.plugins.lsp" } }, {
    checker = {
        enabled = true,
        notify = false,
    },
    install = {
        colorscheme = { "catppuccin-mocha" },
    },
    ui = {
        icons = {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            source = "📄",
            start = "🚀",
            task = "📌",
        },
    },
})
