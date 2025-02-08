return {
  -----------------------------------------------------------------------------
  -- Returns you to last place in file when reopening
  { 'ethanholz/nvim-lastplace', opts = {} },
  {
    'uga-rosa/ccc.nvim',
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
        filetypes = {
          'html',
          'lua',
          'css',
          'scss',
          'sass',
          'less',
          'stylus',
          'javascript',
          'javascriptreact',
          'tmux',
          'json',
          'typescript',
          'typescriptreact',
        },
        excludes = { 'lazy', 'mason', 'help' },
      },
    },
  },
}
