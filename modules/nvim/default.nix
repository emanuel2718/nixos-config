{ pkgs, lib, ... }:
let
  gitClone = repo: ref: sha:
    pkgs.vimUtils.buildVimPlugin {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "http://github.com/${repo}.git";
        ref = ref;
        rev = sha;
      };
    };
in
{


  # xdg.configFile."nvim" = { source = ./config; recursive = true; };
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly.overrideAttrs (_: { CFLAGS = "-O3"; });
    extraLuaConfig = ''
      ${builtins.readFile lua/core/options.lua}
      ${builtins.readFile lua/core/keymaps.lua}
      ${builtins.readFile lua/core/autocmds.lua}
    '';
    plugins = with pkgs; [
      # Telescope
      vimPlugins.plenary-nvim
      vimPlugins.telescope-fzf-native-nvim
      {
        plugin = vimPlugins.telescope-nvim;
        config = builtins.readFile lua/plugins/telescope.lua;
        type = "lua";
      }

      # Formatter
      {
        plugin = vimPlugins.conform-nvim;
        config = ''
          require('conform').setup({
            formatters_by_ft = {
              lua = { "stylua" },
              rust = { 'rustfmt' },
              nix = { 'nixfmt' },
            }
          })
        '';
        type = "lua";

      }

      # LSP
      vimPlugins.neodev-nvim
      vimPlugins.fzf-lua
      # pkgs.vimPlugins.rustaceanvim
      {
        plugin = vimPlugins.nvim-lspconfig;
        config = builtins.readFile lua/plugins/lspconfig.lua;
        type = "lua";
      }

      # cmp
      vimPlugins.cmp-buffer
      vimPlugins.cmp-path
      vimPlugins.cmp-nvim-lua
      vimPlugins.cmp-nvim-lsp
      vimPlugins.lspkind-nvim
      vimPlugins.cmp-cmdline
      vimPlugins.luasnip
      vimPlugins.cmp_luasnip
      {
        plugin = vimPlugins.nvim-cmp;
        config = builtins.readFile lua/plugins/cmp.lua;
        type = "lua";
      }


      ## Treesitter
      vimPlugins.nvim-treesitter.withAllGrammars
      vimPlugins.nvim-treesitter-textobjects
      {
        plugin = vimPlugins.nvim-treesitter;
        config = builtins.readFile lua/plugins/treesitter.lua;
        type = "lua";
      }

      # Neogit
      vimPlugins.diffview-nvim
      {
        plugin = vimPlugins.neogit;
        config = ''
          vim.keymap.set('n', '<leader>g.', '<cmd>Neogit<cr>', { noremap = true, silent = true })
          require('neogit').setup({
            integrations = { diffview = true, fzf_lua = true }
          })
        '';
        type = "lua";
      }

      # Oil
      vimPlugins.nvim-web-devicons
      {
        plugin = vimPlugins.oil-nvim;
        config = builtins.readFile lua/plugins/oil.lua;
        type = "lua";
      }

      # Fidget
      vimPlugins.fidget-nvim

      # Comment
      {
        plugin = vimPlugins.comment-nvim;
        config = "require('Comment').setup()";
        type = "lua";
      }

      # Autopairs
      {
        plugin = vimPlugins.nvim-autopairs;
        config = ''
          require('nvim-autopairs').setup({
            map_char = {
                all = "(",
                tex = "{"
            },
            enable_check_bracket_line = false,
            check_ts = true,
            ts_config = {
                lua = {"string", "source"},
                javascript = {"string", "template_string"},
                java = false
            },
            disable_filetype = {"TelescopePrompt", "spectre_panel"},
            ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
            enable_moveright = true,
            disable_in_macro = false,
            enable_afterquote = true,
            map_bs = true,
            map_c_w = false,
            disable_in_visualblock = false
          })
        '';
        type = "lua";
      }

      # Colorizer
      {
        plugin = vimPlugins.nvim-colorizer-lua;
        config = ''
          require("colorizer").setup {
            filetypes = {
              "typescript",
              "typescriptreact",
              "javascript",
              "javascriptreact",
              "css",
              "html",
              "astro",
              "lua",
            },
            user_default_options = {
              names = false,
              rgb_fn = true,
              hsl_fn = true,
              tailwind = "both",
            },
            buftypes = {},
          }
        '';
        type = "lua";
      }


      # Terminal
      {
        plugin = vimPlugins.FTerm-nvim;
        config = ''
          vim.keymap.set('n', '<C-T>', '<CMD>lua  require("FTerm").toggle()<CR>', { noremap = true, silent = true })
          vim.keymap.set('t', '<C-T>', '<CMD>lua require("FTerm").toggle()<CR>', { noremap = true, silent = true })
          require("FTerm").setup({
            border = "solid",
            blend = 10,
          })
        '';
        type = "lua";
      }

      # Trouble
      {
        plugin = vimPlugins.trouble-nvim;
        config = ''
          local map = vim.keymap.set
          map("n", "<leader>d.", function() require("trouble").toggle("document_diagnostics") end, { noremap = true, silent = true }) 
        '';
        type = "lua";
      }

      # Toggle LSP Diagnostics
      {
        plugin = gitClone "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim" "main" "4fbfb51e3902d17613be0bc03035ce26b9a8d05d";
        config = builtins.readFile lua/plugins/toggle-diagnostics.lua;
        type = "lua";
      }

      vimPlugins.nvim-window-picker
      vimPlugins.nui-nvim
      {
        plugin = vimPlugins.neo-tree-nvim;
        config = builtins.readFile lua/plugins/neotree.lua;
        type = "lua";
      }

      # Colorschemes

      # Gruber Darker
      {
        plugin = gitClone "blazkowolf/gruber-darker.nvim" "main" "a2dda61d9c1225e16951a51d6b89795b0ac35cd6";
        config = ''
          require('gruber-darker').setup({
            bold = false,
            invert = {
              signs = false,
              tabline = false,
              visual = false,
            },
            italic = {
              strings = false,
              comments = true,
              operators = false,
              folds = true,
            },
            undercurl = true,
            underline = true
          })
          vim.cmd.colorscheme("gruber-darker")
        '';
        type = "lua";
      }

      #   # Custom catppuccin
      #   {
      #     plugin = vimPlugins.catppuccin-nvim;
      #     config = ''
      #         require("catppuccin").setup({
      #           background = {
      #               light = "latte",
      #               dark = "mocha",
      #           },
      #           color_overrides = {
      #               latte = {
      #                   rosewater = "#c14a4a",
      #                   flamingo = "#c14a4a",
      #                   red = "#c14a4a",
      #                   maroon = "#c14a4a",
      #                   pink = "#945e80",
      #                   mauve = "#945e80",
      #                   peach = "#c35e0a",
      #                   yellow = "#b47109",
      #                   green = "#6c782e",
      #                   teal = "#4c7a5d",
      #                   sky = "#4c7a5d",
      #                   sapphire = "#4c7a5d",
      #                   blue = "#45707a",
      #                   lavender = "#45707a",
      #                   text = "#654735",
      #                   subtext1 = "#73503c",
      #                   subtext0 = "#805942",
      #                   overlay2 = "#8c6249",
      #                   overlay1 = "#8c856d",
      #                   overlay0 = "#a69d81",
      #                   surface2 = "#bfb695",
      #                   surface1 = "#d1c7a3",
      #                   surface0 = "#e3dec3",
      #                   base = "#f9f5d7",
      #                   mantle = "#f0ebce",
      #                   crust = "#e8e3c8",
      #               },
      #               mocha = {
      #                   rosewater = "#ea6962",
      #                   flamingo = "#ea6962",
      #                   red = "#ea6962",
      #                   maroon = "#ea6962",
      #                   pink = "#d3869b",
      #                   mauve = "#d3869b",
      #                   peach = "#e78a4e",
      #                   yellow = "#d8a657",
      #                   green = "#a9b665",
      #                   teal = "#89b482",
      #                   sky = "#89b482",
      #                   sapphire = "#89b482",
      #                   blue = "#7daea3",
      #                   lavender = "#7daea3",
      #                   text = "#ebdbb2",
      #                   subtext1 = "#d5c4a1",
      #                   subtext0 = "#bdae93",
      #                   overlay2 = "#a89984",
      #                   overlay1 = "#928374",
      #                   overlay0 = "#595959",
      #                   surface2 = "#4d4d4d",
      #                   surface1 = "#404040",
      #                   surface0 = "#0C0C0C",
      #                   surface3 = "#0000AA",
      #                   base = "#0C0C0C",
      #                   mantle = "#0C0C0C",
      #                   crust = "#141617",
      #               },
      #           },
      #           transparent_background = false,
      #           show_end_of_buffer = false,
      #           integration_default = false,
      #           integrations = {
      #               barbecue = { dim_dirname = true, bold_basename = true, dim_context = false, alt_background = false },
      #               cmp = true,
      #               gitsigns = true,
      #               hop = true,
      #               illuminate = { enabled = true },
      #               native_lsp = { enabled = true, inlay_hints = { background = true } },
      #               neogit = true,
      #               neotree = true,
      #               semantic_tokens = true,
      #               treesitter = true,
      #               treesitter_context = true,
      #               vimwiki = true,
      #               which_key = true,
      #           },
      #           highlight_overrides = {
      #               all = function(colors)
      #                   return {
      #                       CmpItemMenu = { fg = colors.surface2 },
      #                       CursorLineNr = { fg = colors.text },
      #                       FloatBorder = { bg = colors.base, fg = colors.surface0 },
      #                       GitSignsChange = { fg = colors.peach },
      #                       LineNr = { fg = colors.overlay0 },
      #                       LspInfoBorder = { link = "FloatBorder" },
      #                       NeoTreeDirectoryIcon = { fg = colors.subtext1 },
      #                       NeoTreeDirectoryName = { fg = colors.subtext1 },
      #                       NeoTreeFloatBorder = { link = "TelescopeResultsBorder" },
      #                       NeoTreeGitConflict = { fg = colors.red },
      #                       NeoTreeGitDeleted = { fg = colors.red },
      #                       NeoTreeGitIgnored = { fg = colors.overlay0 },
      #                       NeoTreeGitModified = { fg = colors.peach },
      #                       NeoTreeGitStaged = { fg = colors.green },
      #                       NeoTreeGitUnstaged = { fg = colors.red },
      #                       NeoTreeGitUntracked = { fg = colors.green },
      #                       NeoTreeIndent = { fg = colors.surface1 },
      #                       NeoTreeNormal = { bg = colors.mantle },
      #                       NeoTreeNormalNC = { bg = colors.mantle },
      #                       NeoTreeRootName = { fg = colors.subtext1, style = { "bold" } },
      #                       NeoTreeTabActive = { fg = colors.text, bg = colors.mantle },
      #                       NeoTreeTabInactive = { fg = colors.surface2, bg = colors.crust },
      #                       NeoTreeTabSeparatorActive = { fg = colors.mantle, bg = colors.mantle },
      #                       NeoTreeTabSeparatorInactive = { fg = colors.crust, bg = colors.crust },
      #                       NeoTreeWinSeparator = { fg = colors.base, bg = colors.base },
      #                       NormalFloat = { bg = colors.base },
      #                       Pmenu = { bg = colors.mantle, fg = "" },
      #                       PmenuSel = { bg = colors.surface3, fg = "" },
      #                       TelescopePreviewBorder = { bg = colors.crust, fg = colors.crust },
      #                       TelescopePreviewNormal = { bg = colors.crust },
      #                       TelescopePreviewTitle = { fg = colors.crust, bg = colors.crust },
      #                       TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
      #                       TelescopePromptCounter = { fg = colors.mauve, style = { "bold" } },
      #                       TelescopePromptNormal = { bg = colors.surface0 },
      #                       TelescopePromptPrefix = { bg = colors.surface0 },
      #                       TelescopePromptTitle = { fg = colors.surface0, bg = colors.surface0 },
      #                       TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
      #                       TelescopeResultsNormal = { bg = colors.mantle },
      #                       TelescopeResultsTitle = { fg = colors.mantle, bg = colors.mantle },
      #                       TelescopeSelection = { bg = colors.surface3 },
      #                       VertSplit = { bg = colors.base, fg = colors.surface0 },
      #                       WhichKeyFloat = { bg = colors.mantle },
      #                       YankHighlight = { bg = colors.surface2 },
      #                       FidgetTask = { fg = colors.subtext2 },
      #                       FidgetTitle = { fg = colors.peach },
      #
      #                       IblIndent = { fg = colors.surface0 },
      #                       IblScope = { fg = colors.overlay0 },
      #
      #                       Boolean = { fg = colors.mauve },
      #                       Number = { fg = colors.mauve },
      #                       Float = { fg = colors.mauve },
      #
      #                       PreProc = { fg = colors.mauve },
      #                       PreCondit = { fg = colors.mauve },
      #                       Include = { fg = colors.mauve },
      #                       Define = { fg = colors.mauve },
      #                       Conditional = { fg = colors.red },
      #                       Repeat = { fg = colors.red },
      #                       Keyword = { fg = colors.red },
      #                       Typedef = { fg = colors.red },
      #                       Exception = { fg = colors.red },
      #                       Statement = { fg = colors.red },
      #
      #                       Error = { fg = colors.red },
      #                       StorageClass = { fg = colors.peach },
      #                       Tag = { fg = colors.peach },
      #                       Label = { fg = colors.peach },
      #                       Structure = { fg = colors.peach },
      #                       Operator = { fg = colors.peach },
      #                       Title = { fg = colors.peach },
      #                       Special = { fg = colors.yellow },
      #                       SpecialChar = { fg = colors.yellow },
      #                       Type = { fg = colors.yellow, style = { "bold" } },
      #                       Function = { fg = colors.green, style = { "bold" } },
      #                       Delimiter = { fg = colors.subtext2 },
      #                       Ignore = { fg = colors.subtext2 },
      #                       Macro = { fg = colors.teal },
      #
      #                       TSAnnotation = { fg = colors.mauve },
      #                       TSAttribute = { fg = colors.mauve },
      #                       TSBoolean = { fg = colors.mauve },
      #                       TSCharacter = { fg = colors.teal },
      #                       TSCharacterSpecial = { link = "SpecialChar" },
      #                       TSComment = { link = "Comment" },
      #                       TSConditional = { fg = colors.red },
      #                       TSConstBuiltin = { fg = colors.mauve },
      #                       TSConstMacro = { fg = colors.mauve },
      #                       TSConstant = { fg = colors.text },
      #                       TSConstructor = { fg = colors.green },
      #                       TSDebug = { link = "Debug" },
      #                       TSDefine = { link = "Define" },
      #                       TSEnvironment = { link = "Macro" },
      #                       TSEnvironmentName = { link = "Type" },
      #                       TSError = { link = "Error" },
      #                       TSException = { fg = colors.red },
      #                       TSField = { fg = colors.blue },
      #                       TSFloat = { fg = colors.mauve },
      #                       TSFuncBuiltin = { fg = colors.green },
      #                       TSFuncMacro = { fg = colors.green },
      #                       TSFunction = { fg = colors.green },
      #                       TSFunctionCall = { fg = colors.green },
      #                       TSInclude = { fg = colors.red },
      #                       TSKeyword = { fg = colors.red },
      #                       TSKeywordFunction = { fg = colors.red },
      #                       TSKeywordOperator = { fg = colors.peach },
      #                       TSKeywordReturn = { fg = colors.red },
      #                       TSLabel = { fg = colors.peach },
      #                       TSLiteral = { link = "String" },
      #                       TSMath = { fg = colors.blue },
      #                       TSMethod = { fg = colors.green },
      #                       TSMethodCall = { fg = colors.green },
      #                       TSNamespace = { fg = colors.yellow },
      #                       TSNone = { fg = colors.text },
      #                       TSNumber = { fg = colors.mauve },
      #                       TSOperator = { fg = colors.peach },
      #                       TSParameter = { fg = colors.text },
      #                       TSParameterReference = { fg = colors.text },
      #                       TSPreProc = { link = "PreProc" },
      #                       TSProperty = { fg = colors.blue },
      #                       TSPunctBracket = { fg = colors.text },
      #                       TSPunctDelimiter = { link = "Delimiter" },
      #                       TSPunctSpecial = { fg = colors.blue },
      #                       TSRepeat = { fg = colors.red },
      #                       TSStorageClass = { fg = colors.peach },
      #                       TSStorageClassLifetime = { fg = colors.peach },
      #                       TSStrike = { fg = colors.subtext2 },
      #                       TSString = { fg = colors.teal },
      #                       TSStringEscape = { fg = colors.green },
      #                       TSStringRegex = { fg = colors.green },
      #                       TSStringSpecial = { link = "SpecialChar" },
      #                       TSSymbol = { fg = colors.text },
      #                       TSTag = { fg = colors.peach },
      #                       TSTagAttribute = { fg = colors.green },
      #                       TSTagDelimiter = { fg = colors.green },
      #                       TSText = { fg = colors.green },
      #                       TSTextReference = { link = "Constant" },
      #                       TSTitle = { link = "Title" },
      #                       TSTodo = { link = "Todo" },
      #                       TSType = { fg = colors.yellow, style = { "bold" } },
      #                       TSTypeBuiltin = { fg = colors.yellow, style = { "bold" } },
      #                       TSTypeDefinition = { fg = colors.yellow, style = { "bold" } },
      #                       TSTypeQualifier = { fg = colors.peach, style = { "bold" } },
      #                       TSURI = { fg = colors.blue },
      #                       TSVariable = { fg = colors.text },
      #                       TSVariableBuiltin = { fg = colors.mauve },
      #
      #                       ["@annotation"] = { link = "TSAnnotation" },
      #                       ["@attribute"] = { link = "TSAttribute" },
      #                       ["@boolean"] = { link = "TSBoolean" },
      #                       ["@character"] = { link = "TSCharacter" },
      #                       ["@character.special"] = { link = "TSCharacterSpecial" },
      #                       ["@comment"] = { link = "TSComment" },
      #                       ["@conceal"] = { link = "Grey" },
      #                       ["@conditional"] = { link = "TSConditional" },
      #                       ["@constant"] = { link = "TSConstant" },
      #                       ["@constant.builtin"] = { link = "TSConstBuiltin" },
      #                       ["@constant.macro"] = { link = "TSConstMacro" },
      #                       ["@constructor"] = { link = "TSConstructor" },
      #                       ["@debug"] = { link = "TSDebug" },
      #                       ["@define"] = { link = "TSDefine" },
      #                       ["@error"] = { link = "TSError" },
      #                       ["@exception"] = { link = "TSException" },
      #                       ["@field"] = { link = "TSField" },
      #                       ["@float"] = { link = "TSFloat" },
      #                       ["@function"] = { link = "TSFunction" },
      #                       ["@function.builtin"] = { link = "TSFuncBuiltin" },
      #                       ["@function.call"] = { link = "TSFunctionCall" },
      #                       ["@function.macro"] = { link = "TSFuncMacro" },
      #                       ["@include"] = { link = "TSInclude" },
      #                       ["@keyword"] = { link = "TSKeyword" },
      #                       ["@keyword.function"] = { link = "TSKeywordFunction" },
      #                       ["@keyword.operator"] = { link = "TSKeywordOperator" },
      #                       ["@keyword.return"] = { link = "TSKeywordReturn" },
      #                       ["@label"] = { link = "TSLabel" },
      #                       ["@math"] = { link = "TSMath" },
      #                       ["@method"] = { link = "TSMethod" },
      #                       ["@method.call"] = { link = "TSMethodCall" },
      #                       ["@namespace"] = { link = "TSNamespace" },
      #                       ["@none"] = { link = "TSNone" },
      #                       ["@number"] = { link = "TSNumber" },
      #                       ["@operator"] = { link = "TSOperator" },
      #                       ["@parameter"] = { link = "TSParameter" },
      #                       ["@parameter.reference"] = { link = "TSParameterReference" },
      #                       ["@preproc"] = { link = "TSPreProc" },
      #                       ["@property"] = { link = "TSProperty" },
      #                       ["@punctuation.bracket"] = { link = "TSPunctBracket" },
      #                       ["@punctuation.delimiter"] = { link = "TSPunctDelimiter" },
      #                       ["@punctuation.special"] = { link = "TSPunctSpecial" },
      #                       ["@repeat"] = { link = "TSRepeat" },
      #                       ["@storageclass"] = { link = "TSStorageClass" },
      #                       ["@storageclass.lifetime"] = { link = "TSStorageClassLifetime" },
      #                       ["@strike"] = { link = "TSStrike" },
      #                       ["@string"] = { link = "TSString" },
      #                       ["@string.escape"] = { link = "TSStringEscape" },
      #                       ["@string.regex"] = { link = "TSStringRegex" },
      #                       ["@string.special"] = { link = "TSStringSpecial" },
      #                       ["@symbol"] = { link = "TSSymbol" },
      #                       ["@tag"] = { link = "TSTag" },
      #                       ["@tag.attribute"] = { link = "TSTagAttribute" },
      #                       ["@tag.delimiter"] = { link = "TSTagDelimiter" },
      #                       ["@text"] = { link = "TSText" },
      #                       ["@text.danger"] = { link = "TSDanger" },
      #                       ["@text.diff.add"] = { link = "diffAdded" },
      #                       ["@text.diff.delete"] = { link = "diffRemoved" },
      #                       ["@text.emphasis"] = { link = "TSEmphasis" },
      #                       ["@text.environment"] = { link = "TSEnvironment" },
      #                       ["@text.environment.name"] = { link = "TSEnvironmentName" },
      #                       ["@text.literal"] = { link = "TSLiteral" },
      #                       ["@text.math"] = { link = "TSMath" },
      #                       ["@text.note"] = { link = "TSNote" },
      #                       ["@text.reference"] = { link = "TSTextReference" },
      #                       ["@text.strike"] = { link = "TSStrike" },
      #                       ["@text.strong"] = { link = "TSStrong" },
      #                       ["@text.title"] = { link = "TSTitle" },
      #                       ["@text.todo"] = { link = "TSTodo" },
      #                       ["@text.todo.checked"] = { link = "Green" },
      #                       ["@text.todo.unchecked"] = { link = "Ignore" },
      #                       ["@text.underline"] = { link = "TSUnderline" },
      #                       ["@text.uri"] = { link = "TSURI" },
      #                       ["@text.warning"] = { link = "TSWarning" },
      #                       ["@todo"] = { link = "TSTodo" },
      #                       ["@type"] = { link = "TSType" },
      #                       ["@type.builtin"] = { link = "TSTypeBuiltin" },
      #                       ["@type.definition"] = { link = "TSTypeDefinition" },
      #                       ["@type.qualifier"] = { link = "TSTypeQualifier" },
      #                       ["@uri"] = { link = "TSURI" },
      #                       ["@variable"] = { link = "TSVariable" },
      #                       ["@variable.builtin"] = { link = "TSVariableBuiltin" },
      #
      #                       ["@lsp.type.class"] = { link = "TSType" },
      #                       ["@lsp.type.comment"] = { link = "TSComment" },
      #                       ["@lsp.type.decorator"] = { link = "TSFunction" },
      #                       ["@lsp.type.enum"] = { link = "TSType" },
      #                       ["@lsp.type.enumMember"] = { link = "TSProperty" },
      #                       ["@lsp.type.events"] = { link = "TSLabel" },
      #                       ["@lsp.type.function"] = { link = "TSFunction" },
      #                       ["@lsp.type.interface"] = { link = "TSType" },
      #                       ["@lsp.type.keyword"] = { link = "TSKeyword" },
      #                       ["@lsp.type.macro"] = { link = "TSConstMacro" },
      #                       ["@lsp.type.method"] = { link = "TSMethod" },
      #                       ["@lsp.type.modifier"] = { link = "TSTypeQualifier" },
      #                       ["@lsp.type.namespace"] = { link = "TSNamespace" },
      #                       ["@lsp.type.number"] = { link = "TSNumber" },
      #                       ["@lsp.type.operator"] = { link = "TSOperator" },
      #                       ["@lsp.type.parameter"] = { link = "TSParameter" },
      #                       ["@lsp.type.property"] = { link = "TSProperty" },
      #                       ["@lsp.type.regexp"] = { link = "TSStringRegex" },
      #                       ["@lsp.type.string"] = { link = "TSString" },
      #                       ["@lsp.type.struct"] = { link = "TSType" },
      #                       ["@lsp.type.type"] = { link = "TSType" },
      #                       ["@lsp.type.typeParameter"] = { link = "TSTypeDefinition" },
      #                       ["@lsp.type.variable"] = { link = "TSVariable" },
      #                   }
      #               end,
      #               latte = function(colors)
      #                   return {
      #                       IblIndent = { fg = colors.mantle },
      #                       IblScope = { fg = colors.surface1 },
      #
      #                       LineNr = { fg = colors.surface1 },
      #                   }
      #               end,
      #           },
      #       })
      #       vim.api.nvim_command("colorscheme catppuccin")
      #     '';
      #     type = "lua";
      #
      #   }
    ];
  };
}
