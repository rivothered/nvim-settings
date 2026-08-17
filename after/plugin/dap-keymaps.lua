local dap = require('dap')
local dapui = require('dapui')

local map = vim.keymap.set

map('n', '<F5>', dap.continue, { desc = 'DAP: Continue/Start' })
map('n', '<F10>', dap.step_over, { desc = 'DAP: Step Over' })
map('n', '<F11>', dap.step_into, { desc = 'DAP: Step Into' })
map('n', '<F12>', dap.step_out, { desc = 'DAP: Step Out' })

map('n', '<leader>db', dap.toggle_breakpoint, { desc = 'DAP: Toggle Breakpoint' })
map('n', '<leader>dB', function()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, { desc = 'DAP: Conditional Breakpoint' })

map('n', '<leader>dc', dap.continue, { desc = 'DAP: Continue' })
map('n', '<leader>dt', dap.terminate, { desc = 'DAP: Terminate' })
map('n', '<leader>dr', dap.repl.open, { desc = 'DAP: Open REPL' })

map('n', '<leader>du', dapui.toggle, { desc = 'DAP: Toggle UI' })

map('n', '<leader>dh', function()
    require('dap.ui.widgets').hover()
end, { desc = 'DAP: Hover (inspect