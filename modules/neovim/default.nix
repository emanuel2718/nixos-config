{ inputs, pkgs, lib, ... }:
let 
  gitClone =
      repo: ref: sha:
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
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    plugins = with pkgs; [
      vimPlugins.nvim-autopairs
      vimPlugins.nvim-colorizer-lua
      vimPlugins.toggleterm-nvim
    ];
    extraLuaConfig = ''
      local map = vim.keymap.set

      -- Autopairs
      require('nvim-autopairs').setup()

      -- Colorizer
      require('colorizer').setup()

      -- Term
      require('toggleterm').setup({ direction = 'float' })
      map("n", "<C-t>", "<cmd>ToggleTerm<cr>", { noremap = true, silent = true })
      map("t", "<C-t>", "<cmd>ToggleTerm<cr>", { noremap = true, silent = true })

    '';
  };
}
