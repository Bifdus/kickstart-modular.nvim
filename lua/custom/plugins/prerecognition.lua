return {
  'tris203/precognition.nvim',
  event = 'VeryLazy',
  opts = { startVisible = false },
  config = function(_, opts)
    require('precognition').setup(opts)
  end,
  keys = {
    {
      '<leader>tp',
      function()
        require('precognition').toggle()
      end,
      desc = '[T]oggle [p]rerecognition',
    },
    {
      '<leader>pp',
      function()
        require('precognition').peek()
      end,
    },
    desc = '[p]rerecognition [p]eek',
  },
}
