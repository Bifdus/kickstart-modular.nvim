return {
  -----------------------------------------------------------------------------
  -- Vimscript syntax / highlight pugin
  {
    'fei6409/log-highlight.nvim',
    config = function()
      require('log-highlight').setup {
        extension = { 'log', 'txt' },
      }
    end,
  },
  -----------------------------------------------------------------------------
  -- Highlight, edit, navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufReadPost',
    build = ':TSUpdate',
    dependencies = {
      'nvim-treesitter/playground',
      'HiPhish/rainbow-delimiters.nvim',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'folke/snacks.nvim',
    },
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'c_sharp',
        'cpp',
        'css',
        'diff',
        'html',
        'json',
        'java',
        'javascript',
        'typescript',
        'tsx',
        'lua',
        'luadoc',
        'markdown',
        'org',
        'php',
        'phpdoc',
        'python',
        'sql',
        'vim',
        'vimdoc',
        'regex',
        'latex',
        'markdown_inline',
      },
      auto_install = true,
      -- ignore_install = { 'org' },
      highlight = {
        enable = true,
        disable = { 'org' },
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby', 'org' },
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
      -- disabling to use mini.ai
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['ap'] = '@parameter.outer',
            ['ip'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@call.outer',
            ['ic'] = '@call.inner',
            ['al'] = '@loop.outer',
            ['il'] = '@loop.inner',
            ['in'] = '@number.inner',
            ['an'] = '@number.inner', -- There is no number.outer
            ['ab'] = '@block.outer',
            ['ib'] = '@block.inner',
            ['ar'] = '@return.outer',
            ['ir'] = '@return.inner',
            ['av'] = '@conditional.outer',
            ['iv'] = '@conditional.inner',
          },
        },
        move = {
          enable = false,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']a'] = '@parameter.inner',
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
            [']l'] = '@loop.outer',
            [']b'] = '@block.outer',
            [']r'] = '@return.outer',
            [']n'] = '@number.inner',
            [']v'] = '@conditional.inner',
          },
          goto_next_end = {
            [']A'] = '@parameter.outer',
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
            [']L'] = '@loop.outer',
            [']B'] = '@block.outer',
            [']R'] = '@return.outer',
            [']N'] = '@number.inner',
            [']V'] = '@conditional.inner',
          },
          goto_previous_start = {
            ['[a'] = '@parameter.inner',
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
            ['[l'] = '@loop.outer',
            ['[b'] = '@block.outer',
            ['[r'] = '@return.outer',
            ['[n'] = '@number.inner',
            ['[v'] = '@conditional.outer',
          },
          goto_previous_end = {
            ['[A'] = '@parameter.outer',
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
            ['[L'] = '@loop.outer',
            ['[B'] = '@block.outer',
            ['[R'] = '@return.outer',
            ['[N'] = '@number.inner',
            ['[V'] = '@conditional.outer',
          },
        },
        swap = {
          enable = false,
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
        },
      },
      -- Autoinstall languages that are not installed
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      require('rainbow-delimiters.setup').setup {
        strategy = {
          -- [''] = rainbow_delimiters.strategy['global'],
          -- commonlisp = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          latex = 'rainbow-blocks',
        },
        -- highlight = {
        --   'RainbowDelimiterRed   ',
        --   'RainbowDelimiterYellow',
        --   'RainbowDelimiterBlue  ',
        --   'RainbowDelimiterOrange',
        --   'RainbowDelimiterGreen ',
        --   'RainbowDelimiterViolet',
        --   'RainbowDelimiterCyan  ',
        -- },
        blacklist = { 'c', 'cpp' },
      }
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      vim.keymap.set('n', '<leader>tH', '<CMD>TSPlaygroundToggle<CR>', { desc = '[t]oggle treesitter playground [h]ighlight groups', silent = true })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
