return {
  {
    'mbbill/undotree',
    event = 'VeryLazy',
    config = function()
      vim.g.undotree_WindowLayout = 3 -- right side
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_SplitWidth = 40
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
    end,
  },
}
