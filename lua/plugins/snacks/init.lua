return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  import = 'plugins.snacks',
  keys = {
    -- stylua: ignore
    { "<c-\\>",      function() Snacks.terminal() end, desc = "Toggle Terminal"}
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option('spell', { name = 'spelling' }):map '<leader>us'
        Snacks.toggle.option('wrap', { name = 'wrap' }):map '<leader>uw'
        Snacks.toggle.option('relativenumber', { name = 'relative number' }):map '<leader>ul'
        Snacks.toggle.indent():map '<leader>ug'
        Snacks.toggle.diagnostics():map '<leader>ud'
        Snacks.toggle.line_number():map '<leader>ul'
        Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = 'conceal level' }):map '<leader>uc'
        Snacks.toggle.option('showtabline', { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = 'tabline' }):map '<leader>ua'
        Snacks.toggle.treesitter():map '<leader>ut'
        -- Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'dark background' }):map '<leader>ub'
        Snacks.toggle.dim():map '<leader>ud'
        Snacks.toggle.animate():map '<leader>ua'
        Snacks.toggle.scroll():map '<leader>us'
        Snacks.toggle.profiler():map '<leader>upp'
        Snacks.toggle.profiler_highlights():map '<leader>uph'
        Snacks.toggle.zoom():map '<leader>uZ'
        Snacks.toggle.zen():map '<leader>uz'
        Snacks.toggle.treesitter():map '<leader>uT'
        Snacks.toggle.diagnostics():map '<leader>ud'
        require('util.format').snacks_toggle():map '<leader>uf'
      end,
    })
  end,
}
