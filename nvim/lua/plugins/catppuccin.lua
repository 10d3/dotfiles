return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false, -- Make sure it loads during startup
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- or "latte", "frappe", "macchiato"
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}