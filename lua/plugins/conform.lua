return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      local lsp_format_opt
      if disable_filetypes[vim.bo[bufnr].filetype] then
        lsp_format_opt = 'never'
      else
        lsp_format_opt = 'fallback'
      end
      return {
        timeout_ms = 500,
        lsp_format = lsp_format_opt,
      }
    end,
    formatters = {
      prettier = {
        args = function()
          local expandtab = vim.api.nvim_get_option_value('expandtab', { scope = 'local' })
          local shiftwidth = vim.api.nvim_get_option_value('shiftwidth', { scope = 'local' })
          local tabstop = vim.api.nvim_get_option_value('tabstop', { scope = 'local' })

          local args = { '--stdin-filepath', vim.api.nvim_buf_get_name(0) }
          if expandtab then
            table.insert(args, '--use-tabs=false')
            table.insert(args, '--tab-width=' .. shiftwidth)
          else
            table.insert(args, '--use-tabs=true')
            table.insert(args, '--tab-width=' .. tabstop)
          end
          return args
        end,
        stdin = true,
      },

      -- Add/Modify clang_format to handle Objective-C
      clang_format = {
        -- You can tweak any clang-format style options here, e.g., IndentWidth, UseTab, etc.
        args = { '-style={BasedOnStyle: LLVM, ColumnLimit: 180, IndentWidth: 4, AlignAfterOpenBracket: DontAlign, AlignFunctionCallArguments: None}' },
        stdin = true,
      },
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      -- Add a mapping for Objective-C to clang_format
      objc = { 'clang_format' },
      -- python = { "isort", "black" },
      -- ...
    },
  },
}
