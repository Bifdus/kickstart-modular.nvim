local M = {}

function M.open_config_folder()
  local config_path = vim.fn.stdpath 'config'
  require('telescope.builtin').find_files { cwd = config_path }
end

return M
