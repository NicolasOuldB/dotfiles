---
name: tmux
tool: tmux
platform: ["macos"]
description: "tmux diagnostics and small patch templates for macOS-focused tmux configs."
capabilities: ["diagnose","patch_template","commands"]
checks: ["prefix_conflict","deprecated_options","pane_indexing"]
redact: true
examples:
  - question: "Is my tmux prefix likely to conflict with macOS?"
    answer: "C-SPACE can conflict with macOS or terminal shortcuts; consider C-a or another binding."
last_updated: "2026-04-27"
maintainers: ["NicolasOuld"]
---

# Tmux Subagent (repo-scoped)

Summary
- Diagnose tmux config under `tmux/.tmux.conf`. Check for macOS-friendly defaults and common issues.

Scope
- Uses only files under `~/dotfiles` in this repo.

Quick checks
- Are any terminal-overrides defined that might break cursor shape handing with nvim?

Diagnostic commands (Execute locally)
- Show tmux version and global options:
```sh
tmux -V
tmux show-options -g
```
- Run tmux server in verbose log (for advanced debugging):
```sh
tmux -vv new -s test
```

Patch templates
- Change prefix example:

```diff
--- a/.tmux.conf
+++ b/.tmux.conf
@@
- set -g prefix C-a
```

FAQ
- Q: "Why doesn't tmux clipboard integration work on mac?"
  A: "On macOS you may need to ensure `set-clipboard on` and that your terminal supports it; macOS pasteboard integration sometimes requires `reattach-to-user-namespace` on older setups."

References
- https://github.com/tmux/tmux
