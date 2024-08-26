return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'windwp/nvim-ts-autotag',
      'nvim-treesitter/playground',
      'HiPhish/rainbow-delimiters.nvim',
      { 'nvim-treesitter/nvim-treesitter-context', lazy = true, event = 'VeryLazy' },
    },
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
      -- Additional Plugins
      playground = {
        enable = true,
        disable = {},
        updatetime = 25,
        persist_queries = false,
        keybindings = {
          toggle_query_editor = 'o',
          toggle_hl_groups = 'i',
          toggle_injected_languages = 't',
          toggle_anonymous_nodes = 'a',
          toggle_language_display = 'I',
          focus_language = 'f',
          unfocus_language = 'F',
          update = 'R',
          goto_node = '<cr>',
          show_help = '?',
        },
      },
      context = {
        enable = true,
        max_lines = 15,
        trim_scope = 'inner',
      },
      -- Autoinstall languages that are not installed
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
      require('treesitter-context').setup(opts.context)

      require('rainbow-delimiters.setup').setup {
        strategy = {
          -- [''] = rainbow_delimiters.strategy['global'],
          -- commonlisp = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          latex = 'rainbow-blocks',
          tsx = 'rainbow-parens',
        },
        highlight = {
          'EldritchBlue',
          'EldritchPink',
          'EldritchPurple',
          'EldritchGreen',
        },
        blacklist = { 'c', 'cpp' },
      }
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
      vim.keymap.set('n', '<leader>tc', '<CMD>TSContextToggle<CR>', { desc = '[t]oggle treesitter [c]ontext', silent = true })
      vim.keymap.set('n', '<leader>tH', '<CMD>TSPlaygroundToggle<CR>', { desc = '[t]oggle treesitter playground [h]ighlight groups', silent = true })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
