return {
  {
    'luckasRanarison/nvim-devdocs',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- 'nvim-telescope/telescope.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    keys = {
      -- { '<leader>sa', '<cmd>DevdocsOpen<cr>', desc = 'Devdocs' },
      { '<leader>sa', '<cmd>DevdocsOpenCurrent<cr>', desc = 'Devdocs Current' },
    },
    opts = {},
  },
}
