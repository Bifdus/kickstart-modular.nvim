-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    close_if_last_window = true,
    sources = { 'filesystem', 'git_status' },
    open_files_do_not_replace_types = {
      'terminal',
      'Trouble',
      'qf',
      'edgy',
      'Outline',
      'gitsigns.blame',
    },
    popup_border_style = 'rounded',
    sort_case_insensitive = true,
    event_handlers = {
      -- Close neo-tree when opening a file.
      {
        event = 'file_opened',
        handler = function()
          require('neo-tree').close_all()
        end,
      },
    },
    default_component_configs = {
      icon = {
        folder_empty = '',
        folder_empty_open = '',
        default = '',
      },
      modified = {
        symbol = '•',
      },
      name = {
        trailing_slash = true,
        highlight_opened_files = true, -- NeoTreeFileNameOpened
        use_git_status_colors = false,
      },
      git_status = {
        symbols = {
          -- Change type
          added = 'A',
          deleted = 'D',
          modified = 'M',
          renamed = 'R',
          -- Status type
          untracked = 'U',
          ignored = 'I',
          unstaged = '',
          staged = 'S',
          conflict = 'C',
        },
      },
    },
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['<space>'] = 'none',
          ['Y'] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg('+', path, 'c')
            end,
            desc = 'Copy Path to Clipboard',
          },
        },
      },
    },
  },
}
