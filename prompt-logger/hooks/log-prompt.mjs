import { execSync } from "node:child_process";
import { existsSync, mkdirSync, appendFileSync, readFileSync } from "node:fs";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));

function loadConfig() {
  const candidates = [
    join(__dirname, "..", "config.json"),
    join(process.env.CLAUDE_PLUGIN_ROOT || "", "config.json"),
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

function timestamp() {
  const now = new Date();
  const y = now.getFullYear();
  const m = String(now.getMonth() + 1).padStart(2, "0");
  const d = String(now.getDate()).padStart(2, "0");
  const h = String(now.getHours()).padStart(2, "0");
  const min = String(now.getMinutes()).padStart(2, "0");
  return { date: `${y}-${m}-${d}`, time: `${h}:${min}` };
}

function detectAgent() {
  if (process.env.CODEX_PROJECT_DIR || process.env.CODEX_PLUGIN_ROOT) return "codex";
  if (process.env.PI_PROJECT_DIR) return "pi";
  return "claude";
}

export function writeLog(prompt, agent) {
  if (!prompt) return;
  const { date, time } = timestamp();
  const filePath = `${LOG_DIR}/${date}.md`;
  const header = `## ${date} ${time} ${agent || detectAgent()} 用户输入`;
  const content = `${header}\n${prompt}`;

  let written = false;
  try {
    const out = execSync(`obsidian append path="${filePath}" content=${JSON.stringify(content)}`, {
      timeout: 5000,
      stdio: ["pipe", "pipe", "pipe"],
    });
    const result = out.toString();
    written = !result.includes("Error:") && !result.includes("not found");
  } catch {}

  if (!written) {
    if (!VAULT_ROOT) return;
    const fullPath = join(VAULT_ROOT, filePath);
    const dir = dirname(fullPath);
    if (!existsSync(dir)) mkdirSync(dir, { recursive: true });
    appendFileSync(fullPath, (existsSync(fullPath) ? "\n" : "") + content + "\n");
  }
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
  writeLog(prompt, detectAgent());
}

main().catch(() => process.exit(0));
