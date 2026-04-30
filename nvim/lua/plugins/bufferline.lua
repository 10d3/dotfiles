return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        -- Style of the tabs
        mode = "buffers", -- show open buffers
        separator_style = "thin", -- 'thick' | 'thin' | 'slant' are popular

        -- The "Mac" Look: show close buttons only on hover
        show_buffer_close_icons = true,
        show_close_icon = false,

        -- How names are displayed
        diagnostics = "nvim_lsp", -- show error icons in the tab name
        always_show_bufferline = true,

        -- Customizing the name
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          },
        },

        -- This part makes the "active" tab stand out more
        indicator = {
          style = "underline", -- adds a nice line under the active file
        },
      },
    },
  },
}

