local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not (vim.uv or vim.loop).fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

require('pckr').add {
  "WhoIsSethDaniel/mason-tool-installer.nvim";
  "mfussenegger/nvim-dap";
  "mason-org/mason.nvim";
  "neovim/nvim-lspconfig";
  "leoluz/nvim-dap-go";
  "mfussenegger/nvim-jdtls";
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
  },
  {
    "saghen/blink.cmp",
    requires = "saghen/blink.lib",
    run = function()
        require("blink.cmp").build():pwait()
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    requires = "nvim-neotest/nvim-nio",
  },
}
