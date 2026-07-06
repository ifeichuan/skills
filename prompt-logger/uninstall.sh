#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="$HOME/.claude/skills/prompt-logger"

echo "── prompt-logger uninstaller ──"

# Remove Claude Code plugin
if [ -d "$INSTALL_DIR" ]; then
  rm -rf "$INSTALL_DIR"
  echo "✓ Removed Claude Code plugin"
fi

# Remove from Codex hooks.json
CODEX_HOOKS="$HOME/.codex/hooks.json"
if [ -f "$CODEX_HOOKS" ] && grep -q "prompt-logger" "$CODEX_HOOKS" 2>/dev/null; then
  node -e "
const fs = require('fs');
const p = '$CODEX_HOOKS';
const cfg = JSON.parse(fs.readFileSync(p, 'utf8'));
if (cfg.hooks && cfg.hooks.UserPromptSubmit) {
  cfg.hooks.UserPromptSubmit = cfg.hooks.UserPromptSubmit.filter(
    e => !JSON.stringify(e).includes('prompt-logger')
  );
  if (cfg.hooks.UserPromptSubmit.length === 0) delete cfg.hooks.UserPromptSubmit;
}
fs.writeFileSync(p, JSON.stringify(cfg, null, 2) + '\n');
" 2>/dev/null && echo "✓ Removed Codex hook"
fi

# Remove Pi extension
PI_EXT="$HOME/.pi/agent/extensions/prompt-logger.ts"
if [ -f "$PI_EXT" ]; then
  rm "$PI_EXT"
  echo "✓ Removed Pi extension"
fi

echo ""
echo "Done. Log files in your vault are preserved."
