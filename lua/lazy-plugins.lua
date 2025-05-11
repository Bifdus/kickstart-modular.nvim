require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- import rest of plugins
  require 'plugins.core.lspconfig',
  require 'plugins.core.gitsigns',
  require 'plugins.core.cmp',
  require 'plugins.core.conform',
  require 'plugins.core.which-key',
  require 'plugins.core.lspconfig',
  require 'plugins.core.dracula',
  require 'plugins.core.treesitter',

  { import = 'plugins.languages' },
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
