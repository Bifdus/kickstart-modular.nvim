return {
  --- Better Visual for help files
  {
    'OXY2DEV/helpview.nvim',
    -- lazy = false, -- Recommended
    ft = 'help',

    -- In case you still want to lazy load
    -- ft = "help",

    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },
}
