return {
  -- https://github.com/rust-lang/rust-analyzer/issues/3627
  -- https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/generated_config.adoc
  settings = {
    ["rust-analyzer"] = {
      check = { command = "clippy" },
      cargo = { features = "all" },
      interpret = { tests = true },
      rustfmt = {
        extraArgs = { "+nightly", },
        -- overrideCommand = {
        --   "rustup",
        --   "run",
        --   "nightly",
        --   "--",
        --   "rustfmt",
        --   "--edition",
        --   "2021",
        --   "--",
        -- },
      },
    }
  }
}