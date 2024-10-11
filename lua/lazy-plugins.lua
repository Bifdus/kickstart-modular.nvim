require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  require 'kickstart/plugins/gitsigns',
  require 'kickstart/plugins/which-key',
  require 'kickstart/plugins/telescope',
  require 'kickstart/plugins/lspconfig',
  require 'kickstart/plugins/conform',
  require 'kickstart/plugins/cmp',
  require 'kickstart/plugins/todo-comments',
  require 'kickstart/plugins/mini',
  require 'kickstart/plugins/treesitter',
  require 'kickstart/plugins.indent_line',
  require 'kickstart/plugins.lint',
  require 'kickstart/plugins.autopairs',

  -- Check if Dracula Pro theme is available, otherwise use Tokyonight
  (function()
    local dracula_path = vim.fn.has 'linux' and vim.fn.expand '~/.local/share/nvim/site/pack/themes/start/dracula_pro'
      or vim.fn.expand 'C:/dracula_pro_2.1/themes/vim'

    if vim.fn.isdirectory(dracula_path) == 1 then
      return {
        dir = dracula_path,
        as = 'dracula_pro',
        config = function()
          vim.cmd 'syntax enable'
          vim.cmd 'colorscheme dracula_pro_van_helsing'
          -- Colors for orgmode headlines
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
      }
    else
      -- Fallback theme if Dracula Pro isn't available
      return {
        'folke/tokyonight.nvim',
        config = function()
          vim.cmd 'syntax enable'
          vim.cmd 'colorscheme tokyonight'
        end,
      }
    end
  end)(),

  -- import additional plugins from custom folder
  { import = 'custom.plugins' },
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
