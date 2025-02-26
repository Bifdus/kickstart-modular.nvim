return {
  -----------------------------------------------------------------------------
  -- Python venv selector
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      'mfussenegger/nvim-dap-python', --optional
      -- { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
    },
    lazy = true,
    ft = 'python',
    branch = 'regexp', -- This is the regexp branch, use this for the new version
    config = function()
      require('venv-selector').setup()
    end,
    keys = {
      { '<leader>cvs', '<cmd>VenvSelect<cr>' },
      { '<leader>cvc', '<cmd>VenvSelectCached<cr>' },
    },
  },
}
