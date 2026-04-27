---
name: neovim
tool: neovim
platform: ["macos"]
description: "Neovim diagnostics and tuning advice for repo-scoped configs (native vim.pack)."
capabilities: ["diagnose","patch_template","commands"]
checks: ["pack_eager_loading","lsp_config","lockfile_present","duplicate_plugins"]
redact: true
examples:
  - question: "How to speed up nvim startup?"
    answer: "Identify heavy plugins (telescope, treesitter, nvim-cmp) and consider lazy-loading them. Use headless profiling to find slow modules."
last_updated: "2026-04-27"
maintainers: ["NicolasOuld"]
---

# Neovim Subagent (repo-scoped)

Summary
- Targets Neovim configs under `nvim/.config/nvim` in this repo. Focus on plugin loading (vim.pack), LSP, and startup performance.

Scope
- Uses only files under `~/dotfiles` in this repository. Does not inspect global system-wide nvim configs.

Quick checks
- Is `nvim-pack-lock.json` present in the repo? Committing it ensures deterministic installs across machines.
- Are heavy plugins loaded eagerly via `vim.pack.add(..., { load = true })`? Consider deferring load.

Diagnostic commands (Execute locally)
- Check nvim version:
```sh
nvim --version
```
- Run headless startup time profiling (example):
```sh
nvim --headless -c 'lua vim.cmd("profile start /tmp/profile.log")' -c 'lua vim.cmd("profile func *")' -c 'silent! lua require("config.pack")' -c 'qa'
```
- Install plugins deterministically using native pack (runs as the user):
```sh
nvim --headless -c 'lua vim.pack.load()' -c 'qa'
```

Patch templates
- lazy-load example: conceptual snippet showing how to defer loading of a heavy plugin (adapt to vim.pack usage):

```diff
--- a/.config/nvim/lua/config/pack.lua
+++ b/.config/nvim/lua/config/pack.lua
@@
- "https://github.com/nvim-telescope/telescope.nvim",
+{ src = "https://github.com/nvim-telescope/telescope.nvim", lazy = true, keys = {"<leader>f"} },
```

Before/After example (human-editable)
```diff
--- a/nvim/.config/nvim/lua/config/pack.lua
+++ b/nvim/.config/nvim/lua/config/pack.lua
@@
+{ src = "https://github.com/nvim-telescope/telescope.nvim", lazy = true, keys = {"<leader>f"} },
```

FAQ
- Q: "Should I commit nvim-pack-lock.json?"
  A: "Yes if you want deterministic installs across machines; it pins exact plugin refs produced by vim.pack."

References
- https://neovim.io
- https://github.com/neovim/neovim
