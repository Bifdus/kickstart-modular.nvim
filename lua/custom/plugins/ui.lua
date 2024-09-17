return {
  -- Dashboard
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    opts = {
      hide = {
        statusline = false,
        tabline = false,
        winbar = false,
      },
      theme = 'doom',
      config = {
        header = {
          '',
          '███╗   ██╗ ██████╗ ██████╗ ███████╗',
          '████╗  ██║██╔═══██╗██╔══██╗██╔════╝',
          '██╔██╗ ██║██║   ██║██║  ██║█████╗  ',
          '██║╚██╗██║██║   ██║██║  ██║██╔══╝  ',
          '██║ ╚████║╚██████╔╝██████╔╝███████╗',
          '╚═╝  ╚═══╝ ╚═════╝ ╚═════╝ ╚══════╝',
          '',
        },
        center = {
          { icon = '  ', desc = 'Find file                        ', key = 'f', key_format = ' %s', action = 'Telescope find_files' },
          { icon = '  ', desc = 'File browser                     ', key = 'b', key_format = ' %s', action = 'Neotree reveal' },
          { icon = '  ', desc = 'Live Grep (find in file)        ', key = 'g', key_format = ' %s', action = 'Telescope live_grep' },
          { icon = '  ', desc = 'Recently opened files            ', key = 'r', key_format = ' %s', action = 'Telescope oldfiles' },
          { icon = 'P  ', desc = 'Projects                         ', key = 'p', key_format = ' %s', action = 'Telescope projects' },
          {
            icon = ' ',
            desc = 'Open Config Folder               ',
            key = 'c',
            key_format = ' %s',
            action = 'lua require("custom.functions.utils").open_config_folder()',
          },
          -- TODO: Install auto session and enable this.
          { icon = '  ', desc = 'Open Last session                ', key = 'o', key_format = ' %s', action = 'SessionRestore' },
        },
        packages = { enable = true },
      },
    },
  },

  -----------------------------------------------------------------------------
  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
      icons_enabled = true,
      theme = 'auto', -- you can choose a specific theme here
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },

      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = {
          {
            'filename',
            file_status = true,
            path = 3,
          },
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = {},
    },
  },

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
