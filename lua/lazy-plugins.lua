-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --


  -- modular approach: using `require 'path/name'` will
  -- include a plugin definition from file lua/path/name.lua
  {

    dir = vim.fn.has 'linux' and vim.fn.expand '~/.local/share/nvim/site/pack/themes/start/dracula_pro'
      or vim.fn.expand 'C:/Users/z004syfa/Documents/dracula_pro_2.1/themes/vim',
    as = 'dracula_pro',
    config = function()
      --vim.cmd 'packadd! dracula_pro'

      vim.cmd 'syntax enable'
      vim.cmd 'colorscheme dracula_pro_van_helsing'

      -- RainbowDelimiter highlight groups using Dracula Pro colors
      vim.cmd [[
        highlight link RainbowDelimiterRed DraculaPink
        highlight link RainbowDelimiterYellow DraculaYellow
        highlight link RainbowDelimiterBlue DraculaPink
        highlight link RainbowDelimiterOrange DraculaOrange
        highlight link RainbowDelimiterGreen DraculaGreen
        highlight link RainbowDelimiterViolet DraculaPurple
        highlight link RainbowDelimiterCyan DraculaCyan
      ]]

      -- Autocommand to apply these settings whenever the colorscheme changes
      vim.cmd [[
        augroup RainbowDelimiters
          autocmd!
          autocmd ColorScheme dracula_pro highlight link RainbowDelimiterRed DraculaPink
          autocmd ColorScheme dracula_pro highlight link RainbowDelimiterYellow DraculaYellow
          autocmd ColorScheme dracula_pro highlight link RainbowDelimiterBlue DraculaPink
          autocmd ColorScheme dracula_pro highlight link RainbowDelimiterOrange DraculaOrange
          autocmd ColorScheme dracula_pro highlight link RainbowDelimiterGreen DraculaGreen
          autocmd ColorScheme dracula_pro highlight link RainbowDelimiterViolet DraculaPurple
          autocmd ColorScheme dracula_pro highlight link RainbowDelimiterCyan DraculaCyan
        augroup END
      ]]
    end,
  },
  require 'kickstart/plugins/gitsigns',

  require 'kickstart/plugins/which-key',

  require 'kickstart/plugins/telescope',

  require 'kickstart/plugins/lspconfig',

  require 'kickstart/plugins/conform',

  require 'kickstart/plugins/cmp',

  require 'kickstart/plugins/tokyonight',

  require 'kickstart/plugins/todo-comments',

  require 'kickstart/plugins/mini',

  require 'kickstart/plugins/treesitter',

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
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
