local M = setmetatable({}, {
  __call = function(m, ...)
    return m.open(...)
  end,
})

function M.open(opts)
  opts = vim.tbl_deep_extend('force', {}, {
    esc_esc = false,
    ctrl_hjkl = false,
  }, opts or {})

  local cmd = 'lazygit'
  if opts.args then
    cmd = cmd .. ' ' .. table.concat(opts.args, ' ')
  end

  return M.terminal(cmd, opts)
end

function M.terminal(cmd, opts)
  opts = vim.tbl_deep_extend('force', {
    size = { width = 0.9, height = 0.9 },
    on_exit = function() end,
  }, opts or {})

  local Terminal = require('toggleterm.terminal').Terminal
  local term = Terminal:new {
    cmd = cmd,
    hidden = true,
    direction = 'float',
    float_opts = {
      border = 'single',
    },
    on_open = function(t)
      vim.cmd 'startinsert!'
      vim.api.nvim_buf_set_keymap(t.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
    end,
    on_exit = opts.on_exit,
  }
  term:toggle()
end

function M.open_url(remote)
  if remote then
    if vim.fn.has 'nvim-0.10' == 0 then
      require('lazy.util').open(remote.url, { system = true })
      return
    end
    vim.ui.open(remote.url)
  end
end

return M
