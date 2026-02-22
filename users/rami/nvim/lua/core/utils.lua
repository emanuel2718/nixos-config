---@diagnostic disable: undefined-global
local M = {}

function M.reload_config()
  for name, _ in pairs(package.loaded) do
    if name:match("^options") or name:match("^keymaps") or name:match("^autocmds") or name:match("^plugins") or name:match("^utils") then
      package.loaded[name] = nil
    end
  end
  pcall(function()
    require("lazy.core.spec").cache = {}
  end)
  vim.cmd("luafile " .. vim.fn.stdpath("config") .. "/init.lua")
  M.info("Configuration reloaded")
end


-- LSP icons
M.icons = {
  Text          = "󰊄", -- 
  Method        = "󰊕",
  Function      = "",
  Constructor   = "", -- 
  Field         = "", -- 󰆧 
  Variable      = "󰆧", -- 󰆧  󰈜
  Class         = "󰌗", --   󰠱  
  Interface     = "", --  󰜰
  Module        = "󰅩",
  Property      = "",
  Unit          = "󰜫", -- 󰆧      󰑭
  Value         = "󰎠",
  Enum          = "󰘨", -- 󰘨   󰕘
  EnumMember    = "",
  Keyword       = "󰌆", -- 󰌋
  Snippet       = "󰘍", --󰅱 󰈙
  Color         = "󰏘", -- 󰌁 󰏘 
  File          = "",
  Folder        = "",
  Reference     = "󰆑", -- 󰀾 󰈇
  Constant      = "󰏿", -- 󰝅 󰔆    󰐀 󰏿 π
  Struct        = "󰙅", -- 
  Event         = "",
  Operator      = "󰒕", -- 󰆕
  TypeParameter = "",
}

return M