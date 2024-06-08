return {
  {
    'petertriho/nvim-scrollbar',
    config = function()
      require('scrollbar').setup {
        show = true,
        excluded_filetypes = { 'NvimTree' },
      }
    end,
  },
}
