local autocmd = require("dk.core.utils").autocmd
local opt = vim.opt

-- Line numbers
opt.number = true -- Shows absolute line number on cursor line (when relative number is on)
opt.relativenumber = true -- Show relative line numbers

-- Tabs & indentation
opt.autoindent = true -- Copy indent from current line when starting new one
opt.cindent = true -- Enables automatic C program indenting
opt.expandtab = true -- Expand tab to spaces
opt.shiftwidth = 4 -- 4 spaces for indent width
opt.softtabstop = 4 -- 4 spaces for tabs
opt.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for

-- Line wrapping
opt.wrap = false -- Disable line wrapping

-- Search settings
opt.hlsearch = false -- Do not highlight search terms
opt.ignorecase = true -- Ignore case when searching
opt.incsearch = true -- Makes search act like search in modern browsers
opt.smartcase = true -- If you include mixed case in your search, assumes you want case-sensitive

-- Cursor line
opt.cursorline = true -- Highlight the current cursor line
opt.guicursor = "" -- Set the cursor to block in insert mode
opt.scrolloff = 10 -- Make it so there are always ten lines below my cursor

local set_cursorline = function(event, value, pattern)
  autocmd(event, "CursorLineControl", { pattern = pattern }, function()
    vim.opt_local.cursorline = value
  end)
end

set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")

-- Appearance
--
-- Turn on termguicolors for catpuccin colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.background = "dark" -- Colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- Show sign column so that text doesn't shift
opt.showcmd = true
opt.showmode = false
opt.termguicolors = true

-- Popup menu for completion on command line
opt.pumblend = 17
opt.wildmode = "longest:full"
opt.wildoptions = "pum"

-- Backspace
opt.backspace = "indent,eol,start" -- Allow backspace on indent, end of line or insert mode start position

-- Clipboard
opt.clipboard:append("unnamedplus") -- Use system clipboard as default register

-- Split windows
opt.splitright = true -- Split vertical window to the right
opt.splitbelow = true -- Split horizontal window to the bottom

-- Turn off swapfile and backups
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- Undo
opt.undofile = true -- Save undo history by default
opt.undolevels = 100 -- Max number of changes that can be undone

-- Folding
opt.foldmethod = "marker" -- Use markers to specify folds
opt.foldlevel = 99 -- Folding when above 99

-- Misc
opt.belloff = "all" -- Turn the bell off
opt.mouse = "a" -- Enable mouse mode
opt.updatetime = 300 -- Make updates happen faster
