return {
  'snacks.nvim',
  opts = {
    indent = {
      indent = {
        char = '│',
      },
      scope = {
        char = '│',
        only_current = true,
        underline = false,
        hl = 'DraculaComment',
      },
      animate = {
        enabled = false,
      },
    },
  },
  -- stylua: ignore
  keys = {
    { '<leader>ug', function() Snacks.toggle.indent():toggle() end, desc = 'Toggle Indent'},
  },
}
