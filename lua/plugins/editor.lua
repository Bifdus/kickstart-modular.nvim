return {

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
  -- Preview Markdown
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons', -- Optional: Only include if you use icons
    },
    opts = {
      auto_open = true,
      auto_close = true,
      -- Add more options based on the plugin's documentation
    },
    config = function(_, opts)
      require('render-markdown').setup(opts)
    end,
    -- Optional: Lazy-load based on file type
    ft = { 'markdown', 'md' },
    -- Optional: Add keybindings specific to markdown rendering
    keys = {
      { '<leader>mr', '<cmd>RenderMarkdown<CR>', desc = 'Render Markdown' },
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
      -- vim.keymap.set({ 'n', 'v' }, '<c-a>', function()
      --   mc.addCursor '*'
      -- end)

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
    config = function()
      -- Setup orgmode
      require('orgmode').setup {
        calendar = { round_min_with_hours = true, min_big_step = 15, min_small_step = 1 },
        hyperlinks = { sources = {} },
        org_use_property_inheritance = true,
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
    ft = 'org',
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
    ft = { 'org', 'markdown' },
    config = function()
      -- Colors for orgmode headlines
      vim.cmd [[highlight Headline1 guibg=#21262d]]
      -- vim.cmd [[highlight Headline2 guibg=#21262d]]

      local bullet_highlighs = {
        '@markup.heading.1.markdown',
        '@markup.heading.2.markdown',
        '@markup.heading.3.markdown',
        '@markup.heading.4.markdown',
        '@markup.heading.5.markdown',
        '@markup.heading.6.markdown',
      }
      require('headlines').setup {
        org = {
          headline_highlights = { 'Headline1' },
          bullets = { '◉', '○', '✸', '✿' },
          bullet_highlighs = bullet_highlighs,
        },
      }
    end,
  },

  -- {
  --   'epwalsh/obsidian.nvim',
  --   version = '*',
  --   -- lazy = true,
  --   -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  --   -- event = {
  --   --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   --   -- refer to `:h file-pattern` for more examples
  --   --   "BufReadPre path/to/my-vault/*.md",
  --   --   "BufNewFile path/to/my-vault/*.md",
  --   -- },
  --   --
  --   dependencies = {
  --     -- Required.
  --     'nvim-lua/plenary.nvim',
  --   },
  --   opts = {
  --     workspaces = {
  --       {
  --         name = 'vault',
  --         path = '~/vaults/Code',
  --       },
  --     },
  --   },
  --   daily_notes = {
  --     folder = 'dailies',
  --     -- Optional, if you want to change the date format for the ID of daily notes.
  --     date_format = '%Y-%m-%d',
  --     alias_format = '%B %-d, %Y',
  --     template = nil,
  --   },
  --
  --   mappings = {
  --     -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
  --     ['gf'] = {
  --       action = function()
  --         return require('obsidian').util.gf_passthrough()
  --       end,
  --       opts = { noremap = false, expr = true, buffer = true },
  --     },
  --     -- Toggle check-boxes.
  --     ['<leader>ch'] = {
  --       action = function()
  --         return require('obsidian').util.toggle_checkbox()
  --       end,
  --       opts = { buffer = true },
  --     },
  --     -- Smart action depending on context, either follow link or toggle checkbox.
  --     ['<cr>'] = {
  --       action = function()
  --         return require('obsidian').util.smart_action()
  --       end,
  --       opts = { buffer = true },
  --     },
  --   },
  --   ui = {
  --     enable = true,
  --     checkboxes = {
  --       [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
  --       ['x'] = { char = '', hl_group = 'ObsidianDone' },
  --       ['>'] = { char = '', hl_group = 'ObsidianRightArrow' },
  --       ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
  --     },
  --     bullets = { char = '•', hl_group = 'ObsidianBullet' },
  --     external_link_icon = { char = '', hl_group = 'ObsidianExtLinkIcon' },
  --     -- Replace the above with this if you don't have a patched font:
  --     -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
  --     reference_text = { hl_group = 'ObsidianRefText' },
  --     highlight_text = { hl_group = 'ObsidianHighlightText' },
  --     tags = { hl_group = 'ObsidianTag' },
  --     block_ids = { hl_group = 'ObsidianBlockID' },
  --     hl_groups = {
  --       -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
  --       ObsidianTodo = { bold = true, fg = '#f78c6c' },
  --       ObsidianDone = { bold = true, fg = '#89ddff' },
  --       ObsidianRightArrow = { bold = true, fg = '#f78c6c' },
  --       ObsidianTilde = { bold = true, fg = '#ff5370' },
  --       ObsidianBullet = { bold = true, fg = '#89ddff' },
  --       ObsidianRefText = { underline = true, fg = '#c792ea' },
  --       ObsidianExtLinkIcon = { fg = '#c792ea' },
  --       ObsidianTag = { italic = true, fg = '#89ddff' },
  --       ObsidianBlockID = { italic = true, fg = '#89ddff' },
  --       ObsidianHighlightText = { bg = '#75662e' },
  --     },
  --   },
  -- },
  --
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
  -- Window handling
  {
    'mistweaverco/kulala.nvim',
    keys = {
      { '<leader>Rs', desc = 'Send request' },
      { '<leader>Ra', desc = 'Send all requests' },
      { '<leader>Ro', desc = 'Open scratchpad' },
    },
    ft = { 'http', 'rest' },
    opts = {
      -- your configuration comes here
      global_keymaps = true,
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
