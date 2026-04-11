---
name: design-explorer
description: 在多个设计/组件网站上并行探索设计参考，输出截图对比 HTML 报告。Use when the user asks to explore, find, or browse design references, component inspiration, or says "design explorer", "explore designs", "find design references", "找组件", "设计参考".
user-invocable: true
argument-hint: "[keyword or design topic]"
allowed-tools: Bash(agent-browser:*), Bash(npx agent-browser:*), Bash(npm info *), Bash(gh api *)
---

# Design Explorer — 设计探索器

在设计灵感站和组件库上并行搜索 UI 组件与设计参考，输出可视化的截图对比 HTML 页面。

## 核心能力

1. **Phase 1 快速浏览** — 并行搜索多个网站，输出截图 + 简介卡片网格 HTML
2. **Phase 2 详细分析** — 对用户选中的组件做深度对比（性能、包大小、依赖、协议）
3. **添加自定义网站** — AI 自动探索新网站的搜索流程，保存为 site adapter

## 预定义网站

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

## 执行流程

### Step 0: 解析输入与上下文

用户输入格式：`/design-explorer <query>` 或自然语言触发。

**识别用户意图**：
- 如果用户说 "添加网站 https://xxx.com" → 跳转到「添加自定义网站」流程
- 如果用户说 "详细分析 X, Y, Z" → 跳转到 Phase 2
- 如果用户指定分类过滤（如"只搜组件库"/"只搜设计灵感"）→ 只搜对应 category 的网站
- 其他 → 进入 Phase 1，搜索全部网站

**Category 逻辑**：
- 用户指定"只搜组件库" → category = `component-library`
- 用户指定"只搜设计灵感" → category = `design-inspiration`
- 默认无过滤 → category = `mixed`

**输出路径**：`{cwd}/docs/{category}/{keyword}.html`，截图保存到 `{cwd}/docs/{category}/{keyword}/`

### Step 1: Phase 1 — 快速浏览

#### 1.1 读取网站列表

读取 `sites/` 目录下所有 `.md` 适配器文件（排除 `_template.md`）。根据 category 过滤。

#### 1.2 创建输出目录

```bash
mkdir -p {cwd}/docs/{category}/{keyword}
```

#### 1.3 并行搜索

使用 Claude Code 的 **Agent 工具** 并行启动子 agent，每个网站一个子 agent。在**一条消息中**同时发出所有 Agent 调用。

**子 agent 指令模板**（根据适配器的 `search-strategy` 选择策略）：

**策略 A: google-site（默认）**

```
你是 Design Explorer 的搜索子 agent。任务：在 {site_name} 上搜索 "{query}" 相关的设计参考。

步骤：
1. 用 agent-browser 打开 Google 搜索：
   agent-browser batch "open https://www.google.com/search?q=site:{site_url}+{query}+component&tbm=isch" "wait 2000" "screenshot --screenshot-dir {output_dir}/{site_slug}"

2. 如果 Google 图片搜索结果不理想，尝试普通搜索：
   agent-browser batch "open https://www.google.com/search?q=site:{site_url}+{query}+component+design" "wait 2000" "screenshot --screenshot-dir {output_dir}/{site_slug}"

3. 从搜索结果中选择前 3-5 个最相关的链接，逐个打开并截图：
   agent-browser batch "open {result_url}" "wait 2000" "screenshot --screenshot-dir {output_dir}/{site_slug}"

4. 对每个截图，提取以下信息：
   - name: 组件名称
   - url: 原始 URL
   - description: 简要描述（1-2 句话）
   - framework: 框架（React/Vue/CSS/未知）
   - theme: 视觉风格标签（minimal/playful/corporate/dark/light 等）
   - tags: [来源站名, 组件类型, 其他标签]

返回格式（JSON）：
{
  "site": "{site_name}",
  "results": [
    {
      "name": "组件名称",
      "url": "原始 URL",
      "screenshot": "截图文件路径",
      "description": "简要描述",
      "framework": "React",
      "theme": "minimal",
      "tags": ["来源站", "类型"]
    }
  ]
}

注意事项：
- 截图保存到 {output_dir}/{site_slug}/ 目录
- 如果网站需要关闭 cookie 弹窗，先处理弹窗再截图
- 参考该网站的适配器文件了解特殊处理要求
- 完成后关闭 agent-browser 会话：agent-browser close
```

**策略 B: direct-url（组件库文档）**

```
你是 Design Explorer 的搜索子 agent。任务：在 {site_name} 上查看 "{query}" 组件。

步骤：
1. 直接打开组件文档页：
   agent-browser batch "open {direct_url_template.replace('{name}', query)}" "wait 3000" "screenshot --screenshot-dir {output_dir}/{site_slug}"

2. 如果页面 404 或无内容，尝试搜索页或 Google site: 搜索

3. 提取组件信息并返回同样的 JSON 格式。
4. 完成后：agent-browser close
```

**策略 C: site-search（站内搜索）**

```
你是 Design Explorer 的搜索子 agent。任务：在 {site_name} 上搜索 "{query}"。

步骤：
1. 打开网站并获取搜索框：
   agent-browser batch "open {site_url}" "wait 2000" "snapshot -i"

2. 根据适配器描述的搜索入口，找到搜索框并输入查询词：
   （参考适配器文件中的「搜索策略」部分了解具体搜索方式）

3. 等待结果加载，截图结果页

4. 从结果中选取前 3-5 个最相关的，逐个截图

5. 返回同样的 JSON 格式
6. 完成后：agent-browser close
```

#### 1.4 汇总结果并生成 HTML

所有子 agent 返回后，主 agent：

1. 收集所有子 agent 返回的 JSON 结果
2. 读取 `templates/report.html` 作为模板基础
3. 生成最终 HTML 文件，结构：
   - 顶部信息栏：查询词、category、搜索时间、结果总数、搜索了哪些网站
   - 卡片网格：每张卡片包含截图、组件名、来源站标签、framework badge、theme tag、描述、链接
   - 按来源站分组展示
   - 每张卡片带编号，方便用户引用
4. 输出文件路径：`{cwd}/docs/{category}/{keyword}.html`
5. 用 `agent-browser --allow-file-access open file://{absolute_path}` 打开生成的 HTML 让用户预览
6. 告诉用户："已生成 {N} 个结果的对比页面。请浏览后告诉我你想深入分析哪些（输入编号或名称），进入 Phase 2。"

#### 1.5 错误处理

- 某网站搜索超时或失败：在报告中标记为"未找到结果"，不阻塞其他
- 某网站无匹配结果：在报告中显示"无匹配结果"
- 所有网站都失败：告知用户并建议调整关键词

### Step 2: Phase 2 — 详细分析

用户选中若干组件后触发（如"1、3、7 详细看看"或"所有 React 的详细分析"）。

#### 2.1 结构化数据获取（API/CLI 优先）

对每个选中的组件，**并行启动子 agent**：

```bash
# npm 包信息（如果是 npm 组件）
npm info <package-name> --json

# GitHub 信息
gh api repos/<owner>/<repo> --jq '{stars: .stargazers_count, license: .license.spdx_id, updated: .updated_at, issues: .open_issues_count}'
```

设计灵感类（Dribbble、meiye、bestdesignsonx）无 npm/GitHub 数据，相关字段标记 N/A。

#### 2.2 视觉补充（agent-browser）

对选中的组件：
- 打开组件的 live demo 页面
- 截取不同状态的截图
- 如果有暗色模式，截取暗色模式截图

#### 2.3 提取的详细字段

| Field | Description |
|-------|-------------|
| `bundle_size` | 包大小（bundlephobia 或 npm） |
| `dependencies` | 依赖列表和数量 |
| `license` | 开源协议 |
| `weekly_downloads` | npm 周下载量 |
| `github_stars` | GitHub star 数 |
| `last_updated` | 最近更新时间 |
| `browser_support` | 浏览器兼容性 |
| `accessibility` | 无障碍支持 |
| `theming` | 主题定制能力 |
| `highlights` | 核心亮点 |
| `caveats` | 已知局限 |

**信息来源优先级**：组件官网 > GitHub README > npm > bundlephobia

#### 2.4 生成详细报告

1. 读取 `templates/detail.html` 模板
2. 生成对比表格 + 详细卡片 + AI 推荐
3. 输出到 `{cwd}/docs/{category}/{keyword}-detail.html`
4. 打开让用户预览

### Step 3: 添加自定义网站

当用户说 "添加 https://xxx.com" 时：

1. 启动一个子 agent 探索网站：
   ```
   agent-browser batch "open {url}" "wait 3000" "snapshot -i --urls"
   ```

2. AI 分析网站结构：
   - 识别搜索入口（搜索框、导航栏、分类页）
   - 判断 category（component-library / design-inspiration）
   - 判断最佳 search-strategy（google-site / site-search / direct-url）

3. 用测试关键词（如 "button"）验证搜索有效

4. 基于 `sites/_template.md` 格式生成适配器文件，保存到 `sites/{site-name}.md`

5. 告知用户适配器已创建，下次搜索将包含此网站

**SOP 质量规则**：
- 不硬编码 `@eN` ref（每次变化），用语义化定位策略
- 包含备用搜索方案
- 描述元素用角色、文本内容或 CSS selector

## 关键原则

- **截图是核心产出** — 设计参考的价值在于视觉，确保每个结果都有高质量截图
- **Google `site:` 优先** — 绕过不同网站的 UI 差异，搜索质量更稳定
- **API 优先于爬虫** — Phase 2 的结构化数据用 CLI/API 获取，agent-browser 只做视觉相关的事
- **适配器是知识积累** — 每次搜索都可能发现网站的新 quirk，鼓励更新适配器文件
- **不要过度截图** — 每个网站 3-5 个最相关的结果即可，质量优于数量
