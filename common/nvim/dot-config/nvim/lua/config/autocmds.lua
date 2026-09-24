-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`

-- Ao abrir o Neovim passando um diretório (ex: `nvim .`), abre o Dashboard em vez do file tree
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("snacks_dashboard_on_dir", { clear = true }),
  callback = function()
    if vim.fn.argc(-1) == 1 then
      local arg = vim.fn.argv(0)
      if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
        vim.schedule(function()
          if Snacks and Snacks.dashboard then
            Snacks.dashboard.open()
          end
        end)
      end
    end
  end,
})
