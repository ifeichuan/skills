---
name: component-scout
description: 在多个设计/组件网站上并行搜索组件，输出截图对比 HTML。Use when the user asks to find, search, scout, or compare UI components across design sites, or mentions "component scout", "scout components", "find components on design sites".
user-invocable: true
argument-hint: "[component name or description]"
allowed-tools: Bash(agent-browser:*), Bash(npx agent-browser:*), Bash(npm info *), Bash(gh api *)
---

# Component Scout — 组件猎手

在设计灵感站和组件库上并行搜索 UI 组件，输出可视化的截图对比 HTML 页面。

## 核心能力

1. **Phase 1 快速浏览** — 并行搜索多个网站，输出截图 + 简介卡片网格 HTML
2. **Phase 2 详细分析** — 对用户选中的组件做深度对比（性能、包大小、依赖、协议）
3. **添加自定义网站** — AI 自动探索新网站的搜索流程，保存为 site adapter

## 执行流程

### Step 0: 解析输入与上下文

用户输入格式：`/component-scout <query>` 或自然语言触发。

**首次运行时**，用 AskUserQuestion 询问一次技术栈偏好：
- React / Vue / Angular / Svelte / 框架无关
- 这决定 Tier 2 组件库的搜索优先级，保存到当前会话

**识别用户意图**：
- 如果用户说 "添加网站 https://xxx.com" → 跳转到「添加自定义网站」流程
- 如果用户说 "详细分析 X, Y, Z" → 跳转到 Phase 2
- 其他 → 进入 Phase 1

### Step 1: Phase 1 — 快速浏览

#### 1.1 读取网站列表

读取 `sites/` 目录下所有 `.md` 适配器文件。每个文件的 frontmatter 包含 `tier` 字段：
- `tier: 1` — 设计灵感站，默认搜索
- `tier: 2` — 组件库文档，仅当用户明确要求或 Phase 2 时搜索

筛选出所有 `tier: 1` 的网站进入搜索。

#### 1.2 并行搜索

使用 Claude Code 的 **Agent 工具** 并行启动子 agent，每个网站一个子 agent。

**子 agent 指令模板**（根据适配器的 `search-strategy` 选择策略）：

**策略 A: google-site（默认）**

```
你是 Component Scout 的搜索子 agent。任务：在 {site_name} 上搜索 "{query}" 相关的 UI 组件。

步骤：
1. 用 agent-browser 打开 Google 搜索：
   agent-browser batch "open https://www.google.com/search?q=site:{site_url}+{query}+component&tbm=isch" "wait 2000" "screenshot --screenshot-dir {output_dir}"

2. 如果 Google 图片搜索结果不理想，尝试普通搜索：
   agent-browser batch "open https://www.google.com/search?q=site:{site_url}+{query}+component+design" "wait 2000" "screenshot --screenshot-dir {output_dir}"

3. 从搜索结果中选择前 3-5 个最相关的链接，逐个打开并截图：
   agent-browser batch "open {result_url}" "wait 2000" "screenshot --screenshot-dir {output_dir}"

4. 对每个截图，提取以下信息：
   - 组件名称
   - 原始 URL
   - 简要描述（1-2 句话）
   - 标签：[来源站名, 组件类型, 视觉风格]

返回格式（JSON）：
{
  "site": "{site_name}",
  "results": [
    {
      "name": "组件名称",
      "url": "原始 URL",
      "screenshot": "截图文件路径",
      "description": "简要描述",
      "tags": ["来源站", "类型", "风格"]
    }
  ]
}

注意事项：
- 截图保存到 {output_dir}/{site_name}/ 目录
- 如果网站需要关闭 cookie 弹窗，先处理弹窗再截图
- 参考该网站的适配器文件了解特殊处理要求
```

**策略 B: direct-url（组件库文档）**

```
你是 Component Scout 的搜索子 agent。任务：在 {site_name} 上查看 "{query}" 组件。

步骤：
1. 直接打开组件文档页：
   agent-browser batch "open {direct_url_template.replace('{name}', query)}" "wait 3000" "screenshot --screenshot-dir {output_dir}"

2. 如果页面 404 或无内容，尝试搜索页：
   agent-browser batch "open {site_url}/search?q={query}" "wait 2000" "screenshot --screenshot-dir {output_dir}"

3. 提取组件信息并返回同样的 JSON 格式。
```

**策略 C: site-search（站内搜索）**

```
你是 Component Scout 的搜索子 agent。任务：在 {site_name} 上搜索 "{query}"。

步骤：
1. 打开网站并获取搜索框：
   agent-browser batch "open {site_url}" "wait 2000" "snapshot -i"

2. 根据适配器描述的搜索入口，找到搜索框并输入查询词：
   agent-browser fill @{search_ref} "{query}"
   agent-browser press Enter
   agent-browser wait 3000
   agent-browser screenshot --screenshot-dir {output_dir}

3. 从结果中选取前 3-5 个，逐个截图。

参考该网站适配器文件中的「搜索策略」和「截图技巧」部分。
```

#### 1.3 汇总结果并生成 HTML

所有子 agent 返回后，主 agent：

1. 收集所有子 agent 返回的 JSON 结果
2. 读取 `references/output-template.html` 作为模板基础
3. 生成最终 HTML 文件，结构：
   - 顶部信息栏：查询词、搜索时间、结果总数、搜索了哪些网站
   - 卡片网格：每张卡片包含截图（使用本地 `file://` 路径或 base64 内联）、组件名、来源站标签、描述、标签、链接
   - 按来源站分组展示
4. 输出文件路径：`./components/{query}.html`
5. 用 `agent-browser --allow-file-access open file://{absolute_path}` 打开生成的 HTML 让用户预览
6. 告诉用户："已生成 {N} 个组件的对比页面，请浏览后告诉我你想深入分析哪些（输入编号或名称）"

### Step 2: Phase 2 — 详细分析

用户选中若干组件后触发。

#### 2.1 结构化数据获取（API/CLI 优先）

对每个选中的组件，**并行执行**：

```bash
# npm 包信息（如果是 npm 组件）
npm info <package-name> --json

# GitHub 信息
gh api repos/<owner>/<repo> --jq '{stars: .stargazers_count, license: .license.spdx_id, updated: .updated_at, issues: .open_issues_count}'

# Bundle size（通过 bundlephobia API）
# WebFetch https://bundlephobia.com/api/size?package=<package-name>
```

#### 2.2 视觉补充（agent-browser）

对选中的组件：
- 打开组件的 live demo 页面
- 截取不同状态（默认、hover、active、disabled）的截图
- 如果有暗色模式，截取暗色模式截图

#### 2.3 生成对比报告

输出一个详细的对比 HTML 或 Markdown 报告，包含：
- 组件截图对比（并排）
- 表格：包大小、依赖数量、star、最近更新、开源协议
- 各组件的优劣分析
- AI 推荐（基于用户的技术栈偏好）

### Step 3: 添加自定义网站

当用户说 "添加 https://xxx.com" 时：

1. 用 agent-browser 自动探索：
   ```
   agent-browser batch "open {url}" "wait 3000" "snapshot -i --urls"
   ```

2. AI 分析网站结构：
   - 识别搜索入口（搜索框、导航栏、分类页）
   - 判断网站类型（design / component-library）
   - 判断最佳搜索策略（google-site / site-search / direct-url）

3. 试一次搜索验证：
   - 用识别到的搜索方式搜索一个通用组件（如 "button"）
   - 验证能否获得有效结果和截图

4. 生成适配器文件 `sites/<site-name>.md`：
   - 基于 `sites/_template.md` 格式
   - 填入探索发现的信息
   - 设为 `tier: 1`（默认）或让用户确认

5. 告知用户适配器已创建，下次搜索将包含此网站

## 关键原则

- **截图是核心产出** — 设计参考的价值在于视觉，确保每个结果都有高质量截图
- **Google `site:` 优先** — 绕过不同网站的 UI 差异，搜索质量更稳定
- **API 优先于爬虫** — Phase 2 的结构化数据用 CLI/API 获取，agent-browser 只做视觉相关的事
- **适配器是知识积累** — 每次搜索都可能发现网站的新 quirk，鼓励更新适配器文件
- **不要过度截图** — 每个网站 3-5 个最相关的结果即可，质量优于数量
