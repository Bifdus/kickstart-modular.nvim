return {
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
  -- Render Markdown
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('render-markdown').setup {
        auto_open = true,
        auto_close = true,
        -- Add more options based on the plugin's documentation
        heading = {
          sign = false,
          enabled = true,
          icons = { '󰎤 ', '󰎧 ', '󰎪 ', '󰎭 ', '󰎱 ', '󰎳 ' },
          foregrounds = {
            'RainbowDelimiterBlue',
            'RainbowDelimiterViolet',
            'RainbowDelimiterGreen',
            'RainbowDelimiterCyan',
          },
        },
        code = {
          enabled = true,
          style = 'full',
          highlight = 'DraculaBgLighter',
          width = 'block',
        },
        -- },
      }
    end,
    -- Optional: Lazy-load based on file type
    ft = { 'markdown', 'md' },
    keys = {
      { '<leader>rm', '<cmd>RenderMarkdown<CR>', desc = 'Render Markdown' },
    },
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
        win_split_mode = 'vertical',
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
    'obsidian-nvim/obsidian.nvim',
    version = '*',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },

    keys = {
      { '<leader>nd', ':ObsidianToday<cr>', desc = 'obsidian [d]aily' },
      { '<leader>nt', ':ObsidianToday 1<cr>', desc = 'obsidian [t]omorrow' },
      { '<leader>ny', ':ObsidianToday -1<cr>', desc = 'obsidian [y]esterday' },
      { '<leader>nb', ':ObsidianBacklinks<cr>', desc = 'obsidian [b]acklinks' },
      { '<leader>nl', ':ObsidianLink<cr>', desc = 'obsidian [l]ink selection' },
      { '<leader>nf', ':ObsidianFollowLink<cr>', desc = 'obsidian [f]ollow link' },
      { '<leader>nn', ':ObsidianNew<cr>', desc = 'obsidian [n]ew' },
      { '<leader>ns', ':ObsidianSearch<cr>', desc = 'obsidian [s]earch' },
      { '<leader>no', ':ObsidianQuickSwitch<cr>', desc = 'obsidian [o]pen quickswitch' },
      { '<leader>nO', ':ObsidianOpen<cr>', desc = 'obsidian [O]pen in app' },
    },

    config = function()
      --@diagnostic disable-next-line: missing-fields
      require('obsidian').setup {
        workspaces = {
          {
            name = 'vault',
            path = '~/vaults/',
          },
        },
        mappings = {
          -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
          ['gf'] = {
            action = function()
              return require('obsidian').util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
          },
          -- Toggle check-boxes.
          ['<leader>ch'] = {
            action = function()
              return require('obsidian').util.toggle_checkbox()
            end,
            opts = { buffer = true },
          },
          -- Smart action depending on context, either follow link or toggle checkbox.
          ['<cr>'] = {
            action = function()
              return require('obsidian').util.smart_action()
            end,
            opts = { buffer = true },
          },
        },
        daily_notes = {
          default = {},
          folder = 'dailies',
          -- Optional, if you want to change the date format for the ID of daily notes.
          date_format = '%Y-%m-%d',
          alias_format = '%B %-d, %Y',
          template = nil,
        },
        ui = {
          enable = true,
          checkboxes = {
            [' '] = { char = '󰄱', hl_group = 'ObsidianTodo', order = 1 },
            ['x'] = { char = '', hl_group = 'ObsidianDone', order = 2 },
            ['>'] = { char = '', hl_group = 'ObsidianRightArrow', order = 3 },
            ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde', order = 4 },
          },
          bullets = { char = '•', hl_group = 'ObsidianBullet' },
          external_link_icon = { char = '', hl_group = 'ObsidianExtLinkIcon' },
          -- Replace the above with this if you don't have a patched font:
          -- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
          reference_text = { hl_group = 'ObsidianRefText' },
          highlight_text = { hl_group = 'ObsidianHighlightText' },
          tags = { hl_group = 'ObsidianTag' },
          block_ids = { hl_group = 'ObsidianBlockID' },
          -- hl_groups = {
          --   -- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
          --   ObsidianTodo = { bold = true, fg = '#f78c6c' },
          --   ObsidianDone = { bold = true, fg = '#89ddff' },
          --   ObsidianRightArrow = { bold = true, fg = '#f78c6c' },
          --   ObsidianTilde = { bold = true, fg = '#ff5370' },
          --   ObsidianBullet = { bold = true, fg = '#89ddff' },
          --   ObsidianRefText = { underline = true, fg = '#c792ea' },
          --   ObsidianExtLinkIcon = { fg = '#c792ea' },
          --   ObsidianTag = { italic = true, fg = '#89ddff' },
          --   ObsidianBlockID = { italic = true, fg = '#89ddff' },
          --   ObsidianHighlightText = { bg = '#75662e' },
          -- },
        },
        -- Optional, customize how names/IDs for new notes are created.
        note_id_func = function(title)
          -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
          -- In this case a note with the title 'My new note' will be given an ID that looks
          -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
          local suffix = ''
          if title ~= nil then
            -- If title is given, transform it into valid file name.
            suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
          else
            -- If title is nil, just add 4 random uppercase letters to the suffix.
            for _ = 1, 4 do
              suffix = suffix .. string.char(math.random(65, 90))
            end
          end
          return tostring(os.time()) .. '-' .. suffix
        end,
      }
      vim.wo.conceallevel = 1
    end,
  },

  -- {
  --   'nvim-neorg/neorg',
  --   lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  --   version = '*', -- Pin Neorg to the latest stable release
  --   build = ':Neorg sync-parsers',
  --   dependencies = {
  --     {
  --       'juniorsundar/neorg-extras',
  --     },
  --     'folke/snacks.nvim',
  --   },
  --   config = function()
  --     require('neorg').setup {
  --       load = {
  --         ['core.defaults'] = {},
  --         ['core.completion'] = {
  --           config = {
  --             engine = 'nvim-cmp',
  --           },
  --         },
  --         ['core.integrations.nvim-cmp'] = {},
  --         ['core.concealer'] = {
  --           config = {
  --             icon_preset = 'basic',
  --             icons = {
  --               code_block = {
  --                 icon = '',
  --                 conceal = true,
  --                 content_only = true,
  --               },
  --             },
  --
  --             -- directive = {
  --             --   icon = '',
  --             --   nodes = { 'directive_image' },
  --             --   render = require('neorg.modules.core.concealer').public.icon_renderers.on_left,
  --             -- },
  --           },
  --         },
  --         ['core.dirman'] = {
  --           config = {
  --             workspaces = {
  --               notes = '~/neorg',
  --             },
  --             default_workspace = 'notes',
  --           },
  --         },
  --         ['external.many-mans'] = {
  --           config = {
  --             metadata_fold = true, -- If want @data property ... @end to fold
  --             code_fold = true, -- If want @code ... @end to fold
  --           },
  --         },
  --         -- OPTIONAL
  --         ['external.agenda'] = {
  --           config = {
  --             workspace = nil, -- or set to "tasks_workspace" to limit agenda search to just that workspace
  --           },
  --         },
  --         ['external.roam'] = {
  --           config = {
  --             fuzzy_finder = 'Snacks', -- OR "Fzf" OR "Snacks". Defaults to "Telescope"
  --             fuzzy_backlinks = false, -- Set to "true" for backlinks in fuzzy finder instead of buffer
  --             roam_base_directory = '', -- Directory in current workspace to store roam nodes
  --             node_name_randomiser = false, -- Tokenise node name suffix for more randomisation
  --             node_name_snake_case = false, -- snake_case the names if node_name_randomiser = false
  --           },
  --         },
  --       },
  --     }
  --     vim.wo.foldlevel = 90
  --     vim.wo.conceallevel = 2
  --   end,
  -- },
  -- {
  --   'akinsho/org-bullets.nvim',
  --   ft = 'org',
  --   config = function()
  --     require('org-bullets').setup {
  --       concealcursor = false, -- If false then when the cursor is on a line underlying characters are visible
  --       symbols = {
  --         -- list symbol
  --         list = '•',
  --         -- headlines can be a list
  --         headlines = { '◉', '○', '✸', '✿' },
  --         checkboxes = {
  --           half = { '', '@org.checkbox.halfchecked' },
  --           done = { '✓', '@org.keyword.done' },
  --           todo = { '˟', '@org.keyword.todo' },
  --         },
  --       },
  --     }
  --   end,
  -- },

  -- {
  --   'lukas-reineke/headlines.nvim',
  --   ft = { 'markdown' },
  --   config = function()
  --     -- Colors for orgmode headlines
  --     vim.cmd [[highlight Headline1 guibg=#21262d]]
  --     -- vim.cmd [[highlight Headline2 guibg=#21262d]]
  --
  --     local bullet_highlighs = {
  --       '@markup.heading.1.markdown',
  --       '@markup.heading.2.markdown',
  --       '@markup.heading.3.markdown',
  --       '@markup.heading.4.markdown',
  --       '@markup.heading.5.markdown',
  --       '@markup.heading.6.markdown',
  --     }
  --     require('headlines').setup {
  --       org = {
  --         headline_highlights = { 'Headline1' },
  --         bullets = { '◉', '○', '✸', '✿' },
  --         bullet_highlighs = bullet_highlighs,
  --       },
  --     }
  --   end,
  -- },
}
