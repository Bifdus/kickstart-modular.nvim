return {

  {
    'vhyrro/luarocks.nvim',
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { 'magick' },
    },
  },
  {
    '3rd/image.nvim',
    dependencies = { 'luarocks.nvim' },
    config = function()
      require('image').setup {
        backend = 'kitty',
        kitty_method = 'normal',
        integrations = {
          -- Notice these are the settings for markdown files
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            -- Set this to false if you don't want to render images coming from
            -- a URL
            download_remote_images = true,
            -- Change this if you would only like to render the image where the
            -- cursor is at
            -- I set this to true, because if the file has way too many images
            -- it will be laggy and will take time for the initial load
            only_render_image_at_cursor = true,
            -- markdown extensions (ie. quarto) can go here
            filetypes = { 'markdown', 'vimwiki', 'html', 'md' },
          },
          -- neorg = {
          --   enabled = true,
          --   clear_in_insert_mode = false,
          --   download_remote_images = true,
          --   only_render_image_at_cursor = true,
          --   filetypes = { 'norg' },
          -- },
          -- This is disabled by default
          -- Detect and render images referenced in HTML files
          -- Make sure you have an html treesitter parser installed
          -- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/treesitter.lua
          html = {
            enabled = true,
            only_render_image_at_cursor = true,
            -- Enabling "markdown" below allows you to view html images in .md files
            -- https://github.com/3rd/image.nvim/issues/234
            -- filetypes = { "html", "xhtml", "htm", "markdown" },
            filetypes = { 'html', 'xhtml', 'htm' },
          },
          -- This is disabled by default
          -- Detect and render images referenced in CSS files
          -- Make sure you have a css treesitter parser installed
          -- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/treesitter.lua
          css = {
            enabled = true,
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,

        -- This is what I changed to make my images look smaller, like a
        -- thumbnail, the default value is 50
        -- max_height_window_percentage = 20,
        -- max_height_window_percentage = 40,

        -- toggles images when windows are overlapped
        window_overlap_clear_enabled = false,
        window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },

        -- auto show/hide images when the editor gains/looses focus
        editor_only_render_when_focused = true,

        -- auto show/hide images in the correct tmux window
        -- In the tmux.conf add `set -g visual-activity off`
        tmux_show_only_in_active_window = true,

        -- render image files as images when opened
        hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif' },
      }
    end,
  },
  {
    'HakonHarnes/img-clip.nvim',
    event = 'VeryLazy',
    opts = {
      filetypes = {
        markdown = {
          url_encode_path = true,
          template = '![$FILE_NAME]($FILE_PATH)',
        },
        norg = {
          url_encode_path = true,
          template = '.image $FILE_PATH',
        },
      },
    },
    keys = {
      -- suggested keymap
      { '<leader>P', '<cmd>PasteImage<cr>', desc = 'Paste image from system clipboard' },
    },
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
  -- Find and replace
  {
    'nvim-pack/nvim-spectre',
    cmd = 'Spectre',
    opts = {},
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
      -- fold_virt_text_handler = require('custom.functions.utils').fold_handler,
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
      -- TODO: Find a good replacement
      -- vim.keymap.set({ 'n', 'v' }, '<M-n>', function()
      --   mc.addCursor '*'
      -- end)

      -- Jump to the next word under cursor but do not add a cursor.
      vim.keymap.set({ 'n', 'v' }, '<c-n>', function()
        mc.skipCursor '*'
      end)

      -- Delete the main cursor.
      -- vim.keymap.set({ 'n', 'v' }, '<leader>z', mc.deleteCursor)

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

  -- {
  --   'monaqa/dial.nvim',
  --   recommended = true,
  --   desc = 'Increment and decrement numbers, dates, and more',
  -- -- stylua: ignore
  -- keys = {
  --   { "<C-a>", function() return M.dial(true) end, expr = true, desc = "Increment", mode = {"n", "v"} },
  --   { "<C-x>", function() return M.dial(false) end, expr = true, desc = "Decrement", mode = {"n", "v"} },
  --   { "g<C-a>", function() return M.dial(true, true) end, expr = true, desc = "Increment", mode = {"n", "v"} },
  --   { "g<C-x>", function() return M.dial(false, true) end, expr = true, desc = "Decrement", mode = {"n", "v"} },
  -- },
  --   opts = function()
  --     local augend = require 'dial.augend'
  --
  --     local logical_alias = augend.constant.new {
  --       elements = { '&&', '||' },
  --       word = false,
  --       cyclic = true,
  --     }
  --
  --     local ordinal_numbers = augend.constant.new {
  --       -- elements through which we cycle. When we increment, we go down
  --       -- On decrement we go up
  --       elements = {
  --         'first',
  --         'second',
  --         'third',
  --         'fourth',
  --         'fifth',
  --         'sixth',
  --         'seventh',
  --         'eighth',
  --         'ninth',
  --         'tenth',
  --       },
  --       -- if true, it only matches strings with word boundary. firstDate wouldn't work for example
  --       word = false,
  --       -- do we cycle back and forth (tenth to first on increment, first to tenth on decrement).
  --       -- Otherwise nothing will happen when there are no further values
  --       cyclic = true,
  --     }
  --
  --     local weekdays = augend.constant.new {
  --       elements = {
  --         'Monday',
  --         'Tuesday',
  --         'Wednesday',
  --         'Thursday',
  --         'Friday',
  --         'Saturday',
  --         'Sunday',
  --       },
  --       word = true,
  --       cyclic = true,
  --     }
  --
  --     local months = augend.constant.new {
  --       elements = {
  --         'January',
  --         'February',
  --         'March',
  --         'April',
  --         'May',
  --         'June',
  --         'July',
  --         'August',
  --         'September',
  --         'October',
  --         'November',
  --         'December',
  --       },
  --       word = true,
  --       cyclic = true,
  --     }
  --
  --     local capitalized_boolean = augend.constant.new {
  --       elements = {
  --         'True',
  --         'False',
  --       },
  --       word = true,
  --       cyclic = true,
  --     }
  --
  --     return {
  --       dials_by_ft = {
  --         css = 'css',
  --         javascript = 'typescript',
  --         javascriptreact = 'typescript',
  --         json = 'json',
  --         lua = 'lua',
  --         markdown = 'markdown',
  --         python = 'python',
  --         sass = 'css',
  --         scss = 'css',
  --         typescript = 'typescript',
  --         typescriptreact = 'typescript',
  --         yaml = 'yaml',
  --       },
  --       groups = {
  --         default = {
  --           augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
  --           augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
  --           augend.date.alias['%Y/%m/%d'], -- date (2022/02/19, etc.)
  --           ordinal_numbers,
  --           weekdays,
  --           months,
  --         },
  --         typescript = {
  --           augend.integer.alias.decimal, -- nonnegative and negative decimal number
  --           augend.constant.alias.bool, -- boolean value (true <-> false)
  --           logical_alias,
  --           augend.constant.new { elements = { 'let', 'const' } },
  --         },
  --         yaml = {
  --           augend.integer.alias.decimal, -- nonnegative and negative decimal number
  --           augend.constant.alias.bool, -- boolean value (true <-> false)
  --         },
  --         css = {
  --           augend.integer.alias.decimal, -- nonnegative and negative decimal number
  --           augend.hexcolor.new {
  --             case = 'lower',
  --           },
  --           augend.hexcolor.new {
  --             case = 'upper',
  --           },
  --         },
  --         markdown = {
  --           augend.misc.alias.markdown_header,
  --         },
  --         json = {
  --           augend.integer.alias.decimal, -- nonnegative and negative decimal number
  --           augend.semver.alias.semver, -- versioning (v1.1.2)
  --         },
  --         lua = {
  --           augend.integer.alias.decimal, -- nonnegative and negative decimal number
  --           augend.constant.alias.bool, -- boolean value (true <-> false)
  --           augend.constant.new {
  --             elements = { 'and', 'or' },
  --             word = true, -- if false, "sand" is incremented into "sor", "doctor" into "doctand", etc.
  --             cyclic = true, -- "or" is incremented into "and".
  --           },
  --         },
  --         python = {
  --           augend.integer.alias.decimal, -- nonnegative and negative decimal number
  --           capitalized_boolean,
  --           logical_alias,
  --         },
  --       },
  --     }
  --   end,
  --   config = function(_, opts)
  --     require('dial.config').augends:register_group(opts.groups)
  --     vim.g.dials_by_ft = opts.dials_by_ft
  --   end,
  -- },

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
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'flash',
      },
      -- {
      --   't',
      --   mode = { 'n', 'x', 'o' },
      --   function()
      --     require('flash').treesitter_search()
      --   end,
      --   desc = 'flash treesitter',
      -- },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'S',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<leader>uF',
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

  {
    'echasnovski/mini.surround',
    opts = {
      mappings = {
        add = 'gsa', -- Add surrounding in Normal and Visual modes
        delete = 'gsd', -- Delete surrounding
        find = 'gsf', -- Find surrounding (to the right)
        find_left = 'gsF', -- Find surrounding (to the left)
        highlight = 'gsh', -- Highlight surrounding
        replace = 'gsr', -- Replace surrounding
        update_n_lines = 'gsn', -- Update `n_lines`
      },
    },
  },

  -- auto pairs
  {
    'windwp/nvim-autopairs',
    event = 'VeryLazy',
    opts = {
      enable_check_bracket_line = false,
      ignored_next_char = '[%w%.]',
      check_ts = true,
      ts_config = {
        lua = { 'string' },
        javascript = { 'template_string' },
        java = false,
      },
    },
    config = function(_, opts)
      require('nvim-autopairs').setup { opts }
    end,
  },
  -- Tags typescript
  {
    'windwp/nvim-ts-autotag',
    event = 'VeryLazy',
    opts = {},
  },

  -- Trailing whitespace highlight and remove
  {
    'echasnovski/mini.trailspace',
    event = { 'BufReadPost', 'BufNewFile' },
		-- stylua: ignore
		keys = {
			{ '<Leader>cw', '<cmd>lua MiniTrailspace.trim()<CR>', desc = 'Erase Whitespace' },
		},
    opts = {},
  },
  -- Rest interface
  {
    'mistweaverco/kulala.nvim',
    keys = {
      { '<leader>Rs', desc = 'Send request', ft = { 'http', 'rest' } },
      { '<leader>Ra', desc = 'Send all requests', ft = { 'http', 'rest' } },
      { '<leader>Ro', desc = 'Open scratchpad', ft = { 'http', 'rest' } },
    },
    ft = { 'http', 'rest', 'html' },
    opts = {
      -- your configuration comes here
      global_keymaps = false,
    },
  },
  {
    'lervag/vimtex',
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = 'zathura'
    end,
  },
  { 'vuciv/golf' },
}
