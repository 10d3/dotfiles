return {
  "lewis6991/gitsigns.nvim",
  lazy = false,
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      current_line_blame = false, -- toggle with <leader>gb
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 300,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      on_attach = function(buf)
        local gs = require("gitsigns")
        local opts = { buffer = buf, silent = true }

        -- Navigation
        vim.keymap.set("n", "]h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, vim.tbl_extend("force", opts, { desc = "Next Hunk" }))

        vim.keymap.set("n", "[h", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, vim.tbl_extend("force", opts, { desc = "Prev Hunk" }))

        -- Actions
        vim.keymap.set("n", "<leader>hs", gs.stage_hunk, vim.tbl_extend("force", opts, { desc = "Stage Hunk" }))
        vim.keymap.set("n", "<leader>hr", gs.reset_hunk, vim.tbl_extend("force", opts, { desc = "Reset Hunk" }))
        vim.keymap.set("n", "<leader>hS", gs.stage_buffer, vim.tbl_extend("force", opts, { desc = "Stage Buffer" }))
        vim.keymap.set("n", "<leader>hR", gs.reset_buffer, vim.tbl_extend("force", opts, { desc = "Reset Buffer" }))
        vim.keymap.set("n", "<leader>hp", gs.preview_hunk, vim.tbl_extend("force", opts, { desc = "Preview Hunk" }))
        vim.keymap.set("n", "<leader>hd", gs.diffthis, vim.tbl_extend("force", opts, { desc = "Diff This" }))
        vim.keymap.set(
          "n",
          "<leader>gb",
          gs.toggle_current_line_blame,
          vim.tbl_extend("force", opts, { desc = "Toggle Line Blame" })
        )

        -- Visual mode: stage/reset selected lines only
        vim.keymap.set("v", "<leader>hs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, vim.tbl_extend("force", opts, { desc = "Stage Selected Hunk" }))

        vim.keymap.set("v", "<leader>hr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, vim.tbl_extend("force", opts, { desc = "Reset Selected Hunk" }))
      end,
    })
  end,
}
