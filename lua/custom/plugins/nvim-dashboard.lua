return {
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    opts = {
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
          {
            icon = ' ',
            desc = 'Open Config Folder               ',
            key = 'c',
            key_format = ' %s',
            action = 'lua require("custom.functions.utils").open_config_folder()',
          },
          -- TODO: Install auto session and enable this.
          -- { icon = '  ', desc = 'Open Last session                ', key = 's', key_format = ' %s', action = 'SessionLoad' },
        },
        packages = { enable = true },
      },
    },
  },
}
