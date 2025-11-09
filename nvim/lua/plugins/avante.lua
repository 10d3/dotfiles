return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  build = "make",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("avante").setup({
      provider = "claude", -- or "openai" for ChatGPT
      providers = {
        claude = {
          api_key_name = "ANTHROPIC_API_KEY",
          model = "claude-sonnet-4-5-20250929",
        --   temperature = 0,
        --   max_tokens = 4096,
        },
      },
    })
  end,
}