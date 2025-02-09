require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  require 'plugins.colorscheme.dracula',

  -- import rest of plugins
  --
  require 'plugins/lsp/gitsigns',
  require 'plugins/editor/which-key',
  require 'plugins/lsp/lspconfig',
  require 'plugins/lsp/conform',
  require 'plugins/lsp/cmp',
  require 'plugins/lsp.lint',
  { import = 'plugins.lsp' },
  { import = 'plugins' },
  { import = 'plugins.coding' },
  { import = 'plugins.editor' },
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
