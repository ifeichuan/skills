# prompt-logger

Hook plugin that automatically logs every user prompt to your Obsidian vault. Supports **Claude Code**, **Codex**, and **Pi**.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/ifeichuan/skills/main/prompt-logger/install.sh | bash
```

Or specify vault path explicitly:

```bash
OBSIDIAN_VAULT=~/my-vault bash <(curl -fsSL https://raw.githubusercontent.com/ifeichuan/skills/main/prompt-logger/install.sh)
```

## What it does

On every `UserPromptSubmit` (Claude Code / Codex) or `input` (Pi) event, appends the user's message to:

```
<vault>/05-Archive/input-output/YYYY-MM-DD.md
```

Format:

```markdown
## 2026-07-06 21:30 claude 用户输入
your prompt content here
```

## How it works

| Agent | Hook Event | Integration |
|-------|-----------|-------------|
| Claude Code | `UserPromptSubmit` | Plugin auto-discovered from `~/.claude/skills/` |
| Codex | `UserPromptSubmit` | Injected into `~/.codex/hooks.json` |
| Pi | `input` | Extension at `~/.pi/agent/extensions/prompt-logger.ts` |

All three call the same `scripts/log-prompt.mjs` core script. It tries `obsidian append` CLI first, falls back to direct file write.

## Configuration

After install, edit `~/.claude/skills/prompt-logger/config.json`:

```json
{
  "vaultPath": "/path/to/your/obsidian/vault",
  "logDir": "05-Archive/input-output"
}
```

## Uninstall

```bash
bash ~/.claude/skills/prompt-logger/uninstall.sh
```

## Requirements

- Node.js 18+
- Obsidian CLI (optional, falls back to direct file write)
- One or more of: Claude Code, Codex CLI, Pi
