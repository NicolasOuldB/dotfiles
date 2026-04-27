---
name: zsh
tool: zsh
platform: ["macos"]
description: "zsh diagnostics and patch templates for macOS (repo-scoped)."
capabilities: ["diagnose","patch_template","commands"]
checks: ["nvm_loading","unsafe_remote_source","duplicate_path","plugin_order"]
redact: true
examples:
  - question: "Why isn't nvm loading?"
    answer: "Check NVM_DIR export and ensure sourcing of nvm.sh occurs before nvm usage. On mac prefer /opt/homebrew/opt/nvm/nvm.sh."
last_updated: "2026-04-27"
maintainers: ["NicolasOuld"]
---

# Zsh Subagent (macOS, repo-scoped)

Summary
- Diagnose common zsh issues in this repo (nvm loading, plugin order, suspicious remote sourcing).
- Advice-only: templates and commands are suggestions; run them locally.

Scope
- Uses only files under `~/dotfiles` in this repository. Does not read `~/.zshrc.local` or other home files unless you explicitly request it.

Quick checks
- Is NVM_DIR exported before any `nvm` usage?
- Are there `eval $(curl ...)` or `source <(curl ...)` patterns? Flag as unsafe until reviewed.
- Are zsh-syntax-highlighting and zsh-autosuggestions loaded in correct order? (syntax-highlighting should be last)

Diagnostic commands (Execute locally)
- Print NVM_DIR and check brew path:
```sh
echo "$NVM_DIR"
[[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]] && echo "brew-nvm exists"
```
- Run shellcheck on sourced script(s):
```sh
shellcheck -s sh path/to/sourced_file || true
```
- Search for unsafe remote sourcing in repo:
```sh
rg "curl .* | .*sh|eval \$\(|source <\(curl" -n
```

Patch templates
- fix-nvm-path (id: fix-nvm-path): Idempotent macOS nvm bootstrap (place near top of .zshrc before any nvm usage):

```sh
if [[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]]; then
  source "/opt/homebrew/opt/nvm/nvm.sh"
elif [[ -s "$NVM_DIR/nvm.sh" ]]; then
  source "$NVM_DIR/nvm.sh"
fi
```

Before/After example (human-editable)
```diff
--- a/zsh/.zshrc
+++ b/zsh/.zshrc
@@
- export NVM_DIR="$HOME/.nvm"
- if [[ -s "/usr/share/nvm/init-nvm.sh" ]]; then
-   source "/usr/share/nvm/init-nvm.sh"
- fi
+ export NVM_DIR="$HOME/.nvm"
+ if [[ -s "/opt/homebrew/opt/nvm/nvm.sh" ]]; then
+   source "/opt/homebrew/opt/nvm/nvm.sh"
+ elif [[ -s "$NVM_DIR/nvm.sh" ]]; then
+   source "$NVM_DIR/nvm.sh"
+ fi
```

FAQ
- Q: "Why is my prompt slow on startup?"
  A: "Powerlevel10k provides an instant prompt feature. Ensure the generated cache file is created and sourced early in .zshrc."

References
- https://github.com/romkatv/powerlevel10k
- https://github.com/zdharma-continuum/zinit
