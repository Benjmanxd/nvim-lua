local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
    return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
    return
end

mason.setup()

local servers = {
    lua_ls = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    },
    clangd = {},
    tsserver = {},
    bashls = {},
    cssls = {},
    dockerls = {},
    html = {},
    jsonls = {},
    pyright = {},
    rust_analyzer = {},
    gopls = {},
}
local mason_lspconfig_config = {
    ensure_installed = vim.tbl_keys(servers),
}
mason_lspconfig.setup(mason_lspconfig_config)
mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      settings = servers[server_name],
    }
  end,
}
