import { existsSync, mkdirSync, appendFileSync, readFileSync } from "node:fs";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));

function loadConfig() {
  const candidates = [
    join(__dirname, "..", "config.json"),
    join(process.env.HOME || "", ".claude/skills/prompt-logger/config.json"),
  ];
  for (const p of candidates) {
    try { return JSON.parse(readFileSync(p, "utf8")); } catch {}
  }
  return {};
}

const config = loadConfig();
const VAULT_ROOT = process.env.OBSIDIAN_VAULT || config.vaultPath || "";
const LOG_DIR = config.logDir || "05-Archive/input-output";

export default function (pi) {
  pi.on("input", async (event) => {
    const prompt = event?.text;
    if (!prompt) return { action: "continue" };

    try {
      const now = new Date();
      const y = now.getFullYear();
      const m = String(now.getMonth() + 1).padStart(2, "0");
      const d = String(now.getDate()).padStart(2, "0");
      const h = String(now.getHours()).padStart(2, "0");
      const min = String(now.getMinutes()).padStart(2, "0");
      const dateStr = `${y}-${m}-${d}`;
      const timeStr = `${h}:${min}`;

      const fullPath = join(VAULT_ROOT, LOG_DIR, `${dateStr}.md`);
      const dir = dirname(fullPath);
      if (!existsSync(dir)) mkdirSync(dir, { recursive: true });

      const header = `## ${dateStr} ${timeStr} pi 用户输入`;
      const content = `${header}\n${prompt}\n`;
      appendFileSync(fullPath, (existsSync(fullPath) ? "\n" : "") + content);
    } catch {}

    return { action: "continue" };
  });
}
