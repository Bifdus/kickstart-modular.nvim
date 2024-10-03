return {
  { 'nvim-lua/plenary.nvim' },

  {
    'nvchad/ui',
    config = function()
      require 'nvchad'
    end,
  },

  {
    'nvchad/base46',
    lazy = true,
    build = function()
      require('base46').load_all_highlights()
    end,
  },
  -----------------------------------------------------------------------------
  -- Statusline
  -- {
  --   'nvim-lualine/lualine.nvim',
  --   lazy = false,
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
              { '<leader>sn', '', desc = '+noice' },
              { '<S-Enter>', function() require('noice').redirect(tostring(vim.fn.getcmdline())) end, mode = 'c', desc = 'Redirect Cmdline' },
              { '<leader>snl', function() require('noice').cmd('last') end, desc = 'Noice Last Message' },
              { '<leader>snh', function() require('noice').cmd('history') end, desc = 'Noice History' },
              { '<leader>sna', function() require('noice').cmd('all') end, desc = 'Noice All' },
              { '<leader>snt', function() require('noice').cmd('pick') end, desc = 'Noice Picker (Telescope/FzfLua)' },
      },
    ---@type NoiceConfig
    opts = {
      lsp = {
        signature = {
          enabled = false,
        },
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
}
