return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {
      exclude = {
        filetypes = { 'help', 'dashboard', 'packer', 'NvimTree', 'Trouble', 'TelescopePrompt', 'Float' },
        buftypes = { 'terminal', 'nofile', 'telescope' },
      },
      scope = {
        enabled = false,
        show_start = false,
        highlight = 'IblScope',
      },
    },
  },
}
