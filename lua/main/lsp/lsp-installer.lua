local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
end

local handler = require("main.lsp.handlers")
lsp_installer.on_server_ready(function (server)
    local opts = {
        on_attach = handler.on_attach,
        capabilities = handler.capabilities,
    }

    if server.name == "sumneko_lua" then
        local lua_opts = require("main.lsp.settings.sumneko_lua")
        opts = vim.tbl_deep_extend("force", lua_opts, opts)
    end

    if server.name == "jsonls" then
        local json_opts = require("main.lsp.settings.jsonls")
        opts = vim.tbl_deep_extend("force", json_opts, opts)
    end

--[[
    if server.name == "clangd" then
        local clang_opts = require("main.lsp.settings.clangd")
        opts = vim.tbl_deep_extend("force", clang_opts, opts)
    end
--]]

    server:setup(opts)
end)

