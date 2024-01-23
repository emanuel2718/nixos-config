function ToggleLSPDiagnostics()
    local virtual_text = vim.diagnostic.config().virtual_text
    vim.diagnostic.config({ virtual_text = not virtual_text })
end


local opts = { noremap = false, silent = true }
local map = vim.keymap.set
require("toggle_lsp_diagnostics").init({ start_on = true, virtual_text = false, underline = false })
map('n', '<leader>dd', "<cmd>lua ToggleLSPDiagnostics()<cr>", opts)
map("n", "<leader>dD", "<cmd>ToggleDiag<cr>", opts)