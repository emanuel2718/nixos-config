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
     -- ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "elixir", "heex", "javascript", "typescript", "tsx", "vue", "yaml", "css", "html", "rust" },
};
