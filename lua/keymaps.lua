-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Disable default s functionality as it conflicts with mini surround
vim.keymap.set({ 'n', 'x' }, 's', '<Nop>')
vim.keymap.set({ 'n', 'x' }, 'S', '<Nop>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>qq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- Disable in lazygit and ignore key in which key
vim.keymap.set('t', '<Esc><Esc>', function()
  local buf_name = vim.api.nvim_buf_get_name(0)
  if buf_name:match 'lazygit' then
    return '<Esc>'
  else
    return '<C-\\><C-n>'
  end
end, { expr = true, nowait = true, desc = 'which_key_ignore' })

--checking for key mappings
vim.api.nvim_set_keymap('n', '<C-w>s', ':vsplit<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-w>v', ':split<CR>', { noremap = true, silent = true })

-- Repurpose hjkl for window switching
vim.keymap.set('n', 'h', '<c-w>h', { noremap = true })
vim.keymap.set('n', 'l', '<c-w>l', { noremap = true })
vim.keymap.set('n', 'k', '<c-w>k', { noremap = true })
vim.keymap.set('n', 'j', '<c-w>j', { noremap = true })

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
vim.keymap.set('n', '<leader><tab>n', '<cmd>tabnew<cr>', { desc = 'New Tab' })
vim.keymap.set('n', '<leader><tab>]', '<cmd>tabnext<cr>', { desc = 'Next Tab' })
vim.keymap.set('n', '<leader><tab>d', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
vim.keymap.set('n', '<leader><tab>[', '<cmd>tabprevious<cr>', { desc = 'Previous Tab' })

-- Run Lua code
vim.keymap.set('n', '<leader>lr', '<cmd>.lua<CR>', { desc = 'Run current line as Lua code' })
vim.keymap.set('v', '<leader>lR', [[<Esc><cmd>'<,'>lua<CR>]], { desc = 'Run selected lines as Lua code' })

-- Iswap
vim.keymap.set('n', '<leader>is', ':ISwapWith<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>in', ':ISwapNodeWith<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ih', ':ISwapNode<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>io', ':ISwap<CR>', { noremap = true, silent = true })

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

----------------------------------------------------------------------------------------------------------------------------
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

----------------------------------------------------------------------------------------------------------------------------

-- Surrounding add to visual select
vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true })

-- Autocommands go below ----
--  See `:help lua-guide-autocommands`

-- vim: ts=2 sts=2 sw=2 et
