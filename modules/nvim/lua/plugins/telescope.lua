local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

map('n', '<leader>fo', function() builtin.oldfiles { previewer = false, sorting_strategy = 'descending' } end, opts)
map('n', '<leader>ss', builtin.builtin, opts)
map('n', '<leader>sr', builtin.resume, opts)
map('n', '<leader>sd', builtin.diagnostics, opts)
map('n', '<leader>hh', builtin.help_tags, opts)
map('n', '<leader>ht', builtin.colorscheme, opts)
map('n', '<leader>sp', function() builtin.live_grep { previewer = false } end, opts)
map("n", "<leader>.", function()
    builtin.find_files {
        hidden = false,
        previewer = false,
        theme = 'ivy',
        find_command = { 'rg', '--files', '--color', 'never' }
    }
end, opts)
map('n', '<leader>s.', function()
    builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
    }
end, opts)
map('n', '<leader>/', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, opts)

-- Search Neovim config
map('n', '<leader>sn', function()
    builtin.find_files {
        cwd = "~/.config/nvim",
        -- cwd = vim.fn.stdpath 'config',
        shorten_path = false,
        prompt_title = 'NVIM',
        layout_strategy = "horizontal",
        layout_config = {
            preview_width = 0.35,
        },
    }
end, opts)

map('n', '<leader>sc', function()
    builtin.find_files {
        cwd = '~/.dotfiles',
        shorten_path = false,
        prompt_title = 'Dotfiles',
        layout_strategy = "horizontal",
        layout_config = {
            preview_width = 0.35,
        },
    }
end, opts)





require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-u>"] = false,
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
                ["<esc>"] = actions.close,
            },
            n = {
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
                ["v"] = actions.file_vsplit,
                ["s"] = actions.file_split,
            },
        },
    },
    fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
    },
    extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
        }
    }
}

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'ui-select')
