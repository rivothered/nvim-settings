vim.lsp.config('*', {
    capabilities = require('blink.cmp').get_lsp_capabilities(),
})

vim.lsp.config.rust_analyzer = {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", ".git" },
    settings = {
        ['rust-analyzer'] = {
            checkOnSave = true,
	    check = {
	        command = "clippy",
	    }
        },
        completion = {
            autoimport = {
                enable = true,
            },
        },
        imports = {
            granularity = {
                group = "module",
            },
            prefix = "crate",
        },
        cargo = {
            allFeatures = true,
            buildScripts = { enable = true },
        },
        procMacro = { 
            enable = true 
        },
        completion = {
            autoimport = { enable = true },
        },
    }
}

vim.lsp.config.gopls = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.work", "go.mod", ".git" },
    settings = {
        gopls = {
            gofumpt = true,
            staticcheck = true,
            usePlaceholders = true,
            completeUnimported = true,
        },
    },
}

vim.lsp.enable('rust_analyzer')
vim.lsp.enable('gopls')
