return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      preset = 'helix',
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },
      triggers = {
        { '<auto>', mode = 'nixsotc' },
        -- Required as of which key 3 for surround mappings to show
        { 's', mode = { 'n' } },
      },
      -- Document existing key chains
      spec = {
        { '<leader><tab>', group = 'Tabs' },
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' }, icon = { icon = '', color = 'blue' } },
        { '<leader>l', group = '[L]earning', mode = { 'n', 'x' }, icon = { icon = '', color = 'blue' } },
        { '<leader>lx', group = 'E[x]ercism', mode = { 'n', 'x' } },
        { '<leader>g', group = '[G]it', icon = { icon = '', color = 'green' } },
        { '<leader>gc', group = '[G]it [C]onflict', icon = { icon = '', color = 'green' } },
        { '<leader>cl', group = '[C]hainsaw [L]og', icon = { icon = '🪚', color = 'green' } },
        { '<leader>o', group = '[O]rgmode', icon = { icon = '', color = 'green' } },
        { '<leader>o', group = '[O]rgmode', icon = { icon = '', color = 'green' } },
        { '<leader>p', group = '[P]icker (Colors)', icon = { icon = '', color = 'green' } },
        { '<leader>q', group = '[Q]uit' },
        { '<leader>s', group = '[S]earch', icon = { icon = '', color = 'green' } },
        { '<leader>u', group = '[T]oggle', icon = { icon = '', color = 'green' } },
        { '<leader>w', group = '[W]indow', icon = { icon = '', color = 'green' } },
        { '<leader>x', group = 'Trouble Diagnostics' },
      },
    },
  },
}
