local function escape_component(text)
  return tostring(text):gsub("%%", "%%%%")
end

local unpack_values = table.unpack or unpack

local MODE_NAMES = {
  n = "NORMAL",
  v = "VISUAL",
  vs = "VISUAL",
  V = "V-LINE",
  Vs = "V-LINE",
  ["\22"] = "V-BLOCK",
  ["\22s"] = "V-BLOCK",
  s = "SELECT",
  S = "S-LINE",
  ["\19"] = "S-BLOCK",
  Rv = "V-REPLACE",
  r = "PROMPT",
  rm = "MORE",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  t = "TERMINAL",
}

local MODE_PREFIX_NAMES = {
  { prefix = "no", name = "NORMAL" },
  { prefix = "ni", name = "NORMAL" },
  { prefix = "nt", name = "NORMAL" },
  { prefix = "i",  name = "INSERT" },
  { prefix = "R",  name = "REPLACE" },
  { prefix = "c",  name = "COMMAND" },
}

local function current_mode()
  if vim.snippet and vim.snippet.active and vim.snippet.active() then
    return "SNIPPET"
  end

  local mode = vim.api.nvim_get_mode().mode
  local exact = MODE_NAMES[mode]
  if exact then
    return exact
  end

  for _, entry in ipairs(MODE_PREFIX_NAMES) do
    if mode:sub(1, #entry.prefix) == entry.prefix then
      return entry.name
    end
  end

  return mode
end

local function starts_with(str, prefix)
  return str:sub(1, #prefix) == prefix
end

local function lsp_root(bufnr, file_path)
  local best

  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    local root = client.config.root_dir
    if root and root ~= "" then
      local normalized = vim.fs.normalize(root)
      if starts_with(file_path, normalized .. "/") or file_path == normalized then
        if not best or #normalized > #best then
          best = normalized
        end
      end
    end
  end

  return best
end

local function git_root(file_path)
  local marker = vim.fs.find(".git", {
    path = vim.fs.dirname(file_path),
    upward = true,
  })[1]

  if marker then
    return vim.fs.dirname(marker)
  end
end

local function relative_path_from_root(bufnr)
  local file_path = vim.api.nvim_buf_get_name(bufnr)
  if file_path == "" then
    return "[No Name]"
  end

  local normalized_file = vim.fs.normalize(file_path)
  local cached = vim.b[bufnr].rami_statusline_path_cache
  if cached and cached.file == normalized_file then
    return cached.relative
  end

  local root = lsp_root(bufnr, normalized_file) or git_root(normalized_file)
  local relative

  if not root or root == "" then
    relative = vim.fn.fnamemodify(normalized_file, ":~:.")
  else
    local normalized_root = vim.fs.normalize(root)
    if starts_with(normalized_file, normalized_root .. "/") then
      relative = normalized_file:sub(#normalized_root + 2)
    elseif normalized_file == normalized_root then
      relative = vim.fn.fnamemodify(normalized_file, ":t")
    else
      relative = vim.fn.fnamemodify(normalized_file, ":~:.")
    end
  end

  vim.b[bufnr].rami_statusline_path_cache = {
    file = normalized_file,
    relative = relative,
  }

  return relative
end

local function git_branch(bufnr)
  local branch = vim.b[bufnr].gitsigns_head
  if branch and branch ~= "" then
    return string.format("[%s]", branch)
  end

  local status = vim.b[bufnr].gitsigns_status_dict
  if type(status) == "table" and status.head and status.head ~= "" then
    return status.head
  end

  return "[-]"
end

local function cursor_position()
  local row, col = unpack_values(vim.api.nvim_win_get_cursor(0))
  return string.format("Ln %d,Col %d", row, col + 1)
end

local function scroll_percentage(bufnr)
  local total_lines = vim.api.nvim_buf_line_count(bufnr)
  if total_lines <= 1 then
    return "100%"
  end

  local row = vim.api.nvim_win_get_cursor(0)[1]
  local pct = math.floor(((row - 1) / (total_lines - 1)) * 100 + 0.5)
  pct = math.max(0, math.min(100, pct))
  return string.format("%d%%", pct)
end

local function render()
  local bufnr = vim.api.nvim_get_current_buf()

  local left = string.format("%s %s", current_mode(), relative_path_from_root(bufnr))
  local right = string.format("%s %s %s", git_branch(bufnr), cursor_position(), scroll_percentage(bufnr))

  return string.format(" %s %%<%%= %s ", escape_component(left), escape_component(right))
end

return {
  {
    dir = vim.fn.stdpath("config"),
    name = "rami-statusline",
    lazy = false,
    priority = 1000,
    config = function()
      local group = vim.api.nvim_create_augroup("rami-statusline-cache", { clear = true })

      local function clear_cache(bufnr)
        if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
          vim.b[bufnr].rami_statusline_path_cache = nil
        end
      end

      vim.api.nvim_create_autocmd({ "LspAttach", "LspDetach", "BufFilePost" }, {
        group = group,
        callback = function(args)
          clear_cache(args.buf)
        end,
      })

      vim.api.nvim_create_autocmd("DirChanged", {
        group = group,
        callback = function()
          for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
            clear_cache(bufnr)
          end
        end,
      })

      _G.rami_statusline_render = render
      vim.o.statusline = "%!v:lua.rami_statusline_render()"
    end,
  },
}
