return {
  -- {
  --   'nvim-lualine/lualine.nvim',
  --   lazy = 'VeryLazy',
  --   dependencies = 'nvim-tree/nvim-web-devicons',
  --   opts = function()
  --     local utils = require 'custom.functions.utils'
  --
  --     return {
  --       options = {
  --         component_separators = { left = ' ', right = ' ' },
  --         section_separators = { left = ' ', right = ' ' },
  --         theme = 'cyberdream',
  --         globalstatus = true,
  --         disabled_filetypes = { statusline = { 'dashboard', 'alpha' } },
  --       },
  --       sections = {
  --         lualine_a = { { 'mode', icon = '' } },
  --         lualine_b = {
  --           { 'branch', icon = '' },
  --         },
  --         lualine_c = {
  --           { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
  --           {
  --             'filename',
  --             padding = { left = 1, right = 0 },
  --             file_status = true, -- Displays file status (readonly status, modified status)
  --             newfile_status = false, -- Display new file status (new file means no write after created)
  --             path = 1, -- 0: Just the filename
  --             -- 1: Relative path
  --             -- 2: Absolute path
  --             -- 3: Absolute path, with tilde as the home directory
  --             -- 4: Filename and parent dir, with tilde as the home directory
  --
  --             shorting_target = 40, -- Shortens path to leave 40 spaces in the window
  --             -- for other components. (terrible name, any suggestions?)
  --             symbols = {
  --               modified = '[+]', -- Text to show when the file is modified.
  --               readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
  --               unnamed = '[No Name]', -- Text to show for unnamed buffers.
  --               newfile = '[New]', -- Text to show for newly created file before first write
  --             },
  --           },
  --         },
  --         lualine_x = {
  --           {
  --             'diagnostics',
  --             always_visible = false,
  --             symbols = {
  --               error = ' ',
  --               warn = ' ',
  --               info = ' ',
  --               hint = '󰝶 ',
  --             },
  --           },
  --           { 'diff' },
  --         },
  --         lualine_y = {
  --           {
  --             'progress',
  --           },
  --           {
  --             'location',
  --             color = utils.get_hlgroup 'Boolean',
  --           },
  --         },
  --         lualine_z = {},
  --       },
  --       extensions = { 'lazy', 'toggleterm', 'mason', 'neo-tree', 'trouble' },
  --     }
  --   end,
  -- },

  -----------------------------------------------------------------------------
  -- UI Replacement for messages, cmdline and popup menu
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    enabled = true,
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
      -- stylua: ignore
      keys = {
              -- { '<leader>sn', '', desc = '+noice' },
              -- { '<S-Enter>', function() require('noice').redirect(tostring(vim.fn.getcmdline())) end, mode = 'c', desc = 'Redirect Cmdline' },
              -- { '<leader>snl', function() require('noice').cmd('last') end, desc = 'Noice Last Message' },
              -- { '<leader>snh', function() require('noice').cmd('history') end, desc = 'Noice History' },
              -- { '<leader>sna', function() require('noice').cmd('all') end, desc = 'Noice All' },
              -- { '<leader>snt', function() require('noice').cmd('pick') end, desc = 'Noice Picker (Telescope/FzfLua)' },
      },
    ---@type NoiceConfig
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      messages = {
        view_search = false,
      },
      routes = {
        -- See :h ui-messages
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '%d+L, %d+B' },
              { find = '^%d+ changes?; after #%d+' },
              { find = '^%d+ changes?; before #%d+' },
              { find = '^Hunk %d+ of %d+$' },
              { find = '^%d+ fewer lines;?' },
              { find = '^%d+ more lines?;?' },
              { find = '^%d+ line less;?' },
              { find = '^Already at newest change' },
              { kind = 'wmsg' },
              { kind = 'emsg', find = 'E486' },
              { kind = 'quickfix' },
            },
          },
          view = 'mini',
        },
        {
          filter = {
            event = 'msg_show',
            any = {
              { find = '^%d+ lines .ed %d+ times?$' },
              { find = '^%d+ lines yanked$' },
              { kind = 'emsg', find = 'E490' },
              { kind = 'search_count' },
            },
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = 'notify',
            any = {
              { find = '^No code actions available$' },
              { find = '^No information available$' },
            },
          },
          view = 'mini',
        },
        {
          filter = {
            event = 'notify',
            any = {
              { find = '# Config Change Detected. Reloading' },
              { find = '/warn' },
            },
          },
          opts = { skip = true },
        },
      },
    },
    config = function(_, opts)
      -- HACK: noice shows messages from before it was enabled,
      -- but this is not ideal when Lazy is installing plugins,
      -- so clear the messages in this case.
      if vim.o.filetype == 'lazy' then
        vim.cmd [[messages clear]]
      end
      require('noice').setup(opts)
    end,
  },

  -----------------------------------------------------------------------------
  -- Adds scrollbar to buffer
  {
    'petertriho/nvim-scrollbar',
    event = 'BufReadPost',
    opts = { show = true, excluded_filetypes = { 'NvimTree' } },
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
    'nosduco/remote-sshfs.nvim',
    -- dependencies = { 'nvim-telescope/telescope.nvim' },
    opts = {
      -- Refer to the configuration section below
      -- or leave empty for defaults
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = ' '
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require 'lualine_require'
      lualine_require.require = require

      local icons = LazyVim.icons

      vim.o.laststatus = vim.g.lualine_laststatus

      local opts = {
        options = {
          theme = 'auto',
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'ministarter', 'snacks_dashboard' } },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch' },

          lualine_c = {
            LazyVim.lualine.root_dir(),
            {
              'diagnostics',
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
            { LazyVim.lualine.pretty_path() },
          },
          lualine_x = {
            Snacks.profiler.status(),
            -- stylua: ignore
            {
              function() return require("noice").api.status.command.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
              color = function() return { fg = Snacks.util.color("Statement") } end,
            },
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = function() return { fg = Snacks.util.color("Constant") } end,
            },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = function() return { fg = Snacks.util.color("Debug") } end,
            },
            -- stylua: ignore
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = function() return { fg = Snacks.util.color("Special") } end,
            },
            {
              'diff',
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_y = {
            { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
            { 'location', padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return ' ' .. os.date '%R'
            end,
          },
        },
        extensions = { 'neo-tree', 'lazy', 'fzf' },
      }

      -- do not add trouble symbols if aerial is enabled
      -- And allow it to be overriden for some buffer types (see autocmds)
      if vim.g.trouble_lualine and LazyVim.has 'trouble.nvim' then
        local trouble = require 'trouble'
        local symbols = trouble.statusline {
          mode = 'symbols',
          groups = {},
          title = false,
          filter = { range = true },
          format = '{kind_icon}{symbol.name:Normal}',
          hl_group = 'lualine_c_normal',
        }
        table.insert(opts.sections.lualine_c, {
          symbols and symbols.get,
          cond = function()
            return vim.b.trouble_lualine ~= false and symbols.has()
          end,
        })
      end

      return opts
    end,
  },
}
