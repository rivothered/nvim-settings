vim.keymap.set("i", "<S-Tab>", "<C-d>", { desc = "Decrease indent" })
vim.keymap.set("n", "<S-Tab>", "<<", { desc = "Decrease indent" })
vim.keymap.set("v", "<Tab>", ">gv", { desc = "Increase indent (keep selection)" })
vim.keymap.set("v", "<S-Tab>", "<gv", { desc = "Decrease indent (keep selection)" })