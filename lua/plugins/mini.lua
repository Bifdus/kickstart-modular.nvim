return {
  {
    'echasnovski/mini.surround',
    opts = {
      mappings = {
        add = 'gsa', -- Add surrounding in Normal and Visual modes
        delete = 'gsd', -- Delete surrounding
        find = 'gsf', -- Find surrounding (to the right)
        find_left = 'gsF', -- Find surrounding (to the left)
        highlight = 'gsh', -- Highlight surrounding
        replace = 'gsr', -- Replace surrounding
        update_n_lines = 'gsn', -- Update `n_lines`
      },
    },
  },
  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { 'string' },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
    config = function(_, opts)
      LazyVim.mini.pairs(opts)
    end,
  },

  -- Trailing whitespace highlight and remove
  {
    'echasnovski/mini.trailspace',
    event = { 'BufReadPost', 'BufNewFile' },
		-- stylua: ignore
		keys = {
			{ '<Leader>cw', '<cmd>lua MiniTrailspace.trim()<CR>', desc = 'Erase Whitespace' },
		},
    opts = {},
  },
}
-- vim: ts=2 sts=2 sw=2 et
