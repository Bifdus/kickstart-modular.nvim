return {
  {
    'rmagatti/auto-session',
    lazy = false,
    dependencies = {
      'nvim-telescope/telescope.nvim', -- Only needed if you want to use sesssion lens
    },
    config = function()
      require('auto-session').setup {
        close_unsupported_windows = true,
        auto_restore_enabled = false,
      }
    end,
  },
}
