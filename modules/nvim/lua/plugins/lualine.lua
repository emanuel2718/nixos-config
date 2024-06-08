require('lualine').setup {
  options = {
    icons_enabled = true,
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { "branch",
      {
        "filename",
        file_status = true,
        newfile_satus = true,
        path = 1,
        shorting_target = 40,
      }
    },
    lualine_c = { "diagnostics" },
    lualine_x = { 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
}
