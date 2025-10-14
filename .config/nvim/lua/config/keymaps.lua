-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Diff all open windows
vim.keymap.set("n", "<leader>Dd", function()
  vim.cmd("windo diffthis")
end, { desc = "Diff all open windows" })
vim.keymap.set("n", "<leader>Do", function()
  vim.cmd("windo diffoff")
end, { desc = "Turn off diff mode in all windows" })

