-- Credits to original theme https://github.com/dracula/vim
-- This is a modified version

local M = {}

M.base_30 = {
  white = '#F8F8F2',
  darker_black = '#222430',
  black = '#22212C', --  nvim bg
  black2 = '#2d303e',
  one_bg = '#373844', -- real bg of onedark
  one_bg2 = '#44475a',
  one_bg3 = '#565761',
  grey = '#5e5f69',
  grey_fg = '#666771',
  grey_fg2 = '#6e6f79',
  light_grey = '#73747e',
  red = '#FF9580',
  baby_pink = '#ff86d3',
  pink = '#FF79C6',
  line = '#3c3d49', -- for lines like vertsplit
  green = '#50fa7b',
  vibrant_green = '#5dff88',
  nord_blue = '#8b9bcd',
  blue = '#a1b1e3',
  yellow = '#F1FA8C',
  sun = '#FFFFA5',
  purple = '#BD93F9',
  dark_purple = '#BD93F9',
  teal = '#92a2d4',
  orange = '#FFB86C',
  cyan = '#80FFEA',
  statusline_bg = '#2d2f3b',
  lightbg = '#41434f',
  pmenu_bg = '#b389ef',
  folder_bg = '#BD93F9',
}
--
-- base00 - Default Background
-- base01 - Lighter Background (Used for status bars, line number and folding marks)
-- base02 - Selection Background
-- base03 - Comments, Invisibles, Line Highlighting
-- base04 - Dark Foreground (Used for status bars)
-- base05 - Default Foreground, Caret, Delimiters, Operators
-- base06 - Light Foreground (Not often used)
-- base07 - Light Background (Not often used)
-- base08 - Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
-- base09 - Integers, Boolean, Constants, XML Attributes, Markup Link Url
-- base0A - Classes, Markup Bold, Search Text Background
-- base0B - Strings, Inherited Class, Markup Code, Diff Inserted
-- base0C - Support, Regular Expressions, Escape Characters, Markup Quotes
-- base0D - Functions, Methods, Attribute IDs, Headings
-- base0E - Keywords, Storage, Selector, Markup Italic, Diff Changed
-- base0F - Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>
M.base_16 = {
  base00 = '#0B0D0F',
  base01 = '#161A1D',
  base02 = '#414D58',
  base03 = '#708CA9',
  base04 = '#9580FF',
  base05 = '#FF80BF',
  base06 = '#80FFEA',
  base07 = '#F8F8F2',
  base08 = '#7970A9',
  base09 = '#9580FF',
  base0A = '#A2FF99',
  base0B = '#FFFF99',
  base0C = '#AA99FF',
  base0D = '#FF99CC',
  base0E = '#FF80BF',
  base0F = '#FFFFFF',
}

-- M.polish_hl = {
--   treesiter = {
--     ['@function.builtin'] = { fg = M.base_30.cyan },
--     ['@number'] = { fg = M.base_30.purple },
--   },
-- }

M.type = 'dark'

M = require('base46').override_theme(M, 'bifdus')

return M
