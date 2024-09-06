return {
  -- Leetcode Problems
  {
    'kawre/leetcode.nvim',
    build = ':TSUpdate html',
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
  -- Support for D2 Language
  { 'terrastruct/d2-vim', ft = { 'd2' } },
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
    'tris203/precognition.nvim',
    event = 'VeryLazy',
    opts = { startVisible = false },
    config = function(_, opts)
      require('precognition').setup(opts)
    end,
    keys = {
      {
        '<leader>tp',
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
  -- Diagnostics
  {
    'folke/trouble.nvim',
    event = 'VeryLazy',
    opts = {},
    cmd = 'Trouble',

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
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<CR>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
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
  -- Better typescript lsp
  {
    'pmizio/typescript-tools.nvim',
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
  -- Lsp Saga
  {
    'nvimdev/lspsaga.nvim',
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
  -- Python venv selector
  {
    'linux-cultist/venv-selector.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'mfussenegger/nvim-dap',
      'mfussenegger/nvim-dap-python', --optional
      { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
    },
    lazy = false,
    branch = 'regexp', -- This is the regexp branch, use this for the new version
    config = function()
      require('venv-selector').setup()
    end,
    keys = {
      { '<leader>vs', '<cmd>VenvSelect<cr>' },
      { '<leader>vc', '<cmd>VenvSelectCached<cr>' },
    },
  },
  -- Support for latex
  {
    'lervag/vimtex',
    lazy = false, -- we don't want to lazy load VimTeX
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = 'zathura'
    end,
  },
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
      { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put Yanked Text After Cursor' },
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
          width = 0.8, -- width of the Zen window
          height = 1, -- height of the Zen window
          -- by default, no options are changed for the Zen window
          -- uncomment any of the options below, or add other vim.wo options you want to apply
          options = {
            -- signcolumn = "no", -- disable signcolumn
            -- number = false, -- disable number column
            -- relativenumber = false, -- disable relative numbers
            -- cursorline = false, -- disable cursorline
            -- cursorcolumn = false, -- disable cursor column
            -- foldcolumn = "0", -- disable fold column
            -- list = false, -- disable whitespace characters
          },
        },
        plugins = {
          -- disable some global vim options (vim.o...)
          -- comment the lines to not apply the options
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
        },
        -- callback where you can add custom code when the Zen window opens
        on_open = function()
          require('gitsigns.actions').toggle_current_line_blame()
          vim.cmd 'IBLDisable'
          vim.opt.relativenumber = false
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
}
