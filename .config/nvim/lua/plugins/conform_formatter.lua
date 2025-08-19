return {
  {
    "stevearc/conform.nvim",
    -- Dynamically configure formatters to use virtualenv executables if they exist.
    opts = function()
      local function get_venv_executable(name)
        local venv_path = vim.fn.getcwd() .. "/.venv/bin/" .. name
        if vim.fn.executable(venv_path) == 1 then
          return venv_path
        end
        return name -- Fallback to global executable
      end

      return {
        formatters_by_ft = {
          python = { "isort", "ruff_format" },
        },
        formatters = {
          ruff_format = {
            command = get_venv_executable("ruff"),
            args = { "format", "--stdin-filename", "$FILENAME", "-" },
            stdin = true,
          },
          isort = {
            command = get_venv_executable("isort"),
            args = { "--stdout", "--filename", "$FILENAME", "-" },
            stdin = true,
          },
        },
      }
    end,
  },
}

