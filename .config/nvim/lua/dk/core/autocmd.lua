local autocmd = require("dk.core.utils").autocmd

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, "checktime", {}, "checktime")

-- Highlight on Yank
autocmd("TextYankPost", "highlight_yank", { pattern = "*" }, function()
    vim.highlight.on_yank({
        higroup = "IncSearch",
        timeout = 40,
    })
end)

-- Go to last location when opening a buffer
autocmd("BufReadPost", "last_loc", {}, function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].dk_last_loc then
        return
    end
    vim.b[buf].dk_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
        pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
end)

-- Wrap and check for spelling in text filetypes
autocmd("FileType", "wrap_spell", { pattern = { "gitcommit", "markdown" } }, function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
end)
