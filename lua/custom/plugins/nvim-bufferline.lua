return {
  {
    'akinsho/bufferline.nvim',
    version = '*',
    config = function()
      require('bufferline').setup {
        options = {
          offsets = {
            {
              filetype = 'neo-tree',
              text = 'Neo-tree',
              highlight = 'Directory',
              text_align = 'left',
            },
          },
          dependencies = 'nvim-tree-web-devicons',
        },
      }
    end,
  },
}
