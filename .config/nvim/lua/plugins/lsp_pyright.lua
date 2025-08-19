-- Configures the Pyright language server to use the project's virtual environment.
-- This ensures that Pyright correctly analyzes your code based on the installed packages.
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              pythonPath = vim.fn.getcwd() .. "/.venv/bin/python",
            },
          },
        },
      },
    },
  },
}