return {
  -----------------------------------------------------------------------------
  -- Leetcode Problems
  {
    'kawre/leetcode.nvim',
    build = ':TSUpdate html',
    cmd = 'Leet',
    dependencies = {
      -- 'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim', -- required by telescope
      'MunifTanjim/nui.nvim',

      -- optional
      'nvim-treesitter/nvim-treesitter',
      'rcarriga/nvim-notify',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      -- configuration goes here
      lang = 'python3',
    },
  },
  {
    'roobert/f-string-toggle.nvim',
    config = function()
      require('f-string-toggle').setup {
        key_binding = '<leader>f',
        key_binding_desc = 'Toggle f-string',
      }
    end,
  },
}
