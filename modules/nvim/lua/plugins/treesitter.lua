local function check_file_size(_, bufnr)
  return vim.api.nvim_buf_line_count(bufnr) > 10000
end

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = check_file_size
  },
  indent = { enable = true },
};
