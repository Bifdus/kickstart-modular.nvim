return {
  -----------------------------------------------------------------------------
  -- Improved jumps
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      modes = {
        char = {
          enabled = true,
        },
      },
    },
    -- stylua: ignore
    keys = {
      {';', mode ={'n', 'x', 'o'}, false},
      {',', mode ={'n', 'x', 'o'}, false},
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'flash',
      },
      -- {
      --   't',
      --   mode = { 'n', 'x', 'o' },
      --   function()
      --     require('flash').treesitter_search()
      --   end,
      --   desc = 'flash treesitter',
      -- },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'S',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<leader>tf',
        mode = { 'n' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
  },
}
