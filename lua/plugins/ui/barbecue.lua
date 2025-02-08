return {
  -----------------------------------------------------------------------------
  -- VS Code like winbar
  {
    'utilyre/barbecue.nvim',
    dependencies = { 'SmiteshP/nvim-navic', 'nvim-tree/nvim-web-devicons' },
    keys = {
      {
        '<Leader>tB',
        function()
          local off = vim.b['barbecue_entries'] == nil
          require('barbecue.ui').toggle(off and true or nil)
        end,
        desc = 'Breadcrumbs toggle',
      },
    },
    opts = {
      enable = true,
      attach_navic = true,
      show_dirname = false,
      show_modified = true,
      -- kinds = kind_icons, -- Uncomment if you have kind_icons defined
      symbols = { separator = '' },
    },
    config = function(_, opts)
      require('barbecue').setup(opts)
    end,
  },
  {
    'nosduco/remote-sshfs.nvim',
    -- dependencies = { 'nvim-telescope/telescope.nvim' },
    opts = {
      -- Refer to the configuration section below
      -- or leave empty for defaults
    },
  },
}
