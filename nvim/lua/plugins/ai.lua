-- ============================================================================
-- llm.nvim - Complete AI configuration (autocompletion + editing tools)
-- ============================================================================
-- Assumes you have set: vim.g.mapleader = " " (space) in your main config.

return {
  "Kurama622/llm.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "MeanderingProgrammer/render-markdown.nvim", -- optional
  },
  cmd = {
    "LLMSessionToggle",
    "LLMSelectedTextHandler",
    "LLMAppHandler",
    "LLMToggleCompletion",
  },
  config = function()
    -- Load API key from environment or file
    local api_key = vim.env.OPENROUTER_API_KEY or vim.env.OPENCODE_API_KEY
    if not api_key or api_key == "" then
      local key_file = vim.fn.expand("~/.config/nvim/openrouter.key")
      local file = io.open(key_file, "r")
      if file then
        api_key = file:read("*line"):gsub("%s+", "")
        file:close()
      end
    end

    if not api_key or api_key == "" then
      vim.notify("OpenRouter API key not found", vim.log.levels.ERROR)
      return
    end

    require("llm").setup({
      url = "https://openrouter.ai/api/v1/chat/completions",
      model = "minimax/minimax-m2.5:free",
      api_type = "openai",
      max_tokens = 4096,
      temperature = 0.7,
      fetch_key = function()
        return api_key
      end,
      style = "float",

      -- Autocompletion (virtual text)
      completion = {
        enabled = true,
        style = "virtual_text",
        model = "minimax/minimax-m2.5:free",
        url = "https://openrouter.ai/api/v1/chat/completions",
        fetch_key = function()
          return api_key
        end,
        api_type = "openai",
        opts = {
          keymap = {
            virtual_text = {
              accept = { mode = "i", keys = "<Tab>" },
              next = { mode = "i", keys = "<C-n>" },
              prev = { mode = "i", keys = "<C-p>" },
            },
          },
        },
      },

      -- AI Tools
      app_handler = {
        -- Explain code (visual selection)
        explain_code = {
          handler = "flexi_handler",
          prompt = "Explain the following code accurately and concisely. Use Markdown.",
          opts = {
            enter_flexible_window = true,
            apply_visual_selection = true,
          },
        },
        -- Optimize code
        optimize_code = {
          handler = "action_handler",
          prompt = "Optimize the following code for performance and readability. Keep the same language.",
          opts = {
            inline_assistant = true,
            display = { mapping = { mode = "n", keys = { "d" } } },
            accept = { mapping = { mode = "n", keys = { "Y", "y" } } },
            reject = { mapping = { mode = "n", keys = { "N", "n" } } },
          },
        },
        -- Replace selection
        replace_selection = {
          handler = "disposable_ask_handler",
          prompt = "Replace the selected text with a better or corrected version.",
          opts = {
            inline_assistant = false,
            enable_buffer_context = true,
            display = { mapping = { mode = "n", keys = { "d" } } },
            accept = { mapping = { mode = "n", keys = { "Y", "y" } } },
          },
        },
        -- Chat with editing
        chat_with_editing = {
          handler = "attach_to_chat_handler",
          prompt = "You are a coding assistant. Analyze the code and show how you would change it.",
          opts = {
            is_codeblock = true,
            inline_assistant = true,
            enable_buffer_context = true,
            display = { mapping = { mode = "n", keys = { "d" } } },
            accept = { mapping = { mode = "n", keys = { "Y", "y" } } },
          },
        },
      },
    })
  end,

  -- ==========================================================================
  -- KEY MAPPINGS (using the `keys` table)
  -- ==========================================================================
  keys = {
    -- Chat toggle (normal mode)
    { "<leader>ac", "<cmd>LLMSessionToggle<cr>", mode = "n", desc = "AI Chat" },

    -- Explain visual selection (visual mode only)
    { "<leader>ae", "<cmd>LLMAppHandler explain_code<cr>", mode = "v", desc = "AI Explain (visual selection)" },

    -- Optimize code (normal and visual)
    { "<leader>ao", "<cmd>LLMAppHandler optimize_code<cr>", mode = { "n", "v" }, desc = "AI Optimize code" },

    -- Replace selection (visual only)
    { "<leader>ar", "<cmd>LLMAppHandler replace_selection<cr>", mode = "v", desc = "AI Replace selection" },

    -- Chat with editing (normal and visual)
    { "<leader>acw", "<cmd>LLMAppHandler chat_with_editing<cr>", mode = { "n", "v" }, desc = "AI Chat + editing" },

    -- Toggle autocompletion (normal mode)
    { "<leader>ct", "<cmd>LLMToggleCompletion<cr>", mode = "n", desc = "Toggle AI Completion" },
  },
}
