return {
  on_attach = function(client)
    -- Keep hover/docs on basedpyright to avoid duplicate Python hover providers.
    client.server_capabilities.hoverProvider = false
  end,
}
