# Reference Sources

## For agent

本目录是 `interview-drill` 的题库索引层。出题前按优先级读；答案正文优先回源文件，不要只靠 parametric memory。

## 读序（每次开练）

1. **`vault-interview-log.md`** — 用户真实场次与可出题干（最高优先贴近）
2. **`nowcoder-hot-qa.md`** — 秋招清洗 45 张完整题卡（速记 + 要点 + 易错 + 完整答）
3. **`nowcoder-freq-index.md`** — 牛客全量 48262 条的高频题干/标签（只索引，不答）
4. **`bagu-topic-map.md`** → **`bagu-question-index.md`** — 本地八股专题导航与 640 题干
5. 需要长文答案时打开源 md / jsonl（见下表）

## 源材料

| 材料 | 路径 | 角色 |
|------|------|------|
| Vault 面试日志 | `~/Documents/Obsidian/03-Areas/职业生涯/面试题.md` | 真实面经 + 牛客同步 |
| 秋招清洗前端题卡 | `~/Downloads/面经/秋招清洗版/前端.jsonl` | 45 题完整卡（已蒸馏到 hot-qa） |
| 牛客前端 QA 全量 | `~/Downloads/面经/牛客面经_尽可能全量/问答JSONL/前端开发_qa.jsonl` | 48262 行，freq-index 统计源 |
| 八股专题汇总 | `~/Documents/前端面试题汇总/*.md` | 分专题长文答案 |

## 文件职责

| 文件 | 题量/规模 | 含答案？ | 何时用 |
|------|-----------|----------|--------|
| `vault-interview-log.md` | 场次 + ~60 题干 | 否 | 优先模拟用户见过的追问链 |
| `nowcoder-hot-qa.md` | 45 | **是** | 默认 drill 抽卡 |
| `nowcoder-freq-index.md` | Top60 + 出题包 | 否 | 按市场热度补题 |
| `bagu-topic-map.md` | 12 专题 | 否 | 用户指定方向时导航 |
| `bagu-question-index.md` | 640 | 否 | 专题内选题；答案回源 md |

## 回源取答案

- hot-qa 已有完整答 → 直接用，规范细节仍可核 MDN/官方文档
- bagu 题干 → 打开 topic-map 中的源 md，按题号/`###` 标题定位
- 牛客高频但无卡 → `rg` 源 jsonl 的 `normalized_question` / `question`，读 `recommended_answer`；不可靠则标 `uncertain`
