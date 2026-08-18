local map = vim.keymap.set

map("i", "<S-Tab>", "<C-d>", { desc = "Decrease indent" })
map("n", "<S-Tab>", "<<", { desc = "Decrease indent" })
map("v", "<Tab>", ">gv", { desc = "Increase indent (keep selection)" })
map("v", "<S-Tab>", "<gv", { desc = "Decrease indent (keep selection)" })

map('n', '<leader>bn', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Next buffer/tab' })
map('n', '<leader>bp', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Previous buffer/tab' })
map('n', '<leader>bc', '<Cmd>bdelete<CR>', { desc = 'Close buffer/tab' })
map('n', '<leader>bk', '<Cmd>BufferLinePick<CR>', { desc = 'Pick buffer/tab' })

map('n', '<leader>vv', '<Cmd>Ex<CR>', { desc = 'Open explorer view' })
