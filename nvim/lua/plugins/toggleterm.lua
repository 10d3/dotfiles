return {
  "akinsho/toggleterm.nvim",
  version = "*",
  lazy = false,
  config = function()
    require("toggleterm").setup({
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "float", -- default: float | horizontal | vertical | tab
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 3,
      },
    })
    -- after require("toggleterm").setup(...)
    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
    -- Lazygit integration
    local Terminal = require("toggleterm.terminal").Terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "curved",
      },
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      end,
      on_close = function()
        vim.cmd("startinsert!")
      end,
    })

    vim.keymap.set("n", "<leader>gg", function()
      lazygit:toggle()
    end, { desc = "Lazygit" })
  end,
  keys = {
    { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal Terminal" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Vertical Terminal" },
    { "<leader>gg", desc = "Lazygit" },
  },
}
