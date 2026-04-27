Config-bro
===========

Location
- This pack lives in the repository at `.opencode/` and is intended to be repo-scoped (available only when working in this repo). It is not stowed to `~/.config/opencode` by default.

Purpose
- Provide a markdown-first set of subagents (zsh, neovim, tmux) that the config-bro assistant can load to answer repo-scoped questions.

Usage
- Edit *.md files under this directory to improve guidance.
- The assistant routes queries to subagents using `index.md` mappings or by detecting tool names & file paths in your question.

Notes
- Advice-only: no file writes by default.
- Includes executable diagnostic commands; run them locally and be mindful of secrets.
