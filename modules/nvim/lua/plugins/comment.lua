vim.g.skip_ts_context_commentstring_module = true
require('ts_context_commentstring').setup({ enable_autocmd = true })

require('Comment').setup({
  toggler = {
    ---Line-comment toggle keymap
    line = "gcc",
    ---Block-comment toggle keymap
    block = "gbc",
  },
  pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})