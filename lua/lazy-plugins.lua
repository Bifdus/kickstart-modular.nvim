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
  -- NOTE: Comment this out if not using dracula theme
  {

    dir = vim.fn.has 'linux' and vim.fn.expand '~/.local/share/nvim/site/pack/themes/start/dracula_pro' or vim.fn.expand 'C:/dracula_pro_2.1/themes/vim',
    as = 'dracula_pro',
    config = function()
      --vim.cmd 'packadd! dracula_pro'

      vim.cmd 'syntax enable'
      vim.cmd 'colorscheme dracula_pro_van_helsing'
      -- Colors for rainbow highlights

      vim.cmd [[highlight Headline1 guibg=#1e2718]]
      vim.cmd [[highlight Headline2 guibg=#21262d]]
      vim.cmd [[highlight CodeBlock guibg=#1c1c1c]]
      vim.cmd [[highlight Dash guibg=#D19A66 gui=bold]]

      -- Colors for rainbow highlights
      vim.cmd [[
        highlight RainbowDelimiterRed    guifg=#FF7687 ctermfg=9,
        highlight RainbowDelimiterYellow guifg=#f2f200 ctermfg=11,
        highlight RainbowDelimiterBlue   guifg=#2CCCFF ctermfg=12,
        highlight RainbowDelimiterOrange guifg=#fcbf7a ctermfg=1,
        highlight RainbowDelimiterGreen  guifg=#00c790 ctermfg=4,
        highlight RainbowDelimiterViolet guifg=#BD93F9 ctermfg=5,
        highlight RainbowDelimiterCyan   guifg=#80FFEA ctermfg=13,
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
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.neo-tree',

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
