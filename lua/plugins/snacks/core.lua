return {
  'snacks.nvim',
  opts = {
    bigfile = { enabled = false },
    scroll = { enabled = false },
    terminal = { enabled = true },
    notifier = { enabled = true },
    scratch = { enabled = true },
    explorer = {enabled = true},
    scope = { enabled = false },
    statuscolumn = { enabled = true },
    zen = { enabled = true },
    words = {
      enabled = true,
      debounce = 200, -- time in ms to wait before updating
      notify_jump = false, -- show a notification when jumping
      notify_end = true, -- show a notification when reaching the end
      foldopen = true, -- open folds after jumping
      jumplist = true, -- set jump point before jumping
      modes = { 'n', 'i', 'c' }, -- modes to show references
    },
    profile = { enabled = true },
  },
  --stylua: ignore
  keys = {
    { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },

  },
}
