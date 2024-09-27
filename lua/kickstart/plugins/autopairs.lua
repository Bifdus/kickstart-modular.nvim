-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  enabled = true,
  event = 'InsertEnter',
  keys = {
    {
      '<leader>tp',
      function()
        require('nvim-autopairs').toggle()
      end,
      desc = 'Toggle Autopairs',
    },
  },
  -- Optional dependency
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    require('nvim-autopairs').setup {
      check_ts = true, -- Treesitter integration
      ts_config = {
        lua = { 'string' },
        javascript = { 'template_string' },
      },
      disable_filetype = { 'TelescopePrompt', 'vim' },
    }
    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
