return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    event = 'VeryLazy',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      -- require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup {
        mappings = {
          add = 'sa',
          delete = 'sd',
          find = 'sf',
          find_left = 'sF',
          highlight = 'sh',
          replace = 'sc',
          update_n_lines = 'sn',
          suffix_last = '',
          suffix_next = '',
        },
        search_method = 'cover_or_next',
      }

      require('mini.move').setup {
        mappings = {
          up = '<C-Up>',
          down = '<C-Down>',
          left = '<C-Left>',
          right = '<C-Right>',

          line_up = '<C-Up>',
          line_down = '<C-Down>',
          line_left = '<C-Left>',
          line_right = '<C-Right>',
        },
      }

      require('mini.indentscope').setup {
        symbol = '│',
        draw = {
          animation = function()
            return 0
          end,
        },
        options = {
          try_as_border = true,
        },
        mappings = {
          object_scope = '',
          object_scope_with_border = '',
        },
      }
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'dashboard', 'yazi', 'help' },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      --local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      --statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      --statusline.section_location = function()
      --return '%2l:%-2v'
      --end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
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
}
-- vim: ts=2 sts=2 sw=2 et
