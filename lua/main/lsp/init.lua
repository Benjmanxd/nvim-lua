local lsp_status_ok, _ = pcall(require, "lspconfig")
if not lsp_status_ok then
    return
end

require "main.lsp.lsp-installer"
require "main.lsp.handlers".setup()
