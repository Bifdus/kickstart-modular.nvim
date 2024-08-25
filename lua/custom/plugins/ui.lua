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
  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = {
      icons_enabled = true,
      theme = 'auto', -- you can choose a specific theme here
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = { 'neo-tree' },

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
  -- Tabs
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>bn', '<Cmd>BufferLineCycleNext<CR>', desc = 'Next tab' },
      { '<leader>bb', '<Cmd>BufferLineCyclePrev<CR>', desc = 'Prev tab' },
    },
    opts = {
      options = {
        mode = 'tabs',
        debug = {
          logging = true,
        },
        version = '*',
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'File Explorer',
            highlight = 'Directory',
            separator = true,
          },
        },
        dependencies = 'nvim-tree-web-devicons',
      },
    },
  },
  -- UI Replacement for messages, cmdline and popup menu
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
  -- Adds scrollbar to buffer
  {
    'petertriho/nvim-scrollbar',
    event = 'BufReadPost',
    opts = { show = true, excluded_filetypes = { 'NvimTree' } },
  },
}
