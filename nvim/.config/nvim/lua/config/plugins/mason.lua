-- Configure mason and mason-lspconfig so :Mason is initialized and LSP binaries can be managed.
local ok_mason, mason = pcall(require, "mason")
if ok_mason and mason then
  mason.setup()
end

local ok_mason_lsp, mason_lspconfig = pcall(require, "mason-lspconfig")
if ok_mason_lsp and mason_lspconfig then
  mason_lspconfig.setup({
    -- automatically install servers set up via lspconfig handlers (optional)
    automatic_installation = true,
  })
  -- Optional: ensure installed servers call handlers; leaving handlers to lsp config side
end

-- Return a simple sentinel so callers using pcall(require, ...) behave consistently
return {}
