return {
  "dmtrKovalenko/fff.nvim",
  build = function()
    -- this will download prebuild binary or try to use existing rustup toolchain to build from source
    -- (if you are using lazy you can use gb for rebuilding a plugin if needed)
    require("fff.download").download_or_build_binary()
  end,
  -- if you are using nixos
  -- build = "nix run .#release",
  opts = { -- (optional)
    prompt = "> ",
    debug = {
      enabled = false, -- we expect your collaboration at least during the beta
      show_scores = false, -- to help us optimize the scoring system, feel free to share your scores!
    },
  },
  -- Avoid loading native backend during startup (can crash on invalid dylib codesign).
  -- Plugin will still load on keypress below.
  lazy = true,
  keys = {
    -- { "<leader>.", function() require("fff").find_files() end, desc = "FFFind Files" },
    {
      "fj", -- try it if you didn't it is a banger keybinding for a picker
      function()
        require("fff").find_files()
      end,
      desc = "FFFind files",
    },
  },
}
