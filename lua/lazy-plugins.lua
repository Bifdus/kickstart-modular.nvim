require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  require 'plugins.colorscheme.dracula',
  -- require 'plugins/gitsigns',
  -- require 'plugins/which-key',
  -- -- require 'plugins/telescope',
  -- require 'plugins/lspconfig',
  -- require 'plugins/conform',
  -- require 'plugins/cmp',
  -- require 'plugins/todo-comments',
  -- require 'plugins/mini',
  -- require 'plugins/treesitter',
  -- require 'plugins.indent_line',
  -- require 'plugins.lint',
  -- -- require 'kickstart/plugins.autopairs',

  -- import rest of plugins
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
