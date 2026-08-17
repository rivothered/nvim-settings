require("mason").setup {
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
}

require("mason-tool-installer").setup {
    ensure_installed = {
        "rust-analyzer",
	    "codelldb",
        "gopls",
        "delve",
        "jdtls",
        "java-debug-adapter",
        "java-test",
    },

    auto_update = true,
    run_on_start = true,
    debounce_hours = 5,
}
