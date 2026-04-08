return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "taplo", "eslint" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Global diagnostic settings for a cleaner UX
			vim.diagnostic.config({
				virtual_text = false,
				signs = true,
				update_in_insert = false,
				underline = true,
				severity_sort = true,
				float = { border = "rounded", source = "always" },
			})

            -- Provide hover/signature handlers without using deprecated vim.lsp.with()
            local function _with_border(fn)
                return function(err, result, ctx, config)
                    config = config or {}
                    config.border = config.border or "rounded"
                    return fn(err, result, ctx, config)
                end
            end
            vim.lsp.handlers["textDocument/hover"] = _with_border(vim.lsp.handlers.hover)
            vim.lsp.handlers["textDocument/signatureHelp"] = _with_border(vim.lsp.handlers.signature_help)

			-- on_attach sets buffer-local keymaps and other per-buffer behavior
			local on_attach = function(client, bufnr)
				local bufopts = { buffer = bufnr, noremap = true, silent = true }
				vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, bufopts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
				vim.keymap.set("n", "K", vim.lsp.buf.signature_help, bufopts)

				-- Format on save if server supports it (optional)
				if client.server_capabilities.documentFormattingProvider then
					vim.api.nvim_clear_autocmds({ group = 0, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function() vim.lsp.buf.format({ bufnr = bufnr }) end,
					})
				end
			end

            -- Per-server settings (only override what's needed)
			local servers = {
				lua_ls = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true) },
						telemetry = { enable = false },
					},
				},
				-- other servers use defaults
			}

            -- Use mason-lspconfig's setup_handlers to keep configuration DRY.
            -- Use the new builtin vim.lsp.config()/vim.lsp.enable() API instead of
            -- the deprecated require('lspconfig').setup() calls.
            local mlsp = require("mason-lspconfig")
            if mlsp.setup_handlers then
                mlsp.setup_handlers({
                    -- default handler for all servers
                    function(server_name)
                        local opts = {
                            on_attach = on_attach,
                            capabilities = capabilities,
                        }
                        if servers[server_name] then
                            opts.settings = servers[server_name]
                        end
                        -- Register config and enable via builtin API
                        vim.lsp.config(server_name, opts)
                        vim.lsp.enable(server_name)
                    end,
                })
            else
                local to_setup = { "lua_ls", "ts_ls", "taplo", "eslint" }
                for _, server_name in ipairs(to_setup) do
                    local opts = { on_attach = on_attach, capabilities = capabilities }
                    if servers[server_name] then
                        opts.settings = servers[server_name]
                    end
                    vim.lsp.config(server_name, opts)
                    vim.lsp.enable(server_name)
                end
            end
		end,
	},
}
