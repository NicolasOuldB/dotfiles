---
name: opencode
tool: opencode
platform: ["macos"]
description: "Opencode subagent that operates in a single, unified mode with a configurable target path (default: repo-scoped .opencode)."
capabilities: ["diagnose","patch_template","commands","index_update","scaffold","scoped_target"]
checks: ["index_mapping","missing_agent_docs","ambiguous_paths","node_modules_noise","external_target_permission"]
redact: true
examples:
  - question: "Does the repository's .opencode index map to actual agent docs?"
    answer: "Run the index mapping checks against the target path (default is ./.opencode). If you want analysis of a global config, pass that path explicitly and confirm permission."
last_updated: "2026-04-27"
maintainers: ["NicolasOuld"]
---

# Opencode Subagent (single-mode, scoped target)

Summary
- Single-mode subagent: operates against a target path you specify. If no target is supplied, it defaults to the repo-scoped .opencode directory in this repository.
- The subagent will never read files outside this repository without your explicit confirmation. If you provide an external path (for example: opencode/.config/opencode), the subagent will validate the path and ask for permission before proceeding.

Target selection and safety
- Default target: ./ .opencode (the .opencode directory in the current repo).
- Explicit target: pass a path (relative or absolute). The agent will:
  1. Normalize and check whether the path is inside the repository root (~/dotfiles).
  2. If outside the repo, it will request explicit confirmation before reading files.
  3. Proceed only after permission is granted.

Quick checks
- Does target/.opencode/index.md reference files that actually exist under target/.opencode/agent/?
- Are there misspellings like `agents/` vs `agent/` in index or docs?
- Are there large vendored directories inside the target (node_modules) that should be excluded from searches or gitignored?

Diagnostic commands (Execute locally)
- Show default repo-scoped opencode tree:
```sh
ls -la .opencode
ls -la .opencode/agent
```
- Check a provided target path (safe check; does not read contents outside repo):
```sh
# replace <target> with your path (relative or absolute)
TARGET="<target>"
REAL=$(python - <<'PY'
import os,sys
p=os.path.realpath(sys.argv[1])
print(p)
PY
 "$TARGET")
echo "Resolved target: $REAL"
# Check whether target is inside the repo root
REPO_ROOT="$(pwd)"
if [[ "$REAL" != "$REPO_ROOT"* ]]; then
  echo "Target is outside repo root. The subagent will request explicit permission before proceeding."
else
  echo "Target is inside repo root — safe to analyze by default."
fi
```
- Search for incorrect references to `agents/` in the target:
```sh
rg "agents/" "${TARGET:-.opencode}" || true
```

Patch templates
- index-fix: update `index.md` references to the correct `agent/` directory and add Terminology (example already available in repo).
- add-agent: scaffold a new `agent/<name>.md` with frontmatter and basic sections (summary, scope, checks, commands).

Scaffold example (apply to add a new agent)
```diff
*** Add File: .opencode/agent/<name>.md
+++---
name: <name>
tool: <tool-name>
platform: ["macos"]
description: "Short description"
capabilities: ["diagnose","patch_template","commands"]
checks: ["example_check"]
redact: true
last_updated: "2026-04-27"
maintainers: ["You"]
---

# <Name> Subagent

Summary
- Short summary...
```

FAQ
- Q: "Will the subagent inspect my entire home directory?"
  A: "No. By default it only reads files under this repo. If you supply a target outside the repo, you must explicitly confirm that you want it analyzed."

References
- .opencode/index.md
- .opencode/agent/*
