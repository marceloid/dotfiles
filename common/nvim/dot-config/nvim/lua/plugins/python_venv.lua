-- Sets the python3_host_prog to the virtual environment's Python interpreter.
-- This makes Neovim's Python-based plugins and features use the project-specific environment.
return {
  "neovim/nvim-lspconfig",
  init = function()
    local venv_python = vim.fn.getcwd() .. "/.venv/bin/python"
    if vim.fn.filereadable(venv_python) == 1 then
      vim.g.python3_host_prog = venv_python
    end
  end,
}