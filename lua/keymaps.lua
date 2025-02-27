-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
--

-----------------------------------------------------------------------------
-- NOTE: If you aren't using colemak, comment these out

-- Moves through display-lines, unless count is provided
vim.keymap.set({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = 'Down' })
vim.keymap.set({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = 'Up' })

-- Repurpose hjkl for window switching
vim.keymap.set('n', 'l', '<c-w>h', { noremap = true })
vim.keymap.set('n', 'h', '<c-w>l', { noremap = true })
vim.keymap.set('n', 'j', '<c-w>k', { noremap = true })
vim.keymap.set('n', 'k', '<c-w>j', { noremap = true })

-----------------------------------------------------------------------------

-- Disable default s functionality as it conflicts with mini surround
vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')
vim.keymap.set({ 'n', 'x' }, 'S', '<Nop>')
-- Janky fix, couldn't get flash unbinds to work
vim.keymap.set({ 'n', 'x', 'o' }, ';', '<Nop>')
vim.keymap.set({ 'n', 'x', 'o' }, ',', '<Nop>')

-- Reselect the text that has just been pasted, see also https://stackoverflow.com/a/4317090/6064933.
vim.keymap.set('n', '<leader>v', "printf('`[%s`]', getregtype()[0])", {
  expr = true,
  desc = 'reselect last pasted area',
})

-- Always use very magic mode for searching
vim.keymap.set('n', '/', [[/\v]])

-- Change text without putting it into the vim register,
-- see https://stackoverflow.com/q/54255/6064933
vim.keymap.set('n', 'c', '"_c')
vim.keymap.set('n', 'C', '"_C')
vim.keymap.set('n', 'cc', '"_cc')
vim.keymap.set('x', 'c', '"_c')

-- Replace visual selection with text in register, but not contaminate the register,
-- see also https://stackoverflow.com/q/10723700/6064933.
vim.keymap.set('x', 'p', '"_c<Esc>p')

-- insert semicolon at the end of line when in insert mode
vim.keymap.set('i', '<A-;>', '<Esc>miA;<Esc>`ii')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>qq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- Disable in lazygit and ignore key in which key
vim.keymap.set('t', '<Esc><Esc>', function()
  local buf_name = vim.api.nvim_buf_get_name(0)
  if buf_name:match 'lazygit' or buf_name:match 'yazi' then
    return '<Esc>'
  else
    return '<C-\\><C-n>'
  end
end, { expr = true, nowait = true, desc = 'which_key_ignore' })

-- TODO: Configure Lazygit current file history (see lazyvim.lazygit)
-- vim.keymap.set('n', '<leader>lf', function()
--   local git_path = vim.api.nvim_buf_get_name(0)
--   require 'custom.functions.lazygit' { args = { '-f', vim.trim(git_path) } }
-- end, { desc = 'Lazygit Current File History' })

-- Shift tab to dedent
vim.keymap.set('i', '<S-Tab>', '<C-d>', { noremap = true, silent = true })

-- save file
vim.keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save File' })

-- Quit
vim.keymap.set('n', '<leader>qa', '<cmd>qa<cr>', { desc = 'Quit All' })

-- windows
vim.keymap.set('n', '<leader>ww', '<C-W>p', { desc = 'Other Window', remap = true })
vim.keymap.set('n', '<leader>wd', '<C-W>c', { desc = 'Delete Window', remap = true })
vim.keymap.set('n', '<leader>w-', '<C-W>v', { desc = 'Split Window Below', remap = true })
vim.keymap.set('n', '<leader>w|', '<C-W>s', { desc = 'Split Window Right', remap = true })
vim.keymap.set('n', '<leader>-', '<C-W>v', { desc = 'Split Window Below', remap = true })
vim.keymap.set('n', '<leader>|', '<C-W>s', { desc = 'Split Window Right', remap = true })
vim.keymap.set('n', '<leader>wc', '<cmd>windo diffthis<cr>', { desc = '[c]ompare [w]indows' })

-- Resize window using <ctrl> arrow keys
-- vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease Window Height' })
-- vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease Window Width' })
-- vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase Window Width' })

-- tabs
vim.keymap.set('n', '<leader><tab>l', '<cmd>tablast<cr>', { desc = 'Last Tab' })
vim.keymap.set('n', '<leader><tab>o', '<cmd>tabonly<cr>', { desc = 'Close Other Tabs' })
vim.keymap.set('n', '<leader><tab>f', '<cmd>tabfirst<cr>', { desc = 'First Tab' })
vim.keymap.set('n', '<leader><tab>N', '<cmd>tabnew<cr>', { desc = 'New Tab' })
vim.keymap.set('n', '<leader><tab>n', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
vim.keymap.set('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
vim.keymap.set('n', '<leader><tab>p', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })

-- Run Lua code
vim.keymap.set('n', '<leader>lr', '<cmd>.lua<CR>', { desc = 'Run current line as Lua code' })
vim.keymap.set('v', '<leader>lR', [[<Esc><cmd>'<,'>lua<CR>]], { desc = 'Run selected lines as Lua code' })

-----------------------------------------------------------------------------
-- Iswap - swap parameters or textobjects
vim.keymap.set('n', '<leader>is', ':ISwapWith<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>in', ':ISwapNodeWith<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ih', ':ISwapNode<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>io', ':ISwap<CR>', { noremap = true, silent = true })

-----------------------------------------------------------------------------
-- Spectre find and replace
vim.keymap.set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', {
  desc = 'Toggle Spectre',
})
vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
  desc = 'Search current word',
})
vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
  desc = 'Search on current file',
})

-- Toggle Options
--
-- lazyvim.format.snacks_toggle():map '<leader>uf'
-- lazyvim.format.snacks_toggle(true):map '<leader>uf'
Snacks.toggle.option('spell', { name = 'spelling' }):map '<leader>us'
Snacks.toggle.option('wrap', { name = 'wrap' }):map '<leader>uw'
Snacks.toggle.option('relativenumber', { name = 'relative number' }):map '<leader>ul'
Snacks.toggle.indent():map '<leader>ug'
Snacks.toggle.diagnostics():map '<leader>ud'
Snacks.toggle.line_number():map '<leader>ul'
Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = 'conceal level' }):map '<leader>uc'
Snacks.toggle.option('showtabline', { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = 'tabline' }):map '<leader>ua'
Snacks.toggle.treesitter():map '<leader>ut'
Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'dark background' }):map '<leader>ub'
Snacks.toggle.dim():map '<leader>ud'
Snacks.toggle.animate():map '<leader>ua'
Snacks.toggle.scroll():map '<leader>us'
Snacks.toggle.profiler():map '<leader>dpp'
Snacks.toggle.profiler_highlights():map '<leader>dph'
Snacks.toggle.zoom():map('<leader>wm'):map '<leader>uZ'
Snacks.toggle.zen():map '<leader>uz'
Snacks.toggle.treesitter():map '<leader>uT'
Snacks.toggle.diagnostics():map '<leader>ud'
require('util.format').snacks_toggle():map '<leader>uf'


-- floating terminal
--
-- stylua: ignore
vim.keymap.set("n", "<c-\\>", function() Snacks.terminal() end, { desc = "Terminal (cwd)" })
-- TODO: fix this
-- vim.keymap.set("n", "<leader>ft", function() Snacks.terminal(nil, { cwd = LazyVim.root.get() }) end, { desc = "Terminal (Root Dir)" })
-- vim.keymap.set("n", "<c-/>",      function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
-- vim.keymap.set("n", "<c-_>",      function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "which_key_ignore" })

-----------------------------------------------------------------------------
-- Chainsaw logging Plugin

-- log the name & value of the variable under the cursor
vim.keymap.set('n', '<leader>clv', '<cmd>lua require("chainsaw").variableLog() <CR>', { noremap = true, silent = true, desc = '[c]hainsaw [l]og [v]ariable' })

-- like variableLog, but with syntax specific to inspect an object such as
-- `console.log(JSON.stringify(foobar))` in javascript
vim.keymap.set('n', '<leader>clo', '<cmd>lua require("chainsaw").objectLog()<CR>', { noremap = true, silent = true, desc = '[c]hainsaw [l]og [o]bject' })

-- inspect the type of the variable under cursor, such as `typeof foo` in js
vim.keymap.set('n', '<leader>clt', '<cmd>lua require("chainsaw").typeLog()<CR>', { noremap = true, silent = true, desc = '[c]hainsaw [l]og [t]ype' })

-- assertion statement for variable under cursor
vim.keymap.set('n', '<leader>cla', '<cmd>lua require("chainsaw").assertLog()<CR>', { noremap = true, silent = true, desc = '[c]hainsaw [l]og [a]ssert' })

-- Minimal log statement, with an emoji for differentiation. Intended for
-- control flow inspection, i.e. to quickly glance whether a condition was
-- triggered or not. (Inspired by AppleScript's `beep` command.)
vim.keymap.set('n', '<leader>clb', '<cmd>lua require("chainsaw").beepLog()<CR>', { noremap = true, silent = true, desc = '[c]hainsaw [l]og [b]eep' })

-- create log statement, and position the cursor to enter a message
vim.keymap.set('n', '<leader>clm', '<cmd>lua require("chainsaw").messageLog()<CR>', { noremap = true, silent = true, desc = '[c]hainsaw [l]og [m]essage' })

-- 1st call: start measuring the time
-- 2nd call: logs the time duration since
vim.keymap.set('n', '<leader>clT', '<cmd>lua require("chainsaw").timeLog()<CR>', { noremap = true, silent = true, desc = '[c]hainsaw [l]og [T]ime' })

-- debug statements like `debugger` in javascript or `breakpoint()` in python
vim.keymap.set('n', '<leader>cld', '<cmd>lua require("chainsaw").debugLog()<CR>', { noremap = true, silent = true, desc = '[c]hainsaw [l]og [d]ebug' })

-- prints the stacktrace of the current call
vim.keymap.set(
  'n',
  '<leader>cls',
  '<cmd>lua require("chainsaw").stacktraceLog()<CR>',
  { noremap = true, silent = true, desc = '[c]hainsaw [l]og [s]tackTrace' }
)

-- clearing statement, such as `console.clear()`
vim.keymap.set('n', '<leader>clc', '<cmd>lua require("chainsaw").clearLog()<CR>', { noremap = true, silent = true, desc = '[c]hainsaw [l]og [c]lear' })

-- remove all log statements created by chainsaw
vim.keymap.set('n', '<leader>clr', '<cmd>lua require("chainsaw").removeLogs()<CR>', { noremap = true, silent = true, desc = '[c]hainsaw [l]og [r]emove' })

-----------------------------------------------------------------------------
-- Cycle through todo comments
vim.keymap.set('n', ']t', function()
  require('todo-comments').jump_next()
end, { silent = true, desc = 'Next Todo' })
vim.keymap.set('n', '[t', function()
  require('todo-comments').jump_prev()
end, { silent = true, desc = 'Previous Todo' })

-----------------------------------------------------------------------------
--- Minty color picker
vim.keymap.set('n', '<leader>pc', '<cmd>Huefy<cr>')

vim.keymap.set('n', '<leader>ps', '<cmd>Shades<cr>')

-----------------------------------------------------------------------------
--- Spider
vim.keymap.set({ 'n', 'o', 'x' }, 'w', "<cmd>lua require('spider').motion('w')<CR>", { desc = 'Spider-w' })
vim.keymap.set({ 'n', 'o', 'x' }, 'e', "<cmd>lua require('spider').motion('e')<CR>", { desc = 'Spider-e' })
vim.keymap.set({ 'n', 'o', 'x' }, 'b', "<cmd>lua require('spider').motion('b')<CR>", { desc = 'Spider-b' })
-- Autocommands go below ----
--  See `:help lua-guide-autocommands`

-- vim: ts=2 sts=2 sw=2 et
