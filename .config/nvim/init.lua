-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")


local colors = {
  '#FFFFFF', -- 1
  '#FF0000', -- 2
  '#00FF00', -- 3
  '#0000FF', -- 4
  '#FFFF00', -- 5
  '#00FFFF', -- 6
  '#FF00FF', -- 7
  '#FFA500', -- 8
  '#808080', -- 9
}
-- Example for Lua
vim.api.nvim_set_hl(0, 'DiffAdd', { bg = '#34462F' })
vim.api.nvim_set_hl(0, 'DiffDelete', { bg = '#462F2F' })
vim.api.nvim_set_hl(0, 'DiffChange', { bg = '#2F4146' })
vim.api.nvim_set_hl(0, 'DiffText', { bg = '#463C2F' })

vim.api.nvim_set_hl(0, 'DiffAdded', { fg = colors[3], bold = true })
vim.api.nvim_set_hl(0, 'DiffRemoved', { fg = colors[2], bold = true })
vim.api.nvim_set_hl(0, 'DiffChanged', { fg = colors[4], bold = true })

vim.api.nvim_set_hl(0, 'DiffviewWinSeparator', { fg = colors[9] })
vim.api.nvim_set_hl(0, 'DiffviewDiffDelete', { fg = colors[9] })
vim.api.nvim_set_hl(0, 'DiffviewFilePanelSelected', { fg = colors[6] })

vim.api.nvim_set_hl(0, 'DiffviewStatusAdded', { fg = colors[3], bold = true })
vim.api.nvim_set_hl(0, 'DiffviewStatusUntracked', { fg = colors[8], bold = true })
vim.api.nvim_set_hl(0, 'DiffviewStatusModified', { fg = colors[4], bold = true })
vim.api.nvim_set_hl(0, 'DiffviewStatusRenamed', { fg = colors[3], bold = true })
vim.api.nvim_set_hl(0, 'DiffviewStatusDeleted', { fg = colors[2], bold = true })
vim.api.nvim_set_hl(0, 'DiffviewStatusIgnored', { fg = colors[9], bold = true })
