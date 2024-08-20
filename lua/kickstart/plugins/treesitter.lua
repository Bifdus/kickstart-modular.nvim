return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'c_sharp',
        'cpp',
        'diff',
        'html',
        'json',
        'java',
        'javascript',
        'typescript',
        'lua',
        'luadoc',
        'markdown',
        'php',
        'phpdoc',
        'python',
        'sql',
        'vim',
        'vimdoc',
        'regex',
        'latex',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      fold = { true },
      indent = { enable = true, disable = { 'ruby' } },
      dependencies = { 'windwp/nvim-ts-autotag' },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'VeryLazy',
    dependencies = { 'nvim-treesitter/nvim-treesitter', lazy = true },
    config = function()
      require('treesitter-context').setup {
        max_lines = 15,
        trim_scope = 'inner',
        -- multiline_threshold = 1,
        -- throttle = true,
      }

      vim.keymap.set('n', '<leader>tc', '<CMD>TSContextToggle<CR>', { desc = '[t]oggle treesitter [c]ontext', silent = true })
    end,
  },
  {
    'HiPhish/rainbow-delimiters.nvim',
    event = 'VeryLazy',
  },
  {
    'luckasRanarison/nvim-devdocs',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    keys = {
      -- { '<leader>sa', '<cmd>DevdocsOpen<cr>', desc = 'Devdocs' },
      { '<leader>sa', '<cmd>DevdocsOpenCurrent<cr>', desc = 'Devdocs Current' },
    },
    opts = {},
  },
}
-- vim: ts=2 sts=2 sw=2 et
