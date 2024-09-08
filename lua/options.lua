-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- sets filetype to bigfile when larger than 1.5mb
-- disables some plugins to help with speed
vim.g.bigfile_size = 1024 * 1024 * 1.5 -- 1.5 MB

-- configure lazygit theme based on active colorscheme
vim.g.lazygit_config = true

vim.opt.termguicolors = true

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- No Wrap
vim.opt.wrap = false

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Code collapse
vim.opt.foldenable = false
vim.opt.foldlevel = 49
vim.opt.foldlevelstart = 49
vim.opt.foldcolumn = '0'

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 500

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.smarttab = true

-- Expand tab
vim.opt.expandtab = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 8

-- Set tab spacing
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.breakindent = true
vim.opt.backspace = { 'start', 'eol', 'indent' }
vim.opt.smoothscroll = true -- enable smooth scrolling
--vim.opt.splitkeep = 'cursor'
-- remove command bar
vim.opt.laststatus = 0
vim.opt.showcmd = false
vim.opt.cmdheight = 0
vim.opt.helpheight = 0 -- Disable help window resizing

vim.opt.listchars = {
  tab = '  ',
  extends = '⟫',
  precedes = '⟪',
  conceal = '',
  nbsp = '␣',
  trail = '·',
}
vim.opt.fillchars = {
  foldopen = '', -- 󰅀 
  foldclose = '', -- 󰅂 
  fold = ' ', -- ⸱
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
  horiz = '━',
  horizup = '┻',
  horizdown = '┳',
  vert = '┃',
  vertleft = '┫',
  vertright = '┣',
  verthoriz = '╋',
}

-- Set relative line numbers
vim.o.relativenumber = true

-- Title of file
vim.opt.title = true

-- vim: ts=2 sts=2 sw=2 et
