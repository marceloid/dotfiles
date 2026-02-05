-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.wrap = true
vim.opt.exrc = true -- allow reading .nvimrc files
--
-- Enable wrapping when in diff mode
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "diff",
  callback = function()
    if vim.o.diff then
      vim.opt.wrap = true         -- wrap long lines
      vim.opt.linebreak = true    -- wrap at word boundaries
      vim.opt.breakindent = true  -- keep indentation on wrapped lines
    end
  end,
})

vim.opt.spell = true
vim.opt.spelllang = "en,en_gb,pt"

