return {
  {
    'brenoprata10/nvim-highlight-colors',
    event = { 'BufReadPre', 'BufNewFile' },
    config = {
      enabled = true,
      opts = {},
    },
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
