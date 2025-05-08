return {
  -----------------------------------------------------------------------------
  -- Quick log lines with smart variable identification, only python, lua and JS
  {
    'chrisgrieser/nvim-chainsaw',
    opts = {
      logStatements = {
        variableLog = {
          nvim_lua = 'vim.notify("%s %s", vim.inspect(%s))',
        },
      },
    },
  },

  -----------------------------------------------------------------------------
  -- Comments, with context
  {
    'numToStr/Comment.nvim',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    ft = { 'javascriptreact', 'typescriptreact' },
    keys = {
      { '<Leader>V', '<Plug>(comment_toggle_blockwise_current)', mode = 'n', desc = 'Comment', ft = { 'typescriptreact', 'javascriptreact' } },
      { '<Leader>V', '<Plug>(comment_toggle_blockwise_visual)', mode = 'x', desc = 'Comment', ft = { 'typescriptreact', 'javascriptreact' } },
    },
    opts = function(_, opts)
      local ok, tcc = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
      if ok then
        opts.pre_hook = tcc.create_pre_hook()
      end
    end,
  },

  -- {
  --   'luckasRanarison/nvim-devdocs',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     -- 'nvim-telescope/telescope.nvim',
  --     'nvim-treesitter/nvim-treesitter',
  --   },
  --   keys = {
  --     -- { '<leader>sa', '<cmd>DevdocsOpen<cr>', desc = 'Devdocs' },
  --     { '<leader>sa', '<cmd>DevdocsOpenCurrent<cr>', desc = 'Devdocs Current' },
  --   },
  --   opts = {},
  -- },
  --
  --
  {
    'stevearc/aerial.nvim',
    opts = {
      on_attach = function(bufnr)
        -- Jump forwards/backwards with '{' and '}'
        vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
        vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
      end,
    },
    config = function(_, opts)
      require('aerial').setup(opts)
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },

  {
    'akinsho/git-conflict.nvim',
    event = 'BufReadPost',
    version = '*',
    config = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'GitConflictDetected',
        callback = function()
          vim.notify('Conflict detected in ' .. vim.fn.expand '<afile>')
        end,
      })

      require('git-conflict').setup {
        debug = true,
        default_mappings = true, -- disable buffer local mapping created by this plugin
        default_commands = true, -- disable commands created by this plugin
        disable_diagnostics = true, -- This will disable the diagnostics in a buffer whilst it is conflicted
        list_opener = 'copen', -- command or function to open the conflicts list
        highlights = { -- They must have background color, otherwise the default color will be used
          incoming = 'DiffText',
          current = 'DiffAdd',
        },
      }
    end,
    keys = {
      { '<Leader>gcb', '<cmd>GitConflictChooseBoth<CR>', desc = 'choose both' },
      { '<Leader>gcn', '<cmd>GitConflictNextConflict<CR>', desc = 'move to next conflict' },
      { '<Leader>gcc', '<cmd>GitConflictChooseOurs<CR>', desc = 'choose current' },
      { '<Leader>gcp', '<cmd>GitConflictPrevConflict<CR>', desc = 'move to prev conflict' },
      { '<Leader>gci', '<cmd>GitConflictChooseTheirs<CR>', desc = 'choose incoming' },
    },
  },

  -----------------------------------------------------------------------------
  -- Git UI
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    --stylua: ignore start
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'Lazygit'  },
    },
  },
  {
    'sindrets/diffview.nvim',
    event = 'BufRead',
    keys = {
      { '<Leader>gd', '<cmd>DiffviewFileHistory %<CR>', desc = 'Diff File' },
      { '<Leader>gv', '<cmd>DiffviewOpen<CR>', desc = 'Diff View' },
    },
    config = function()
      require('diffview').setup {
        keymaps = {
          view = {
            ['j'] = false,
            ['k'] = false,
            ['l'] = false,
            ['h'] = false,
          },
          file_panel = {
            ['j'] = false,
            ['k'] = false,
            ['l'] = false,
            ['h'] = false,
          },
          file_history_panel = {
            ['j'] = false,
            ['k'] = false,
            ['l'] = false,
            ['h'] = false,
          },
        },
      }
    end,
  },

  --- Better Visual for help files
  {
    'OXY2DEV/helpview.nvim',
    -- lazy = false, -- Recommended
    ft = 'help',

    -- In case you still want to lazy load
    -- ft = "help",

    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },

  -----------------------------------------------------------------------------
  -- Leetcode Problems
  {
    'kawre/leetcode.nvim',
    build = ':TSUpdate html',
    cmd = 'Leet',
    dependencies = {
      -- 'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim', -- required by telescope
      'MunifTanjim/nui.nvim',

      -- optional
      'nvim-treesitter/nvim-treesitter',
      'rcarriga/nvim-notify',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      -- configuration goes here
      lang = 'python3',
    },
  },
  {
    'roobert/f-string-toggle.nvim',
    config = function()
      require('f-string-toggle').setup {
        key_binding = '<leader>f',
        key_binding_desc = 'Toggle f-string',
      }
    end,
  },

  -----------------------------------------------------------------------------
  -- Lsp Saga
  {
    'nvimdev/lspsaga.nvim',
    event = { 'LspAttach' },
    opts = {
      lightbulb = {
        enable = false,
        enable_in_insert = false,
        sign = false,
        sign_priority = 40,
        virtual_text = false,
      },
      finder = {
        max_height = 0.5,
        min_width = 30,
        force_max_height = false,
        keys = {
          jump_to = 'p',
          expand_or_jump = 'o',
          vsplit = 's',
          split = 'i',
          tabe = 't',
          quit = { 'q', '<ESC>' },
        },
      },
      definition = {
        edit = '<C-c>o',
        vsplit = '<C-c>v',
        split = '<C-c>i',
        tabe = '<C-c>t',
        quit = 'q',
      },
      code_action = {
        num_shortcut = true,
        keys = {
          quit = 'q',
          exec = '<CR>',
        },
      },
    },
    config = function(_, opts)
      require('lspsaga').setup(opts)
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons', -- optional
    },
  },

  {
    'ThePrimeagen/refactoring.nvim',
    keys = {
      {
        '<leader>r',
        function()
          require('refactoring').select_refactor()
        end,
        mode = 'v',
        noremap = true,
        silent = true,
        expr = false,
      },
    },
    opts = {},
  },

  {
    'folke/todo-comments.nvim',
    event = 'BufReadPost',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = true,
      sign_priority = 8,
      keywords = {
        FIX = {
          alt = { 'FIX', 'BUG', 'ISSUE' },
        },
        WARN = { alt = { 'WARNING' } },
        PERF = { alt = { 'OPT', 'OPTIMIZE' } },
      },
      highlight = {
        before = '',
        keyword = 'wide',
        after = 'fg',
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
        comments_only = true,
        max_line_len = 400,
        exclude = {},
      },
    },
  },

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
        'norg',
        'markdown_inline',
      },
      ignore_install = { 'org' },
      auto_install = true,
      -- ignore_install = { 'org' },
      highlight = {
        enable = true,
        disable = { 'org' },
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby', 'org', "markdown" },
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
        blacklist = { 'c', 'cpp' },
      }
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      vim.keymap.set('n', '<leader>uH', '<CMD>TSPlaygroundToggle<CR>', { desc = '[t]oggle treesitter playground [h]ighlight groups', silent = true })
    end,
  },

  -----------------------------------------------------------------------------
  -- LSP Diagnostics and quickfix
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    opts = {},

    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<CR>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<CR>',
        desc = 'buffer Disagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<CR>',
        desc = 'Symbols (Trouble)',
      },
      -- {
      --   '<leader>cl',
      --   '<cmd>Trouble lsp toggle focus=false win.position=right<CR>',
      --   desc = 'LSP Definitions / references / ... (Trouble)',
      -- },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<CR>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle <cr>',
        desc = 'Quickfix list (Trouble)',
      },
    },
  },

  {
    '2kabhishek/exercism.nvim',
    cmd = {
      'ExercismLanguages',
      'ExercismList',
      'ExercismSubmit',
      'ExercismTest',
    },
    keys = {
      { '<leader>lxa', '<cmd>ExercismList<CR>', desc = 'Exercism All exercises' },
      { '<leader>lxl', '<cmd>ExercismLanguages<CR>', desc = 'Exercism Languages' },
      { '<leader>lxt', '<cmd>ExercismTest<CR>', desc = 'ExercismTest' },
      { '<leader>lxs', '<cmd>ExercismSubmit<CR>', desc = 'ExercismSubmit' },
    },
    dependencies = {
      {
        '2kabhishek/utils.nvim',
        opts = {
          fuzzy_provider = 'snacks',
        },
      },
      '2kabhishek/termim.nvim', -- optional, better UX for running tests
    },
    -- Add your custom configs here, keep it blank for default configs (required)
    opts = {
      exercism_workspace = '~/exercism',
      default_language = 'typescript',
      add_default_keybindings = false,
    },
    config = function(_, opts)
      require('exercism').setup(opts)
    end,
  },
  {
    'rachartier/tiny-inline-diagnostic.nvim',
    event = 'VeryLazy',
    priority = 1000,
    config = function()
      require('tiny-inline-diagnostic').setup()
      vim.diagnostic.config { virtual_text = false, virtual_lines = false }
    end,
  },
}
