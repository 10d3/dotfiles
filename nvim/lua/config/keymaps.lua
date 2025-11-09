-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Telescope keymaps
local builtin = require('telescope.builtin')

-- File pickers
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help tags' })
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent files' })
vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'Find word under cursor' })

-- Git pickers
vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Git commits' })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Git status' })
vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Git branches' })

-- Other useful pickers
vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Commands' })
vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Keymaps' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Diagnostics' })

-- Telescope lazy (for your telescope-lazy.nvim plugin)
vim.keymap.set('n', '<leader>fp', '<cmd>Telescope lazy<cr>', { desc = 'Lazy plugins' })

-- Nvim-Tree key
vim.keymap.set('n', '<leader>e', ':NvimTreeFindFileToggle<cr>')

-- Buffer navigation (essential only)
vim.keymap.set('n', '<Tab>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-Tab>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Delete buffer' })
vim.keymap.set('n', '<leader>bb', '<cmd>BufferLinePick<cr>', { desc = 'Pick buffer' })

-- Markdown Preview
vim.keymap.set('n', '<leader>mp', '<cmd>MarkdownPreviewToggle<cr>', { desc = 'Toggle Markdown Preview' })

-- -- nvim-comment
-- vim.keymap.set('n', '<leader>/', '<cmd>CommentToggle<cr>', { desc = 'Toggle comment' })
-- vim.keymap.set('v', '<leader>/', '<cmd>CommentToggle<cr>', { desc = 'Toggle comment' })

-- LSP keymaps (only set when LSP attaches to buffer)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = ev.buf, desc = "Go to references" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Hover documentation" })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = ev.buf, desc = "Code action" })
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { buffer = ev.buf, desc = "Format" })
  end,
})

-- Git signs
vim.keymap.set('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<cr>', { desc = 'Preview git hunk' })
vim.keymap.set('n', '<leader>gr', '<cmd>Gitsigns reset_hunk<cr>', { desc = 'Reset git hunk' })
vim.keymap.set('n', '[h', '<cmd>Gitsigns prev_hunk<cr>', { desc = 'Previous git hunk' })
vim.keymap.set('n', ']h', '<cmd>Gitsigns next_hunk<cr>', { desc = 'Next git hunk' })

-- Comments (now handled by Comment.nvim with better keymaps)
vim.keymap.set('n', '<leader>/', 'gcc', { desc = 'Toggle comment', remap = true })
vim.keymap.set('v', '<leader>/', 'gc', { desc = 'Toggle comment', remap = true })


-- Avante
vim.keymap.set('n', '<leader>aa', '<cmd>AvanteAsk<cr>', { desc = 'Ask AI' })
vim.keymap.set('v', '<leader>ae', '<cmd>AvanteEdit<cr>', { desc = 'Edit with AI' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to top window' })

-- ToggleTerm
vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', { desc = 'Toggle floating terminal' })
vim.keymap.set('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<cr>', { desc = 'Toggle horizontal terminal' })
vim.keymap.set('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical size=80<cr>', { desc = 'Toggle vertical terminal' })

-- Terminal mode mappings (to exit terminal mode easily)
vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], { desc = 'Move to left window' })
vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], { desc = 'Move to bottom window' })
vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], { desc = 'Move to top window' })
vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], { desc = 'Move to right window' })

-- Yanky (yank history)
vim.keymap.set({'n', 'x'}, 'p', '<Plug>(YankyPutAfter)', { desc = 'Put after' })
vim.keymap.set({'n', 'x'}, 'P', '<Plug>(YankyPutBefore)', { desc = 'Put before' })
vim.keymap.set({'n', 'x'}, 'gp', '<Plug>(YankyGPutAfter)', { desc = 'GPut after' })
vim.keymap.set({'n', 'x'}, 'gP', '<Plug>(YankyGPutBefore)', { desc = 'GPut before' })

-- Cycle through yank history
vim.keymap.set('n', '<c-p>', '<Plug>(YankyCycleForward)', { desc = 'Cycle yank forward' })
vim.keymap.set('n', '<c-n>', '<Plug>(YankyCycleBackward)', { desc = 'Cycle yank backward' })

-- Open yank history with Telescope
vim.keymap.set('n', '<leader>fy', '<cmd>Telescope yank_history<cr>', { desc = 'Yank history' })

-- Quick text object selections
vim.keymap.set('n', '<leader>vb', 'vi{', { desc = 'Select inside braces' })
vim.keymap.set('n', '<leader>vp', 'vi(', { desc = 'Select inside parentheses' })
vim.keymap.set('n', '<leader>vq', 'vi"', { desc = 'Select inside quotes' })

-- Replace operations
vim.keymap.set('n', '<leader>rp', 'Vp', { desc = 'Replace line with paste' })
vim.keymap.set('n', '<leader>rl', '"_ddP', { desc = 'Replace line (keep clipboard)' })
vim.keymap.set('n', '<leader>rP', 'V"+p', { desc = 'Replace line with system clipboard' })
vim.keymap.set('v', '<leader>rp', 'p', { desc = 'Replace selection with paste' })