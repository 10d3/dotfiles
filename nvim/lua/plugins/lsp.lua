return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- This ensures LSP features like auto-imports are prioritized
      autoformat = true,
      servers = {
        -- TypeScript / JavaScript
        vtsls = {
          settings = {
            typescript = {
              suggest = {
                autoImports = true,
              },
            },
            javascript = {
              suggest = {
                autoImports = true,
              },
            },
          },
        },
        -- Rust (Rust-Analyzer)
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              completion = {
                autoimport = { enable = true },
              },
            },
          },
        },
        -- Go (Gopls)
        gopls = {
          settings = {
            gopls = {
              usePlaceholders = true,
              completeUnimported = true, -- This is the magic line for Go
            },
          },
        },
      },
    },
  },
}
