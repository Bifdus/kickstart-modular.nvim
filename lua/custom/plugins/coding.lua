return {

  -----------------------------------------------------------------------------
  -- Leetcode Problems
  {
    'kawre/leetcode.nvim',
    build = ':TSUpdate html',
    cmd = 'Leet',
    dependencies = {
      'nvim-telescope/telescope.nvim',
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
  -- Support for D2 Language
  { 'terrastruct/d2-vim', ft = { 'd2' } },

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
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'Lazygit' },
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
  {
    'tris203/precognition.nvim',
    event = 'VeryLazy',
    opts = { startVisible = false },
    config = function(_, opts)
      require('precognition').setup(opts)
    end,
    keys = {
      {
        '<leader>tP',
        function()
          require('precognition').toggle()
        end,
        desc = '[T]oggle [p]rerecognition',
      },
      {
        '<leader>pp',
        function()
          require('precognition').peek()
        end,
        desc = '[p]rerecognition [p]eek',
      },
    },
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
    keys = {
      { '<Leader>V', '<Plug>(comment_toggle_blockwise_current)', mode = 'n', desc = 'Comment' },
      { '<Leader>V', '<Plug>(comment_toggle_blockwise_visual)', mode = 'x', desc = 'Comment' },
    },
    opts = function(_, opts)
      local ok, tcc = pcall(require, 'ts_context_commentstring.integrations.comment_nvim')
      if ok then
        opts.pre_hook = tcc.create_pre_hook()
      end
    end,
  },

  -----------------------------------------------------------------------------
  -- Tailwind extra lsp tools
  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    ft = { 'html', 'css', 'javascript', 'typescript' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim', -- optional
      'neovim/nvim-lspconfig', -- optional
    },
    opts = {},
  },

  -----------------------------------------------------------------------------
  -- Better typescript lsp
  {
    'pmizio/typescript-tools.nvim',
    ft = { 'html', 'css', 'javascript', 'typescript', 'typescriptreact', 'javascriptreact' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navic').attach(client, bufnr)
        end

        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', '<leader>ttr', '<cmd>TSToolsRenameFile<CR>', opts)
        vim.keymap.set('n', '<leader>tti', '<cmd>TSToolsOrganizeImports<CR>', opts)
        vim.keymap.set('n', '<leader>tto', '<cmd>TSToolsSortImports<CR>', opts)
        vim.keymap.set('n', '<leader>tta', '<cmd>TSToolsAddMissingImports<CR>', opts)
      end,
    },
    config = function(_, opts)
      require('typescript-tools').setup(opts)
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

  -----------------------------------------------------------------------------
  -- Python venv selector
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      'mfussenegger/nvim-dap-python', --optional
      { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
    },
    lazy = true,
    ft = 'python',
    branch = 'regexp', -- This is the regexp branch, use this for the new version
    config = function()
      require('venv-selector').setup()
    end,
    keys = {
      { '<leader>cvs', '<cmd>VenvSelect<cr>' },
      { '<leader>cvc', '<cmd>VenvSelectCached<cr>' },
    },
  },

  -----------------------------------------------------------------------------
  -- Devdocs
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

  -----------------------------------------------------------------------------
  -- Improved yanking
  {
    'gbprod/yanky.nvim',
    event = 'TextYankPost',
    opts = {
      highlight = { timer = 150 },
    },
    keys = {
    -- stylua: ignore
    { "<leader>sy", function() require("telescope").extensions.yank_history.yank_history({ }) end, desc = "Open Yank History" },
      { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' }, desc = 'Yank Text' },
      -- { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put Yanked Text After Cursor' },
      { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put Yanked Text Before Cursor' },
      { 'gp', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' }, desc = 'Put Yanked Text After Selection' },
      { 'gP', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' }, desc = 'Put Yanked Text Before Selection' },
      { '[y', '<Plug>(YankyCycleForward)', desc = 'Cycle Forward Through Yank History' },
      { ']y', '<Plug>(YankyCycleBackward)', desc = 'Cycle Backward Through Yank History' },
      { ']p', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'Put Indented After Cursor (Linewise)' },
      { '[p', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'Put Indented Before Cursor (Linewise)' },
      { ']P', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'Put Indented After Cursor (Linewise)' },
      { '[P', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'Put Indented Before Cursor (Linewise)' },
      { '>p', '<Plug>(YankyPutIndentAfterShiftRight)', desc = 'Put and Indent Right' },
      { '<p', '<Plug>(YankyPutIndentAfterShiftLeft)', desc = 'Put and Indent Left' },
      { '>P', '<Plug>(YankyPutIndentBeforeShiftRight)', desc = 'Put Before and Indent Right' },
      { '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)', desc = 'Put Before and Indent Left' },
      { '=p', '<Plug>(YankyPutAfterFilter)', desc = 'Put After Applying a Filter' },
      { '=P', '<Plug>(YankyPutBeforeFilter)', desc = 'Put Before Applying a Filter' },
    },
  },
  {
    'windwp/nvim-ts-autotag',
    ft = {
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
    },
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },

  -----------------------------------------------------------------------------
  -- VS Code like winbar
  {
    'utilyre/barbecue.nvim',
    dependencies = { 'SmiteshP/nvim-navic', 'nvim-tree/nvim-web-devicons' },
    keys = {
      {
        '<Leader>tB',
        function()
          local off = vim.b['barbecue_entries'] == nil
          require('barbecue.ui').toggle(off and true or nil)
        end,
        desc = 'Breadcrumbs toggle',
      },
    },
    opts = {
      enable = true,
      attach_navic = true,
      show_dirname = false,
      show_modified = true,
      -- kinds = kind_icons, -- Uncomment if you have kind_icons defined
      symbols = { separator = '' },
    },
    config = function(_, opts)
      require('barbecue').setup(opts)
    end,
  },
  {
    'folke/zen-mode.nvim',
    config = function()
      require('zen-mode').setup {
        window = {
          backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
          width = function()
            local min_width = 0.4
            local max_width = math.floor(vim.o.columns * 0.70)
            return math.max(min_width, max_width)
          end,
          height = 1, -- height of the Zen window
          options = {
            relativenumber = true, -- disable relative numbers
          },
        },

        plugins = {
          options = {
            enabled = true,
            ruler = false, -- disables the ruler text in the cmd line area
            showcmd = false, -- disables the command in the last line of the screen
          },
          gitsigns = { enabled = true }, -- disables git signs
          -- alacritty = {
          --   enabled = EcoVim.plugins.zen.alacritty_enabled or false,
          --   font = '14', -- font size
          -- },
          neotree = { enabled = true },
        },
        -- callback where you can add custom code when the Zen window opens
        on_open = function()
          require('gitsigns.actions').toggle_current_line_blame()
          vim.cmd 'IBLDisable'
          vim.opt.signcolumn = 'no'
          require('gitsigns.actions').refresh()
        end,
        -- callback where you can add custom code when the Zen window closes
        on_close = function()
          require('gitsigns.actions').toggle_current_line_blame()
          vim.cmd 'IBLEnable'
          vim.opt.relativenumber = true
          vim.opt.signcolumn = 'yes:2'
          require('gitsigns.actions').refresh()
        end,
      }
    end,
    keys = { { '<leader>tz', '<cmd>ZenMode<cr>', desc = 'Zen Mode' } },
  },
  {
    'nosduco/remote-sshfs.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    opts = {
      -- Refer to the configuration section below
      -- or leave empty for defaults
    },
  },
  {
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup {
        width = 120, -- Width of the floating window
        height = 15, -- Height of the floating window
        border = { '↖', '─', '┐', '│', '┘', '─', '└', '│' }, -- Border characters of the floating window
        default_mappings = true,
        debug = false, -- Print debug information
        opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
        resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
        post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        references = { -- Configure the telescope UI for slowing the references cycling window.
          telescope = require('telescope.themes').get_dropdown { hide_preview = false },
        },
        -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
        focus_on_open = true, -- Focus the floating window when opening it.
        dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
        force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
        bufhidden = 'wipe', -- the bufhidden option to set on the floating window. See :h bufhidden
        stack_floating_preview_windows = true, -- Whether to nest floating windows
        preview_window_title = { enable = true, position = 'left' }, -- Whether
      }
    end,
  },
}
