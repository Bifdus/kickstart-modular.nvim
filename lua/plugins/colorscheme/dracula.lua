-- Check if Dracula Pro theme is available, otherwise use Tokyonight
return (function()
  local dracula_path = vim.fn.has 'linux' and vim.fn.expand '~/.local/share/nvim/site/pack/themes/start/dracula_pro'
    or vim.fn.expand 'C:/dracula_pro_2.1/themes/vim'

  if vim.fn.isdirectory(dracula_path) == 1 then
    return {
      -- Use the local directory for Dracula Pro
      dir = dracula_path,
      as = 'dracula_pro',
      config = function()
        vim.cmd 'syntax enable'
        vim.cmd 'colorscheme dracula_pro_van_helsing'
        -- Colors for orgmode headlines
        vim.cmd [[highlight Headline1 guibg=#1e2718]]
        vim.cmd [[highlight Headline2 guibg=#21262d]]
        vim.cmd [[highlight CodeBlock guibg=#1c1c1c]]
        vim.cmd [[highlight Dash guibg=#D19A66 gui=bold]]

        -- Colors for rainbow highlights
        vim.cmd [[
          highlight RainbowDelimiterRed    guifg=#FF7687 ctermfg=9,
          highlight RainbowDelimiterYellow guifg=#f2f200 ctermfg=11,
          highlight RainbowDelimiterBlue   guifg=#2CCCFF ctermfg=12,
          highlight RainbowDelimiterOrange guifg=#fcbf7a ctermfg=1,
          highlight RainbowDelimiterGreen  guifg=#00c790 ctermfg=4,
          highlight RainbowDelimiterViolet guifg=#BD93F9 ctermfg=5,
          highlight RainbowDelimiterCyan   guifg=#80FFEA ctermfg=13,
        ]]
      end,
    }
  else
    -- Fallback to tokyonight if Dracula Pro is not available
    return {
      'folke/tokyonight.nvim',
      config = function()
        vim.cmd 'syntax enable'
        vim.cmd 'colorscheme tokyonight'
      end,
    }
  end
end)()
