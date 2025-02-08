local M = setmetatable({}, {
  __call = function(m, ...)
    return m.open(...)
  end,
})

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
