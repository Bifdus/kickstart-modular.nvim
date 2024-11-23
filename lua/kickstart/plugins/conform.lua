-- For toggling formatting
if vim.g.formatting_enabled == nil then
  vim.g.formatting_enabled = true
end

return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>fb',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
      {
        '<leader>tc',
        function()
          vim.g.formatting_enabled = not vim.g.formatting_enabled
          if vim.g.formatting_enabled then
            vim.notify('Autoformatting enabled', vim.log.levels.INFO)
          else
            vim.notify('Autoformatting disabled', vim.log.levels.WARN)
          end
        end,
        mode = '',
        desc = '[F]ormat Toggle (Autoformatting on save)',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Check if formatting is enabled
        if not vim.g.formatting_enabled then
          return false
        end
        -- Disable "format_on_save lsp_fallback" for specific languages
        local disable_filetypes = { c = true, cpp = true, php = true }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'black' },
        cs = { 'csharpier' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        css = { 'prettierd', 'prettier', stop_after_first = true },
        html = { 'prettierd', 'prettier' },
        json = { 'prettierd', 'prettier' },
        yaml = { 'prettierd', 'prettier' },
        -- Add additional formatters as needed
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
