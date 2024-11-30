return {

  -----------------------------------------------------------------------------
  -- Improved jumps
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
      modes = {
        char = {
          enabled = true,
        },
      },
    },
    -- stylua: ignore
    keys = {
      {';', mode ={'n', 'x', 'o'}, false},
      {',', mode ={'n', 'x', 'o'}, false},
      {
        '?',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      -- {
      --   'T',
      --   mode = { 'n', 'x', 'o' },
      --   function()
      --     require('flash').treesitter_search()
      --   end,
      --   desc = 'Flash Treesitter',
      -- },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      -- {
      --   'R',
      --   mode = { 'o', 'x' },
      --   function()
      --     require('flash').treesitter_search()
      --   end,
      --   desc = 'Treesitter Search',
      -- },
      {
        '<leader>tf',
        mode = { 'n' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
  },

  -----------------------------------------------------------------------------
  -- Returns you to last place in file when reopening
  { 'ethanholz/nvim-lastplace', opts = {} },
  {
    'uga-rosa/ccc.nvim',
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
        filetypes = {
          'html',
          'lua',
          'css',
          'scss',
          'sass',
          'less',
          'stylus',
          'javascript',
          'javascriptreact',
          'tmux',
          'json',
          'typescript',
          'typescriptreact',
        },
        excludes = { 'lazy', 'mason', 'help' },
      },
    },
  },

  -----------------------------------------------------------------------------
  -- Swap textobjects
  {
    'mizlan/iswap.nvim',
    cmd = { 'ISwap', 'ISwapWith', 'ISwapNode', 'ISwapNodeWith' },
    -- event = 'VeryLazy',
  },

  -----------------------------------------------------------------------------
  -- Preview Markdown
  {
    'iamcco/markdown-preview.nvim',
    ft = { 'markdown' },
    -- cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    init = function()
      vim.g.mkdp_browser = 'Firefox'
    end,
  },

  -----------------------------------------------------------------------------
  -- Auto save sessions
  {
    'rmagatti/auto-session',
    cmd = 'SessionRestore',
    -- dependencies = {
    --   'nvim-telescope/telescope.nvim', -- Only needed if you want to use sesssion lens
    -- },
    config = function()
      require('auto-session').setup {
        close_unsupported_windows = true,
        auto_restore_enabled = false,
      }
    end,
  },

  -----------------------------------------------------------------------------
  -- View CSV files
  {
    'theKnightsOfRohan/csvlens.nvim',
    ft = { 'csv' },
    dependencies = {
      'akinsho/toggleterm.nvim',
    },
    config = true,
    opts = {},
  },

  -----------------------------------------------------------------------------
  -- Find and replace
  {
    'nvim-pack/nvim-spectre',
    cmd = 'Spectre',
    opts = {},
  },

  -----------------------------------------------------------------------------
  -- Terminal window
  {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    version = '*',
    opts = {
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = '1',
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = 'horizontal',
      close_on_exit = true,
      shell = vim.o.shell,
    },
  },

  -----------------------------------------------------------------------------
  -- Folds
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
      {
        'luukvbaal/statuscol.nvim',
        config = function()
          local builtin = require 'statuscol.builtin'
          require('statuscol').setup {
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
              { text = { '%s' }, click = 'v:lua.ScSa' },
              { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
            },
          }
        end,
      },
    },
    --stylua: ignore
    keys = {
      { "zc" },
      { "zo" },
      { "zC" },
      { "zO" },
      { "za" },
      { "zA" },
      { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Open Folds Except Kinds", },
      { "zR", function() require("ufo").openAllFolds() end, desc = "Open All Folds", },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close All Folds", },
      { "zm", function() require("ufo").closeFoldsWith() end, desc = "Close Folds With", },
      { "zp", function()
        local winid = require('ufo').peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end, desc = "Peek Fold", },
    },
    opts = {
      fold_virt_text_handler = require('custom.functions.utils').fold_handler,
    },
    config = function(_, opts)
      require('ufo').setup(opts)
    end,
  },

  -----------------------------------------------------------------------------
  -- File Browser
  {
    {
      'mikavilpas/yazi.nvim',
      cmd = 'Yazi',
      -- event = 'VeryLazy',
      keys = {
        {
          '\\',
          '<cmd>Yazi<cr>',
          desc = 'Open yazi at the current file',
        },
        {
          -- Open in the current working directory
          '|',
          '<cmd>Yazi cwd<cr>',
          desc = "Open the file manager in nvim's working directory",
        },
        {
          -- NOTE: this requires a version of yazi that includes
          -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
          '<leader>cr',
          '<cmd>Yazi toggle<cr>',
          desc = 'Resume the last yazi session',
        },
      },
      ---@type YaziConfig
      opts = {
        -- if you want to open yazi instead of netrw, see below for more info
        open_for_directories = true,
        keymaps = {
          show_help = '<f1>',
        },
      },
    },
  },

  -----------------------------------------------------------------------------
  -- Multi Cursor
  {
    'jake-stewart/multicursor.nvim',
    branch = '1.0',
    config = function()
      local mc = require 'multicursor-nvim'

      mc.setup()

      -- Add cursors above/below the main cursor.
      vim.keymap.set({ 'n', 'v' }, '<M-Up>', function()
        mc.addCursor 'gk'
      end, { noremap = true, silent = true })
      vim.keymap.set({ 'n', 'v' }, '<M-Down>', function()
        mc.addCursor 'gj'
      end)

      -- Rotate the main cursor.
      vim.keymap.set({ 'n', 'v' }, '<M-left>', mc.nextCursor)
      vim.keymap.set({ 'n', 'v' }, '<M-right>', mc.prevCursor)

      -- Add and remove cursors with alt + left click.
      vim.keymap.set('n', '<M-leftmouse>', mc.handleMouse)

      -- Add a cursor and jump to the next word under cursor.
      vim.keymap.set({ 'n', 'v' }, '<c-a>', function()
        mc.addCursor '*'
      end)

      -- Jump to the next word under cursor but do not add a cursor.
      vim.keymap.set({ 'n', 'v' }, '<c-n>', function()
        mc.skipCursor '*'
      end)

      -- Delete the main cursor.
      vim.keymap.set({ 'n', 'v' }, '<leader>z', mc.deleteCursor)

      vim.keymap.set({ 'n', 'v' }, '<c-q>', function()
        if mc.cursorsEnabled() then
          -- Stop other cursors from moving.
          -- This allows you to reposition the main cursor.
          mc.disableCursors()
        else
          mc.addCursor()
        end
      end)

      -- Handle esc functionality, added nohlsearch to avoid conflicts
      vim.keymap.set('n', '<esc>', function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        elseif mc.hasCursors() then
          mc.clearCursors()
        else
          vim.cmd 'nohlsearch'
        end
      end)

      -- Align cursor columns.
      vim.keymap.set('n', '<leader>a', mc.alignCursors)

      -- Split visual selections by regex.
      vim.keymap.set('v', 'S', mc.splitCursors)

      -- Append/insert for each line of visual selections.
      vim.keymap.set('v', 'I', mc.insertVisual)
      vim.keymap.set('v', 'A', mc.appendVisual)
      -- match new cursors within visual selections by regex.
      vim.keymap.set('v', 'M', mc.matchCursors)

      -- Rotate visual selection contents.
      vim.keymap.set('v', '<leader>t', function()
        mc.transposeCursors(1)
      end)
      vim.keymap.set('v', '<leader>T', function()
        mc.transposeCursors(-1)
      end)

      -- Customize how cursors look.
      vim.api.nvim_set_hl(0, 'MultiCursorCursor', { link = 'Cursor' })
      vim.api.nvim_set_hl(0, 'MultiCursorVisual', { link = 'Visual' })
      vim.api.nvim_set_hl(0, 'MultiCursorDisabledCursor', { link = 'Visual' })
      vim.api.nvim_set_hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
    end,
  },

  -----------------------------------------------------------------------------
  -- Note taking and todo list
  {
    'nvim-orgmode/orgmode',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      require('orgmode').setup {
        calendar = { round_min_with_hours = true, min_big_step = 15, min_small_step = 1 },
        org_log_repeat = 'time',
        org_id_method = 'ts',
        org_agenda_span = 'week',
        org_agenda_files = '~/orgfiles/**/*',
        org_archive_location = '~/orgfiles/archive.org::/From %s',
        org_default_notes_file = '~/orgfiles/refile.org',
        org_refile_target_files = '~/orgfiles/archive.org',
        win_split_mode = function(name)
          -- Make sure it's not a scratch buffer by passing false as 2nd argument
          local bufnr = vim.api.nvim_create_buf(false, false)
          --- Setting buffer name is required
          vim.api.nvim_buf_set_name(bufnr, name)

          local fill = 0.8
          local width = math.floor((vim.o.columns * fill))
          local height = math.floor((vim.o.lines * fill))
          local row = math.floor((((vim.o.lines - height) / 2) - 1))
          local col = math.floor(((vim.o.columns - width) / 2))

          vim.api.nvim_open_win(bufnr, true, {
            relative = 'editor',
            width = width,
            height = height,
            row = row,
            col = col,
            style = 'minimal',
            border = 'rounded',
          })
        end,

        mappings = {
          global = {
            org_agenda = '<leader>oa',
            org_capture = '<leader>oc',
          },
        },
      }
    end,
  },
  {
    'akinsho/org-bullets.nvim',
    config = function()
      require('org-bullets').setup {
        concealcursor = false, -- If false then when the cursor is on a line underlying characters are visible
        symbols = {
          -- list symbol
          list = '•',
          -- headlines can be a list
          headlines = { '◉', '○', '✸', '✿' },
          checkboxes = {
            half = { '', '@org.checkbox.halfchecked' },
            done = { '✓', '@org.keyword.done' },
            todo = { '˟', '@org.keyword.todo' },
          },
        },
      }
    end,
  },
  --
  {
    'lukas-reineke/headlines.nvim',
    ft = { 'org', 'neorg', 'markdown' },
    config = function()
      require('headlines').setup {
        org = {
          headline_highlights = { 'Headline1', 'Headline2' },
        },
      }
    end,
  },
  -- Knowledge Base (notes etc)
  -- {
  --   'chipsenkbeil/org-roam.nvim',
  --   ft = { 'org' },
  --   tag = '0.1.0',
  --   dependencies = {
  --     {
  --       'nvim-orgmode/orgmode',
  --       tag = '0.3.4',
  --     },
  --   },
  --   config = function()
  --     require('org-roam').setup {
  --       directory = '~/orgfiles',
  --     }
  --   end,
  -- },
  -- Toggle list to checkbox
  -- {
  --   'massix/org-checkbox.nvim',
  --   config = function()
  --     require('orgcheckbox').setup { lhs = '<leader>oT' }
  --   end,
  -- },
  --

  -----------------------------------------------------------------------------
  -- Note Taking
  {
    'nvim-neorg/neorg',
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = '*', -- Pin Neorg to the latest stable release
    build = ':Neorg sync-parsers',
    config = function()
      require('neorg').setup {
        load = {
          ['core.defaults'] = {},
          ['core.concealer'] = { config = { icon_preset = 'diamond' } },
          ['core.dirman'] = {
            config = {
              workspaces = {
                notes = '~/notes',
              },
              default_workspace = 'notes',
            },
          },
          ['core.integrations.nvim-cmp'] = {},
          ['core.completion'] = { config = { engine = 'nvim-cmp', name = '[Norg]' } },
          ['core.integrations.telescope'] = {},
          ['core.highlights'] = {},
          ['core.ui.calendar'] = {},
        },
      }
      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
    dependencies = {
      'nvim-neorg/neorg-telescope',
      'nvim-treesitter/nvim-treesitter',
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-cmp',
      'nvim-lua/plenary.nvim',
    },
  },

  -----------------------------------------------------------------------------
  -- Marks
  {
    'otavioschwanck/arrow.nvim',
    opts = {
      show_icons = true,
      leader_key = ';', -- Recommended to be a single key
      -- buffer_leader_key = 'm', -- Per Buffer Mappings
    },
  },
  { 'nvchad/volt', lazy = false },
  {
    'nvchad/minty',
    opts = { filetypes = { 'css', 'html', 'typescript', 'javascript', 'tsx', 'ts', 'jsx' } },
    config = function(_, opts)
      require('minty').setup(opts)
    end,
  },
  { 'chrisgrieser/nvim-spider', lazy = true },
}
