return {
  -- NOTE: Vue diagnostics come from vue_ls/vtsls.
  -- keep biome off in `.vue` buffers to avoid SFC parse errors
  filetypes = {
    "astro",
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "jsonc",
    "svelte",
    "typescript",
    "typescriptreact",
  },
}
