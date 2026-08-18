local dap = require('dap')

local watched_ports = { 3000, 8000, 8080, 8081, 8082, 8083, 8084, 8085 }

local function kill_port(port)
    vim.fn.system("lsof -ti tcp:" .. port .. " | xargs -r kill -9")
end

vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        if dap.session() then
            dap.terminate()
            dap.close()
        end

        for _, port in ipairs(watched_ports) do
            kill_port(port)
        end
    end,
})