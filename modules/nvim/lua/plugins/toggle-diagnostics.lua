function ToggleLSPDiagnostics()
    local virtual_text = vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_text = not virtual_text })
end


local opts = { noremap = false, silent = true }
local map = vim.keymap.set
require("toggle_lsp_diagnostics").init({ start_on = true, virtual_text = true, underline = true })
map("n", "<leader>dd", "<cmd>ToggleDiag<cr>", opts)
map('n', '<leader>dD', "<cmd>lua ToggleLSPDiagnostics()<cr>", opts)
