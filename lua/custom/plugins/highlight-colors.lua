return {
  {
    'brenoprata10/nvim-highlight-colors',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      enable_short_hex = false,
    },
    config = function(_, opts)
      require('nvim-highlight-colors').setup(opts)
    end,
    keys = {
      {
        '<leader>tC',
        function()
          require('nvim-highlight-colors').toggle()
        end,
        desc = '[T]oggle highlight [c]olors',
      },
    },
  },
}
