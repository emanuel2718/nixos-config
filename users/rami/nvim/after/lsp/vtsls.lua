local vue_language_server_path = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server"

local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_language_server_path,
  enableForWorkspaceTypeScriptVersions = true,
  languages = { "vue" },
  configNamespace = "typescript",
}

return {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
  },
  settings = {
    vtsls = {
      autoUseWorkspaceTsdk = true,
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
    typescript = {
      suggest = {
        completeFunctionCalls = true,
      },
      updateImportsOnFileMove = {
        enabled = "always",
      },
      inlayHints = {
        enumMemberValues = {
          enabled = true,
        },
        functionLikeReturnTypes = {
          enabled = true,
        },
        parameterNames = {
          enabled = "literals",
        },
        parameterTypes = {
          enabled = true,
        },
        propertyDeclarationTypes = {
          enabled = true,
        },
        variableTypes = {
          enabled = false,
        },
      },
    },
    javascript = {
      suggest = {
        completeFunctionCalls = true,
      },
      updateImportsOnFileMove = {
        enabled = "always",
      },
      inlayHints = {
        enumMemberValues = {
          enabled = true,
        },
        functionLikeReturnTypes = {
          enabled = true,
        },
        parameterNames = {
          enabled = "literals",
        },
        parameterTypes = {
          enabled = true,
        },
        propertyDeclarationTypes = {
          enabled = true,
        },
        variableTypes = {
          enabled = false,
        },
      },
    },
  },
}
