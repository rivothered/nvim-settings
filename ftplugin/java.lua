local jdtls = require('jdtls')

local mason_path = vim.fn.stdpath('data') .. '/mason'
local jdtls_path = mason_path .. '/packages/jdtls'

local launcher_jar = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
local os_name = vim.uv.os_uname().sysname

local platform_config
if os_name == "Darwin" then
    platform_config = jdtls_path .. '/config_mac'
elseif os_name == "Linux" then
    platform_config = jdtls_path .. '/config_linux'
elseif os_name:find("Windows") then
    platform_config = jdtls_path .. '/config_win'
else
    error("Unsupported operating system for jdtls: " .. os_name)
end

local java_debug_path = mason_path .. '/packages/java-debug-adapter'
local java_test_path = mason_path .. '/packages/java-test'

local bundles = {}
vim.list_extend(bundles, vim.split(
    vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar'),
    '\n'
))
vim.list_extend(bundles, vim.split(
    vim.fn.glob(java_test_path .. '/extension/server/*.jar'),
    '\n'
))

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspace/' .. project_name

local config = {
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-javaagent:' .. jdtls_path .. '/lombok.jar',
        '-jar', launcher_jar,
        '-configuration', platform_config,
        '-data', workspace_dir,
    },

    root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }),

    settings = {
        java = {
            eclipse = { downloadSources = true },
            configuration = { updateBuildConfiguration = "interactive" },
            maven = { downloadSources = true },
            implementationsCodeLens = { enabled = true },
            referencesCodeLens = { enabled = true },
            signatureHelp = { enabled = true },
        }
    },

    init_options = {
        bundles = bundles,
    },

    on_attach = function(client, bufnr)
        jdtls.setup_dap({ hotcodereplace = 'auto' })
        require('jdtls.dap').setup_dap_main_class_configs()
    end,
}

jdtls.start_or_attach(config)