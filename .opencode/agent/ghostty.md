---
name: ghostty
tool: ghostty
platform: ["macos"]
description: "Diagnostics and patch templates for Ghostty terminal configuration and service management on macOS."
capabilities: ["diagnose","patch_template","commands"]
checks: ["config_path_present","daemon_status","service_logs","permission_issues","socket_path_conflict","version_compat"]
redact: true
examples:
  - question: "Ghostty won't start on login — how do I debug it?"
    answer: "Check the configured config path, validate file permissions, inspect the launchd/daemon entry (if used), and tail system logs for the ghostty process."
last_updated: "2026-04-27"
maintainers: ["NicolasOuld"]
---

# Ghostty Subagent (macOS)

## Summary
- Diagnose Ghostty terminal service/configuration issues and provide small, reviewable patch templates for common fixes (permissions, socket path, launchd plist skeleton).
- Advice-only: provide diagnostics and patch templates; do not modify files automatically.

## Scope
- By default operates only on files inside this repository (for repo-scoped ghostty configs). If you supply an explicit path (for example a global config under `~/.config/ghostty`), the subagent will ask for permission before reading outside the repo.

## Quick checks
- Is a ghostty config present in expected locations (repo path, ~/.config/ghostty, /etc/ghostty)?
- Are socket or pid paths writable by the service user and not in conflict with another process?
- Is a launchd/daemon entry installed (launchctl), and does it show as loaded or failed?
- Are permissions on the config and runtime directories too permissive or too restrictive?

## Diagnostic commands (Execute locally)
- Check for a repo-scoped config (example paths):
```sh
ls -la .ghostty || ls -la .config/ghostty || ls -la ~/.config/ghostty || true
```
- Check binary version (if installed):
```sh
ghostty --version 2>/dev/null || echo "ghostty binary not in PATH"
```
- Check for a running process and its logs (macOS unified logging):
```sh
pgrep -a ghostty || true
log show --predicate 'process == "ghostty"' --last 1h || true
```
- Inspect launchd (user services) for ghostty entries:
```sh
launchctl list | rg -i ghostty || true
# If a plist is installed in ~/Library/LaunchAgents or /Library/LaunchDaemons, inspect it
ls -la ~/Library/LaunchAgents | rg -i ghostty || true
```
- Validate socket and pid path ownership/permissions:
```sh
stat -f "%N %Su %Sp" /path/to/socket || true
# or
ls -la /path/to/run || true
```

## Patch templates
- fix-permissions: ensure runtime directories and socket are owned by the service user and not world-writable.

```sh
# example: make socket dir owned by current user and not writable by group/other
mkdir -p /var/run/ghostty
chown $(whoami):staff /var/run/ghostty
chmod 750 /var/run/ghostty
```

- set-socket-path: example snippet to set an explicit socket path in a ghostty config (yaml/toml/json — adapt to your format):

```diff
--- a/ghostty/config.yaml
+++ b/ghostty/config.yaml
@@ -1 +1 @@
 socket_path: "/var/run/ghostty/ghostty.sock"
```

- launchd plist skeleton (macOS user agent example — adapt label and paths):

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>com.example.ghostty</string>
    <key>ProgramArguments</key>
    <array>
      <string>/usr/local/bin/ghostty</string>
      <string>--config</string>
      <string>/Users/you/.config/ghostty/config.yaml</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/tmp/ghostty.out.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/ghostty.err.log</string>
  </dict>
</plist>
```

## FAQ
- Q: "Ghostty can't bind socket — what then?"
  A: "Check socket_path, directory ownership/permissions, and whether another process holds the socket. Use pgrep and stat/ls to inspect."

## References
- Ghostty project docs (if available) — check your project's README or upstream docs for config schema and daemon options.
