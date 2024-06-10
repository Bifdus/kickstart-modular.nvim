return {
  {
    'petertriho/nvim-scrollbar',
    event = 'BufReadPost',
    opts = { show = true, excluded_filetypes = { 'NvimTree' } },
  },
}
