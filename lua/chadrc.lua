-- NOTE: NvChad Related Options
-- @type ChadrcConfig

local M = {}

M.base46 = {
  theme = 'bifdus', -- default theme
  hl_add = {},
  hl_override = {},
  integrations = { 'notify' },
  changed_themes = {},
  transparency = false,
  -- theme_toggle = { 'onedark', 'one_light' },
}

M.ui = {
  telescope = { style = 'borderless' }, -- borderless / bordered
  cmp = {
    icons = true,
    lspkind_text = true,
    style = 'default', -- default/flat_light/flat_dark/atom/atom_colored
  },

  statusline = {
    theme = 'default', -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = 'default',
    order = { 'mode', 'f', 'git', '%=', 'lsp_msg', '%=', 'lsp', 'cwd', 'xyz', 'abc' },
    modules = {
      abc = function()
        return 'hi'
      end,

      xyz = 'hi',
      f = '%F',
    },
  },

  -- lazyload it when there are 1+ buffers
  tabufline = {
    enabled = true,
    lazyload = true,
    order = { 'treeOffset', 'buffers', 'tabs', 'btns' },
    modules = nil,
  },
}

M.nvdash = {
  load_on_startup = true,
  header = {
    '           ▄ ▄                   ',
    '       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ',
    '       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ',
    '    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ',
    '  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ',
    '  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄',
    '▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █',
    '█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █',
    '    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ',
    '                                 ',
  },

  buttons = {
    { txt = '  Find File', keys = 'Spc f f', cmd = 'Telescope find_files' },
    { txt = '󰈚  Recent Files', keys = 'Spc f o', cmd = 'Telescope oldfiles' },
    { txt = '󰈭  Find Word', keys = 'Spc f w', cmd = 'Telescope live_grep' },
    { txt = '  Bookmarks', keys = 'Spc m a', cmd = 'Telescope marks' },
    { txt = '  Themes', keys = 'Spc t h', cmd = 'Telescope themes' },
    { txt = '  Mappings', keys = 'Spc c h', cmd = 'NvCheatsheet' },
    { txt = ' Last Session', keys = 'Spc r s', cmd = 'SessionRestore' },
  },
}

M.term = {
  winopts = { number = false, relativenumber = false },
  sizes = { sp = 0.3, vsp = 0.2, ['bo sp'] = 0.3, ['bo vsp'] = 0.2 },
  float = {
    relative = 'editor',
    row = 0.3,
    col = 0.25,
    width = 0.5,
    height = 0.4,
    border = 'single',
  },
}

M.lsp = { signature = false }

M.cheatsheet = {
  theme = 'grid', -- simple/grid
  excluded_groups = { 'terminal (t)', 'autopairs', 'Nvim', 'Opens' }, -- can add group name or with mode
}

M.mason = { cmd = true, pkgs = {} }

return M
