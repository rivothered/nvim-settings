vim.opt.termguicolors = true
vim.o.background = "dark"

vim.cmd.colorscheme("horizon")

vim.opt.laststatus = 2

vim.opt.fillchars:append({ vert = "┃" })
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#7a88cf", bg = "none" })
        vim.api.nvim_set_hl(0, "StatusLine", { fg = "#c8ccd4", bg = "#2a2e3d" })
        vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#5c6370", bg = "#1e2130" })
    end,
})

vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#7a88cf", bg = "none" })
vim.api.nvim_set_hl(0, "StatusLine", { fg = "#c8ccd4", bg = "#2a2e3d" })
vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#5c6370", bg = "#1e2130" })