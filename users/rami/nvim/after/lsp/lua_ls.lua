
local root_dir = function(...)
  local lua_ls = require "lspconfig.configs.lua_ls".default_config
  local root = lua_ls.root_dir(...)
  return root and root ~= vim.env.HOME and root or ""
end

return {
  root_dir = function(bufnr, cb_root_dir)
    local bname = vim.api.nvim_buf_get_name(bufnr)
    local root = root_dir(#bname > 0 and bname or vim.uv.cwd())
    cb_root_dir(root)
  end,
  settings = {
    Lua = {
      telemetry = { enable = false },
      runtime = { version = "LuaJIT" },
      workspace = { checkThirdParty = false },
      diagnostics = {
        globals = {
          "vim",
          "require",
        },
      },
    }
  }
}