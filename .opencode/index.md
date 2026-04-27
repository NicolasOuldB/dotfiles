---
name: config-bro-index
tool: index
platform: ["macos"]
description: "Mapping of repo paths to subagents for config-bro routing."
last_updated: "2026-04-27"
maintainers: ["NicolasOuld"]
---

# Index — repo path -> subagent mapping

This file maps paths inside ~/dotfiles/opencode to the appropriate subagent.

- `zsh/` -> `agent/zsh.md`
- `nvim/.config/nvim/` -> `agent/neovim.md`
- `tmux/` -> `agent/tmux.md`
- `.opencode/` -> `agent/opencode.md`
- `ghostty/.config/ghostty/` -> `agent/ghostty.md`

## Terminology

- "config-bro" is the root agent that performs routing and high-level behavior (see agent/config-bro.md).
- Files under .opencode/agent/ (neovim.md, zsh.md, tmux.md) are subagent documentation used by config-bro.
- When adding a new subagent, add a corresponding file in .opencode/agent/ and update this index.

If you add other packages under opencode or elsewhere in the repo, update this file to map them to new agents.
