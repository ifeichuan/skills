import { execSync } from "node:child_process";
import { readFileSync } from "node:fs";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
let config = {};
try {
  config = JSON.parse(readFileSync(join(__dirname, "..", "config.json"), "utf8"));
} catch {}

const VAULT_ROOT = process.env.OBSIDIAN_VAULT || config.vaultPath || "";
const LOG_DIR = config.logDir || "05-Archive/input-output";

function getDateStr() {
  const now = new Date();
  const y = now.getFullYear();
  const m = String(now.getMonth() + 1).padStart(2, "0");
  const d = String(now.getDate()).padStart(2, "0");
  return `${y}-${m}-${d}`;
}

function getTimeStr() {
  const now = new Date();
  const h = String(now.getHours()).padStart(2, "0");
  const min = String(now.getMinutes()).padStart(2, "0");
  return `${h}:${min}`;
}

function detectAgent() {
  if (process.env.CLAUDE_PROJECT_DIR || process.env.CLAUDE_PLUGIN_ROOT) return "claude";
  if (process.env.CODEX_PROJECT_DIR || process.env.CODEX_PLUGIN_ROOT) return "codex";
  if (process.env.PI_PROJECT_DIR) return "pi";
  return "unknown";
}

function readStdin() {
  return new Promise((resolve) => {
    let data = "";
    process.stdin.setEncoding("utf8");
    process.stdin.on("data", (chunk) => { data += chunk; });
    process.stdin.on("end", () => resolve(data));
    setTimeout(() => resolve(data), 3000);
  });
}

async function main() {
  const raw = await readStdin();
  let prompt = "";

  try {
    const json = JSON.parse(raw);
    prompt = json.prompt || json.text || "";
  } catch {
    prompt = raw.trim();
  }

  if (!prompt) process.exit(0);

  const agent = detectAgent();
  const dateStr = getDateStr();
  const timeStr = getTimeStr();
  const filePath = `${LOG_DIR}/${dateStr}.md`;
  const header = `## ${dateStr} ${timeStr} ${agent} 用户输入`;
  const content = `${header}\n${prompt}`;

  try {
    execSync(`obsidian append path="${filePath}" content=${JSON.stringify(content)}`, {
      timeout: 5000,
      stdio: ["pipe", "pipe", "pipe"],
    });
  } catch {
    const fs = await import("node:fs");
    const path = await import("node:path");
    if (!VAULT_ROOT) process.exit(0);
    const fullPath = path.join(VAULT_ROOT, filePath);

    if (!fs.existsSync(path.dirname(fullPath))) {
      fs.mkdirSync(path.dirname(fullPath), { recursive: true });
    }

    fs.appendFileSync(fullPath, (fs.existsSync(fullPath) ? "\n" : "") + content + "\n");
  }
}

main().catch(() => process.exit(0));
