return {
  -- Mason: package manager
  {
    "mason-org/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- Bridge between mason and lspconfig
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "html",
          "cssls",
          "tailwindcss",
          "graphql",
          "clangd",
          "rust_analyzer",
          "pyright",
          "lua_ls",
          "bashls",
          "jsonls",
          "yamlls",
        },
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")

      local capabilities = vim.lsp.protocol.make_client_capabilities()

      local on_attach = function(_, buf)
        local opts = { buffer = buf, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to Definition" }))
        vim.keymap.set(
          "n",
          "gD",
          vim.lsp.buf.declaration,
          vim.tbl_extend("force", opts, { desc = "Go to Declaration" })
        )
        vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "References" }))
        vim.keymap.set(
          "n",
          "gi",
          vim.lsp.buf.implementation,
          vim.tbl_extend("force", opts, { desc = "Go to Implementation" })
        )
        vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover Docs" }))
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename" }))
        vim.keymap.set(
          "n",
          "<leader>ca",
          vim.lsp.buf.code_action,
          vim.tbl_extend("force", opts, { desc = "Code Action" })
        )
        vim.keymap.set(
          "n",
          "<leader>d",
          vim.diagnostic.open_float,
          vim.tbl_extend("force", opts, { desc = "Line Diagnostics" })
        )
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Prev Diagnostic" }))
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next Diagnostic" }))
      end

      -- Apply to all servers
      local servers = {
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
        "graphql",
        "clangd",
        "rust_analyzer",
        "pyright",
        "bashls",
        "jsonls",
        "yamlls",
      }

      for _, server in ipairs(servers) do
        lspconfig[server].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end

      -- Lua gets special treatment (knows about vim global)
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })
    end,
  },
}
