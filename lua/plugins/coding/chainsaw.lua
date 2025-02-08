return {
  -----------------------------------------------------------------------------
  -- Quick log lines with smart variable identification, only python, lua and JS
  {
    'chrisgrieser/nvim-chainsaw',
    opts = {
      logStatements = {
        variableLog = {
          nvim_lua = 'vim.notify("%s %s", vim.inspect(%s))',
        },
      },
    },
  },
}
