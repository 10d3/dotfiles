return {
  "folke/persistence.nvim",
  -- Remove event = "BufReadPre" so the plugin loads eagerly at startup
  lazy = false,
  opts = {
    -- optional: customize where sessions are saved
    -- dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
  },
  config = function(_, opts)
    require("persistence").setup(opts)
  end,
  -- init = function()
  --   vim.api.nvim_create_autocmd("UIEnter", {
  --     group = vim.api.nvim_create_augroup("persistence_auto_load", { clear = true }),
  --     once = true,
  --     nested = true,
  --     callback = function()
  --       local argc = vim.fn.argc(-1) --[[@as integer]]
  --       local is_dir = argc == 1 and vim.fn.isdirectory(vim.fn.argv(0)) --[[@as string]] == 1
  --       if (argc == 0 or is_dir) and not vim.g.started_with_stdin then
  --         require("persistence").load()
  --       end
  --     end,
  --   })
  -- end,
  keys = {
    {
      "<leader>qs",
      function()
        require("persistence").load()
      end,
      desc = "Restore Session",
    },
    {
      "<leader>qS",
      function()
        require("persistence").select()
      end,
      desc = "Select Session",
    },
    {
      "<leader>ql",
      function()
        require("persistence").load({ last = true })
      end,
      desc = "Restore Last Session",
    },
    {
      "<leader>qd",
      function()
        require("persistence").stop()
      end,
      desc = "Don't Save Current Session",
    },
  },
}
