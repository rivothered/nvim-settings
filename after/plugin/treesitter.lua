local ts = require("nvim-treesitter")

local parsers = {
    "go",
    "lua",
    "rust",
    "java",
    "markdown",
    "markdown_inline",
}

ts.install(parsers)

vim.api.nvim_create_autocmd("FileType", {
  pattern = parsers,
  callback = function()
    local lang = vim.treesitter.language.get_lang(vim.bo.filetype) or vim.bo.filetype
    if vim.treesitter.language.add(lang) then
      vim.treesitter.start()
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
