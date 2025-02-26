require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- import rest of plugins
  --
  -- require 'plugins/lsp/gitsigns',
  -- require 'plugins/lsp/lspconfig',
  -- require 'plugins/lsp/conform',
  -- require 'plugins/lsp/cmp',
  -- require 'plugins/lsp.lint',
  { import = 'plugins.setup' },
  { import = 'plugins' },
  { import = 'plugins.snacks' },
}, {
  ui = {
    -- Icons if nerd font found
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
