return {
  "folke/which-key.nvim",
  event = "VimEnter",
  opts = {
    icons = {
      mappings = true,
      keys = {},
    },
    spec = {
      -- { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
      -- { '<leader>d', group = '[D]ocument' },
      -- { '<leader>r', group = '[R]ename' },
      { "<leader>s", group = "[S]earch" },
      { "<leader>x", group = "[X]code" },
      -- { '<leader>w', group = '[W]orkspace' },
      -- { '<leader>t', group = '[T]oggle' },
      -- { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    },
  },
}