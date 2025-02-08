require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  require 'plugins.colorscheme.dracula',

  -- import rest of plugins
  { import = 'plugins' },
  { import = 'plugins.snacks' },
  { import = 'plugins.coding' },
  { import = 'plugins.editor' },
  { import = 'plugins.lsp' },
  { import = 'plugins.ui' },
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
