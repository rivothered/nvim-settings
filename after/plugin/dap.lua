local dap = require('dap')
local mason_bin_path = vim.fn.stdpath("data") .. "/mason/bin/"

dap.adapters.codelldb = {
    type = 'server',
    port = "${port}",
    executable = {
        command = mason_bin_path .. "codelldb",
        args = { "--port", "${port}" },
    }
}

local function get_cargo_package_name(cargo_toml_path)
    local file = io.open(cargo_toml_path, "r")
    if not file then
        return nil
    end

    local in_package_section = false
    for line in file:lines() do
        if line:match("^%[package%]") then
            in_package_section = true
        elseif line:match("^%[") then
            in_package_section = false
        elseif in_package_section then
            local name = line:match('^name%s*=%s*"(.-)"')
            if name then
                file:close()
                return name
            end
        end
    end

    file:close()
    return nil
end

local function find_cargo_toml(start_path)
    local path = start_path
    for _ = 1, 10 do
        local candidate = path .. "/Cargo.toml"
        if vim.fn.filereadable(candidate) == 1 then
            return candidate
        end
        local parent = vim.fn.fnamemodify(path, ":h")
        if parent == path then
            break
        end
        path = parent
    end
    return nil
end

local function get_rust_executable()
    vim.cmd("wa")

    local cwd = vim.fn.getcwd()
    local cargo_toml = find_cargo_toml(cwd)

    if not cargo_toml then
        vim.notify("Cargo.toml not found starting from: " .. cwd, vim.log.levels.ERROR)
        return vim.fn.input('Executable path: ', cwd .. '/target/debug/', 'file')
    end

    local package_name = get_cargo_package_name(cargo_toml)
    local project_root = vim.fn.fnamemodify(cargo_toml, ":h")

    if not package_name then
        vim.notify("Could not find 'name' under [package] in Cargo.toml", vim.log.levels.WARN)
        return vim.fn.input('Executable path: ', project_root .. '/target/debug/', 'file')
    end

    local default_path = project_root .. '/target/debug/' .. package_name

    vim.fn.system("pkill -f " .. vim.fn.shellescape(default_path))

    vim.notify("Building project (cargo build)...", vim.log.levels.INFO)
    local result = vim.fn.system("cd " .. vim.fn.shellescape(project_root) .. " && cargo build")

    if vim.v.shell_error ~= 0 then
        vim.notify("Build failed:\n" .. result, vim.log.levels.ERROR)
        return nil
    end

    vim.notify("Build finished: " .. default_path, vim.log.levels.INFO)

    return vim.fn.input('Executable path: ', default_path, 'file')
end

dap.configurations.rust = {
    {
        name = "Launch (Rust)",
        type = "codelldb",
        request = "launch",
        program = get_rust_executable,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
    },
}
