---
title: design-explorer Skill Design Spec
date: 2026-04-11
status: approved
skill_name: design-explorer
skill_dir: .agents/skills/design-explorer
category: tooling
---

## Overview

A skill that uses parallel sub-agents + agent-browser to automatically search multiple component/design websites, producing HTML reports in two phases: quick browse and detailed filtering.

## File Structure

```
.agents/skills/design-explorer/
├── SKILL.md                    # Main entry, trigger conditions, workflow, site list
├── DESIGN.md                   # This file
├── sites/                      # Per-site search SOPs (sub-skills)
│   ├── 21st-dev.md
│   ├── inspira-ui.md
│   ├── magicui.md
│   ├── meiye-art.md
│   ├── dribbble.md
│   ├── reactbits.md
│   ├── bestdesignsonx.md
│   └── component-gallery.md
├── templates/
│   ├── report.html             # Phase 1 quick browse HTML template
│   └── detail.html             # Phase 2 detailed comparison HTML template
└── guides/
    └── add-site.md             # Guide for adding custom websites
```

## Pre-defined Websites

| Site | URL | Category |
|------|-----|----------|
| 21st.dev | https://21st.dev | component-library |
| Inspira UI | https://inspira-ui.com | component-library |
| Magic UI | https://magicui.design | component-library |
| meiye.art | https://www.meiye.art | design-inspiration |
| Dribbble | https://dribbble.com | design-inspiration |
| React Bits | https://www.reactbits.dev | component-library |
| Best Designs on X | https://bestdesignsonx.com | design-inspiration |
| Component Gallery | https://component.gallery | component-library |

## Architecture: Parallel Sub-Agent Model

The main agent orchestrates by spawning parallel sub-agents via the Agent tool. Each sub-agent independently handles one website using agent-browser.

```
Main Agent (SKILL.md)
  ├── Sub-Agent 1 → agent-browser → 21st.dev
  ├── Sub-Agent 2 → agent-browser → inspira-ui.com
  ├── Sub-Agent 3 → agent-browser → magicui.design
  ├── Sub-Agent 4 → agent-browser → meiye.art
  ├── Sub-Agent 5 → agent-browser → dribbble.com
  ├── Sub-Agent 6 → agent-browser → reactbits.dev
  ├── Sub-Agent 7 → agent-browser → bestdesignsonx.com
  └── Sub-Agent 8 → agent-browser → component.gallery
         ↓
  Main Agent collects results → generates HTML report
```

**Why sub-agents, not parallel agent-browser sessions:**
- True parallelism — 8 sub-agents execute simultaneously
- Each sub-agent has its own agent-browser session, no conflicts
- Main agent context stays clean, not polluted by browser snapshot data
- Individual site failures don't block others

**Sub-agent configuration:**
- `subagent_type: "general-purpose"` — needs full toolset (Bash for agent-browser, Read for SOP)
- Each sub-agent prompt specifies: search keyword, SOP file path, screenshot save path, return format

## Phase 1: Quick Browse

### Trigger

User input like `design-explorer button`, `/design-explorer date picker`, or natural language like "找一下 date picker 组件".

### Flow

1. **Parse user input**: Extract search keywords + optional category filter ("只搜组件库" / "只搜设计灵感")
2. **Dispatch parallel sub-agents**: Main agent sends a single message with 8 Agent tool calls
   - Each sub-agent reads its corresponding `sites/xxx.md` SOP
   - Uses agent-browser to open site, search, screenshot
   - Extracts structured info
   - Saves screenshots to `{cwd}/docs/{category}/{keyword}/`
   - Returns JSON summary to main agent
3. **Main agent aggregates**: Collects all sub-agent results
4. **Generate HTML report**: Using `templates/report.html`, output to `{cwd}/docs/{category}/{keyword}.html`
5. **Cleanup**: Each sub-agent closes its own agent-browser session
6. **Notify user**: Output report path, prompt for Phase 2

### Per-component extracted fields

| Field | Description |
|-------|-------------|
| `name` | Component name |
| `source` | Source website |
| `framework` | React / Vue / CSS / framework-agnostic |
| `theme` | Style tags (minimal / playful / corporate etc.) |
| `features` | One-line feature description |
| `screenshot` | Screenshot file path |
| `url` | Original link |

### Error handling

- Site search timeout or failure: mark as "未找到结果" in report, don't block others
- No results found on a site: include in report with "无匹配结果" note

## Phase 2: Detailed Filtering

### Trigger

User selects components in the same session, e.g. "1、3、7 这三个详细看看" or "把所有 React 的都详细分析一下".

### Flow

1. **Parse selection**: Main agent locates target components from Phase 1 results
2. **Dispatch parallel sub-agents**: One per selected component
   - Visit component's original URL
   - Navigate to detail page / GitHub repo / npm page
3. **Extract detailed info** per component:

| Field | Description |
|-------|-------------|
| `bundle_size` | From bundlephobia or npm |
| `dependencies` | Dependency list and count |
| `license` | Open source license |
| `weekly_downloads` | npm weekly downloads (if applicable) |
| `github_stars` | GitHub star count |
| `last_updated` | Last update time |
| `browser_support` | Browser compatibility |
| `accessibility` | A11y support status |
| `theming` | Theme customization capability |
| `highlights` | Core selling points |
| `caveats` | Known issues or limitations |

4. **Generate detailed report**: Using `templates/detail.html`
   - Comparison table: all selected components side-by-side
   - Detailed card per component
   - Output to `{cwd}/docs/{category}/{keyword}-detail.html`
5. **Recommendation**: Main agent gives selection advice with reasoning

**Info source priority**: Component official site > GitHub README > npm page > bundlephobia. Design-inspiration sites (Dribbble etc.) won't have npm data — sub-agents adapt accordingly.

## Custom Website + SOP Generation

### Trigger

User says "添加 xxx.com 到 design-explorer" or "帮我探索一下这个网站 xxx.com".

### Flow

1. **Dispatch exploration sub-agent**:
   - Open user-provided URL
   - Analyze page structure via agent-browser snapshot
   - Find search functionality (search box, URL params, category navigation)
   - Execute a test search with a sample keyword
   - Analyze result page structure
   - Screenshot key steps
2. **Generate SOP file**: Standard format matching existing site SOPs
   ```markdown
   ---
   name: xxx.com
   url: https://xxx.com
   category: component-library | design-inspiration
   search_method: url_param | search_box | scroll_browse
   added_by: user
   added_at: 2026-04-11
   ---
   ## 搜索步骤
   1. 打开 {url}/...
   2. 定位搜索框...
   3. 等待结果...
   4. 提取信息...

   ## 结果提取
   - 组件名：...
   - 预览图：...
   - 框架标签：...
   - 简介：...
   ```
3. **Save to**: `.agents/skills/design-explorer/sites/{site-name}.md`
4. **Validate**: Run the new SOP with another test keyword to confirm it works
5. **Update SKILL.md**: Append new site to the pre-defined website list

### SOP Quality Rules

- Never hardcode `@eN` refs (they change every session) — use semantic locator strategies ("find input with placeholder 'Search'")
- Include fallback hints ("if search box not found, try URL param approach")
- Describe element locations by role, text content, or CSS selector patterns

## HTML Templates

### Quick Browse Report (`templates/report.html`)

```
docs/{category}/{keyword}.html        ← main report
docs/{category}/{keyword}/             ← screenshot directory
  ├── 21st-dev-button-1.png
  ├── inspira-ui-button-1.png
  └── ...
```

Content:
- **Header**: Search keyword, timestamp, sites searched, success/failure count
- **Body**: Card grid layout, each card = screenshot thumbnail (click to enlarge) + name + source (linked) + framework badge + one-line feature + original link
- **Footer**: Statistics grouped by source site

### Detailed Report (`templates/detail.html`)

```
docs/{category}/{keyword}-detail.html
```

Content:
- **Comparison table**: All selected components' core metrics side-by-side (size, deps, stars, license, last updated)
- **Detail sections**: One per component with all extracted info + pros/cons summary
- **Recommendation**: Main agent's comprehensive recommendation with reasoning

### Template Implementation

- Pure HTML + inline CSS, no external dependencies, works offline
- `{{placeholder}}` markers in template, main agent does string replacement after collecting sub-agent data
- Responsive layout, mobile-friendly

## Output Path Convention

`{category}` in output paths is derived from the search context:
- If user specifies a category filter (e.g. "只搜组件库") → use that category name (e.g. `component-library`)
- If searching all sites → use `mixed`
- If the keyword itself implies a category (e.g. "button" → `components`, "landing page" → `design`) → use the implied category
- The main agent decides the category value; it's a human-readable directory name, not an enum
