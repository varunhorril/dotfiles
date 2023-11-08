-- Add/change/delete surrounding delimiter pairs with ease
-- add: ys{motion}{char}
-- delete: ds{motion}{char}
-- change: cs{motion}{char}
return {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = { "BufReadPre", "BufNewFile" },
    config = true
}
