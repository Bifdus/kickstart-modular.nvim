return {
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>bn', '<Cmd>BufferLineCycleNext<CR>', desc = 'Next tab' },
      { '<leader>bb', '<Cmd>BufferLineCyclePrev<CR>', desc = 'Prev tab' },
    },
    opts = {
      options = {
        mode = 'tabs',
        debug = {
          logging = true,
        },
        version = '*',
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'File Explorer',
            highlight = 'Directory',
            separator = true,
          },
        },
        dependencies = 'nvim-tree-web-devicons',
      },
    },
  },
}
