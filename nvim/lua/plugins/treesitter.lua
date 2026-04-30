return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- Tell Tree-sitter to use Git instead of Curl
      install_strategy = "git",
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "bash",
        "powershell",
        "python",
        "markdown",
        "typescript",
        "javascript",
        "rust",
        "go",
        "tsx",
      },
      highlight = { enable = true },
    },
  },
}
