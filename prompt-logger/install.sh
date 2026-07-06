#!/usr/bin/env bash
set -euo pipefail

# prompt-logger: one-line installer for Claude Code / Codex / Pi
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/ifeichuan/skills/main/prompt-logger/install.sh | bash
#   OBSIDIAN_VAULT=/path/to/vault bash install.sh

INSTALL_DIR="$HOME/.claude/skills/prompt-logger"
SCRIPT_PATH="$INSTALL_DIR/scripts/log-prompt.mjs"

echo "── prompt-logger installer ──"
echo ""

# ─── 1. Detect or ask for vault path ───
detect_vault() {
  # env override
  if [ -n "${OBSIDIAN_VAULT:-}" ]; then echo "$OBSIDIAN_VAULT"; return; fi
  # macOS: Obsidian app config
  local cfg="$HOME/Library/Application Support/obsidian/obsidian.json"
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
  # Linux: ~/.config/obsidian/obsidian.json
  cfg="$HOME/.config/obsidian/obsidian.json"
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
echo "Vault: $VAULT_PATH"

# Log directory (relative to vault root)
LOG_DIR="${PROMPT_LOGGER_DIR:-05-Archive/input-output}"
echo "Log dir: $VAULT_PATH/$LOG_DIR"
echo ""

# ─── 2. Clone or update plugin ───
RAW_BASE="https://raw.githubusercontent.com/ifeichuan/skills/main/prompt-logger"

if [ -d "$INSTALL_DIR" ] && [ -f "$INSTALL_DIR/scripts/log-prompt.mjs" ]; then
  echo "Updating existing installation..."
else
  rm -rf "$INSTALL_DIR"
fi

mkdir -p "$INSTALL_DIR"/{.claude-plugin,hooks,scripts}
curl -fsSL "$RAW_BASE/.claude-plugin/plugin.json" -o "$INSTALL_DIR/.claude-plugin/plugin.json"
curl -fsSL "$RAW_BASE/hooks/hooks.json" -o "$INSTALL_DIR/hooks/hooks.json"
curl -fsSL "$RAW_BASE/scripts/log-prompt.mjs" -o "$INSTALL_DIR/scripts/log-prompt.mjs"
curl -fsSL "$RAW_BASE/uninstall.sh" -o "$INSTALL_DIR/uninstall.sh" && chmod +x "$INSTALL_DIR/uninstall.sh"

# ─── 3. Write config.json ───
cat > "$INSTALL_DIR/config.json" << EOF
{
  "vaultPath": "$VAULT_PATH",
  "logDir": "$LOG_DIR"
}
EOF

echo "✓ Claude Code plugin ready at $INSTALL_DIR"

# ─── 5. Codex integration ───
CODEX_HOOKS="$HOME/.codex/hooks.json"
if [ -d "$HOME/.codex" ]; then
  if [ -f "$CODEX_HOOKS" ] && grep -q "prompt-logger" "$CODEX_HOOKS" 2>/dev/null; then
    echo "✓ Codex hook already present"
  else
    node -e "
const fs = require('fs');
const p = '$CODEX_HOOKS';
let cfg = { hooks: {} };
try { cfg = JSON.parse(fs.readFileSync(p, 'utf8')); } catch {}
if (!cfg.hooks) cfg.hooks = {};
if (!cfg.hooks.UserPromptSubmit) cfg.hooks.UserPromptSubmit = [];
const already = JSON.stringify(cfg).includes('prompt-logger');
if (!already) {
  cfg.hooks.UserPromptSubmit.push({
    hooks: [{ type: 'command', command: \"CODEX_PROJECT_DIR=1 node '$SCRIPT_PATH'\", timeout: 10 }]
  });
  fs.writeFileSync(p, JSON.stringify(cfg, null, 2) + '\n');
}
" 2>/dev/null && echo "✓ Codex hook injected" || echo "⚠ Codex hook injection skipped"
  fi
fi

# ─── 6. Pi integration ───
PI_EXT_DIR="$HOME/.pi/agent/extensions"
if [ -d "$HOME/.pi" ]; then
  mkdir -p "$PI_EXT_DIR"
  cat > "$PI_EXT_DIR/prompt-logger.ts" << PIEOF
import { execSync } from "node:child_process";

export default function (pi) {
  pi.on("input", async (event, ctx) => {
    const prompt = event.text;
    if (!prompt) return { action: "continue" };
    try {
      execSync(\`PI_PROJECT_DIR=1 node '$SCRIPT_PATH'\`, {
        input: JSON.stringify({ prompt }),
        timeout: 5000,
        stdio: ["pipe", "pipe", "pipe"],
      });
    } catch {}
    return { action: "continue" };
  });
}
PIEOF
  echo "✓ Pi extension installed"
fi

# ─── 7. Ensure log directory exists ───
mkdir -p "$VAULT_PATH/$LOG_DIR"

echo ""
echo "── Installation complete ──"
echo ""
echo "Active for:"
echo "  • Claude Code  (auto-discovered plugin)"
[ -d "$HOME/.codex" ] && echo "  • Codex        (hooks.json injected)"
[ -d "$HOME/.pi" ] && echo "  • Pi           (extension installed)"
echo ""
echo "Logs → $VAULT_PATH/$LOG_DIR/<YYYY-MM-DD>.md"
echo "Config → $INSTALL_DIR/config.json"
