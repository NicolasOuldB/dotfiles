-- Simplified native LSP configuration using vim.lsp.config and vim.lsp.enable
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Global diagnostics UI
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = { border = "rounded", source = "always" },
})

local function _with_border(fn)
  return function(err, result, ctx, config)
    config = config or {}
    config.border = config.border or "rounded"
    return fn(err, result, ctx, config)
  end
end
vim.lsp.handlers["textDocument/hover"] = _with_border(vim.lsp.handlers.hover)
vim.lsp.handlers["textDocument/signatureHelp"] = _with_border(vim.lsp.handlers.signature_help)

local on_attach = function(client, bufnr)
  local bufopts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.signature_help, bufopts)

  if client.server_capabilities and client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_clear_autocmds({ group = 0, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
    })
  end
end

-- Per-server settings (only override needed servers)
local servers = {
  lua_ls = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
      telemetry = { enable = false },
    },
  },
  -- keep ts server configuration minimal (ts_ls name kept for mason mapping)
}

-- Ensure mason-lspconfig/mason are installed via pack; use them to manage binaries.
-- Register configs and enable them via native APIs
local to_setup = { "lua_ls", "ts_ls", "taplo", "eslint" }

-- Prefer the native Neovim API (vim.lsp.config). Use mason-lspconfig.setup_handlers
-- to let Mason call these handlers for installed servers. If mason-lspconfig is
-- not available, fall back to registering the list directly via native API.
local ok_mason_lsp, mason_lspconfig = pcall(require, "mason-lspconfig")
if ok_mason_lsp and mason_lspconfig then
  mason_lspconfig.setup_handlers({
    -- default handler for all servers
    function(server_name)
      local opts = { on_attach = on_attach, capabilities = capabilities }
      if servers[server_name] then opts.settings = servers[server_name] end
      -- Register with native API (avoid require('lspconfig')[server].setup)
      pcall(function()
        vim.lsp.config(server_name, opts)
        vim.lsp.enable(server_name)
      end)
    end,
  })
else
  -- Fallback: register the explicit list via native API.
  for _, name in ipairs(to_setup) do
    local opts = { on_attach = on_attach, capabilities = capabilities }
    if servers[name] then opts.settings = servers[name] end
    pcall(function()
      vim.lsp.config(name, opts)
      vim.lsp.enable(name)
    end)
  end
end

return true
