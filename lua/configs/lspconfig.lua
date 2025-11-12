local lsp_zero = require("lsp-zero")
lsp_zero.extend_lspconfig()

-- client capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }
capabilities.textDocument.completion.completionItem.snippetSupport = true

local function setup_server(name, opts)
  vim.lsp.config[name] = vim.tbl_extend("force", {
    capabilities = capabilities,
  }, opts or {})
end

-- basedpyright
setup_server("basedpyright", {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "basic",
      },
    },
  },
})

-- biome
setup_server("biome", {
  settings = {
    formatter = {
      indentWidth = 4,
    },
  },
})

lsp_zero.setup_servers({
  "basedpyright",
  "bashls",
  "biome",
  "clangd",
  "css_variables",
  "cssls",
  "gopls",
  "lua_ls",
  "markdown_oxide",
  "marksman",
})
