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
  -- Marks
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()
      -- not working, need to fix
      local conf = require('telescope.config').values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end

      -- Open harpoon window
      vim.keymap.set('n', '<leader>ht', function()
        toggle_telescope(harpoon:list())
      end, { desc = 'Open harpoon in telescope' })
      -- Add mark to harpoon list
      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():add()
      end, { desc = 'Harpoon: [a]dd file' })

      -- Show harpoon UI
      vim.keymap.set('n', '<leader>hs', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = 'Harpoon: [s]how UI' })

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set('n', '<leader>hn', function()
        harpoon:list():next()
      end, { desc = 'Harpoon: next mark' })
      vim.keymap.set('n', '<leader>hN', function()
        harpoon:list():prev()
      end, { desc = 'Harpoon: prev mark' })

      -- View harpoon list
      vim.keymap.set('n', '<leader>h1', function()
        harpoon:list():select(1)
      end, { desc = 'Harpoon: 1' })
      vim.keymap.set('n', '<leader>h2', function()
        harpoon:list():select(2)
      end, { desc = 'Harpoon: 2' })
      vim.keymap.set('n', '<leader>h3', function()
        harpoon:list():select(3)
      end, { desc = 'Harpoon: 3' })
      vim.keymap.set('n', '<leader>h4', function()
        harpoon:list():select(4)
      end, { desc = 'Harpoon: 4' })
    end,
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
          'tmux',
          'typescript',
        },
        excludes = { 'lazy', 'mason', 'help' },
      },
    },
  },

  -----------------------------------------------------------------------------
  -- Swap textobjects
  {
    'mizlan/iswap.nvim',
    event = 'VeryLazy',
  },

  -----------------------------------------------------------------------------
  -- Preview Markdown
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    build = 'cd app && yarn install',
    ft = { 'markdown' },
    init = function()
      vim.g.mkdp_browser = 'Firefox'
    end,
  },

  -----------------------------------------------------------------------------
  -- Auto save sessions
  {
    'rmagatti/auto-session',
    lazy = false,
    dependencies = {
      'nvim-telescope/telescope.nvim', -- Only needed if you want to use sesssion lens
    },
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
      event = 'VeryLazy',
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
          -- vim.cmd 'nohlsearch'
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
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      require('orgmode').setup {
        calendar = { round_min_with_hours = true, min_big_step = 15, min_small_step = 1 },
        org_log_repeat = 'time',
        org_id_method = 'ts',
        org_agenda_span = 'week',
        org_agenda_files = '~/orgfiles/**/*',
        org_default_notes_file = '~/orgfiles/refile.org',
        mappings = {
          global = {
            org_agenda = { '<leader>oa', desc = 'Orgmode Agenda' },
            org_capture = { '<leader>oc', desc = 'Orgmode Capture' },
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
  {
    'lukas-reineke/headlines.nvim',
    config = function()
      require('headlines').setup {
        org = {
          headline_highlights = { 'Headline1', 'Headline2' },
        },
      }
    end,
  },
}
