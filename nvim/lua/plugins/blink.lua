return {
  {
    "Saghen/blink.cmp",
    -- This forces the plugin to compile locally on Windows
    build = "cargo build --release",
    opts = {
      keymap = { preset = "super-tab" },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
  },
}
