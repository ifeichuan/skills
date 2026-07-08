#!/usr/bin/env bash
set -euo pipefail

# prompt-logger installer
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/ifeichuan/skills/main/prompt-logger/scripts/install.sh | bash
#   OBSIDIAN_VAULT=/path/to/vault bash scripts/install.sh

INSTALL_DIR="$HOME/.claude/skills/prompt-logger"
REPO_URL="https://raw.githubusercontent.com/ifeichuan/skills/main/prompt-logger"

echo "── prompt-logger v2 installer ──"
echo ""

# ─── 1. Detect vault path ───
detect_vault() {
  if [ -n "${OBSIDIAN_VAULT:-}" ]; then echo "$OBSIDIAN_VAULT"; return; fi
  local cfg="$HOME/Library/Application Support/obsidian/obsidian.json"
  [ ! -f "$cfg" ] && cfg="$HOME/.config/obsidian/obsidian.json"
  if [ -f "$cfg" ]; then
    local p
    p=$(python3 -c "
import json
with open('$cfg') as f:
    vaults = json.load(f).get('vaults', {})
for v in vaults.values():
    print(v.get('path','')); break
" 2>/dev/null || true)
    [ -n "$p" ] && echo "$p" && return
  fi
  echo ""
}

VAULT_PATH=$(detect_vault)
if [ -z "$VAULT_PATH" ]; then
  printf "Could not auto-detect Obsidian vault.\nEnter vault path: "
  read -r VAULT_PATH
fi
[ ! -d "$VAULT_PATH" ] && echo "Error: '$VAULT_PATH' not found." && exit 1

LOG_DIR="${PROMPT_LOGGER_DIR:-05-Archive/input-output}"
echo "Vault: $VAULT_PATH"
echo "Log dir: $VAULT_PATH/$LOG_DIR"
echo ""

# ─── 2. Download plugin files ───
mkdir -p "$INSTALL_DIR"/{.claude-plugin,hooks,pi-extension,scripts}

FILES=(
  ".claude-plugin/plugin.json"
  ".claude-plugin/marketplace.json"
  "hooks/claude-codex-hooks.json"
  "hooks/log-prompt.mjs"
  "pi-extension/index.js"
  "pi-extension/package.json"
  "package.json"
)

for f in "${FILES[@]}"; do
  curl -fsSL "$REPO_URL/$f" -o "$INSTALL_DIR/$f"
done

# ─── 3. Write config.json ───
cat > "$INSTALL_DIR/config.json" << EOF
{
  "vaultPath": "$VAULT_PATH",
  "logDir": "$LOG_DIR"
}
EOF

# ─── 4. Ensure log directory exists ───
mkdir -p "$VAULT_PATH/$LOG_DIR"

echo "✓ Plugin files installed to $INSTALL_DIR"
echo ""

# ─── 5. Codex integration ───
CODEX_HOOKS="$HOME/.codex/hooks.json"
if [ -d "$HOME/.codex" ]; then
  if grep -q "log-prompt" "$CODEX_HOOKS" 2>/dev/null; then
    echo "✓ Codex hook already present"
  else
    node -e "
const fs = require('fs');
const p = '$CODEX_HOOKS';
let cfg = { hooks: {} };
try { cfg = JSON.parse(fs.readFileSync(p, 'utf8')); } catch {}
if (!cfg.hooks) cfg.hooks = {};
if (!cfg.hooks.UserPromptSubmit) cfg.hooks.UserPromptSubmit = [];
cfg.hooks.UserPromptSubmit.push({
  hooks: [{ type: 'command', command: \"CODEX_PROJECT_DIR=1 node '$INSTALL_DIR/hooks/log-prompt.mjs'\", timeout: 10 }]
});
fs.writeFileSync(p, JSON.stringify(cfg, null, 2) + '\n');
" 2>/dev/null && echo "✓ Codex hook injected" || echo "⚠ Codex hook injection skipped"
  fi
fi

# ─── 6. Pi integration ───
PI_EXT_DIR="$HOME/.pi/agent/extensions"
if [ -d "$HOME/.pi" ]; then
  mkdir -p "$PI_EXT_DIR"
  cp "$INSTALL_DIR/pi-extension/index.js" "$PI_EXT_DIR/prompt-logger.js"
  echo "✓ Pi extension installed"
fi

echo ""
echo "── Installation complete ──"
echo ""
echo "Active for:"
echo "  • Claude Code  (plugin auto-discovered)"
[ -d "$HOME/.codex" ] && echo "  • Codex        (hooks.json injected)"
[ -d "$HOME/.pi" ] && echo "  • Pi           (extension discovered)"
echo ""
echo "Logs → $VAULT_PATH/$LOG_DIR/<YYYY-MM-DD>.md"
echo "Config → $INSTALL_DIR/config.json"
