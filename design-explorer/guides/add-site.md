---
title: 添加自定义网站到 Design Explorer
---

# 添加自定义网站

## Quick Start

直接告诉 AI：

```
添加 https://example.com 到 design-explorer
```

AI 会自动探索网站结构、找到搜索功能、运行测试搜索，然后生成适配器文件。

## 自动流程详解

当你请求添加新网站时，AI 会：

1. **打开网站** — 用 agent-browser 访问并分析页面结构
2. **寻找搜索功能** — 识别搜索框、URL 参数、分类导航等搜索入口
3. **判断网站类型** — `component-library`（组件库）或 `design-inspiration`（设计灵感）
4. **选择搜索策略** — `google-site`（Google site: 搜索）、`site-search`（站内搜索）或 `direct-url`（直接 URL）
5. **测试搜索** — 用通用关键词（如 "button"）验证搜索有效
6. **生成适配器** — 保存到 `sites/{site-name}.md`
7. **二次验证** — 用另一个关键词再跑一遍确认可用

## 手动添加

如果你想手动创建适配器：

1. 复制 `sites/_template.md` 到 `sites/{your-site-name}.md`
2. 填写 frontmatter 字段
3. 补充搜索策略、结果页特征、截图技巧、已知问题

## SOP 质量规则

- **不要硬编码 `@eN` ref** — 这些引用每次 agent-browser 会话都会变化。用语义化描述代替，如"找到 placeholder 为 Search 的输入框"
- **包含备用方案** — 如"如果搜索框不存在，尝试 URL 参数方式"
- **描述元素用语义** — 角色（button、input）、文本内容、CSS selector pattern
- **记录已知问题** — 弹窗、登录限制、频率限制等

## Frontmatter 字段参考

| 字段 | 必填 | 说明 |
|------|------|------|
| `name` | 是 | 网站显示名称 |
| `url` | 是 | 网站 URL |
| `category` | 是 | `component-library` 或 `design-inspiration` |
| `search-strategy` | 是 | `google-site`、`site-search` 或 `direct-url` |
| `framework` | 否 | 组件库的框架（React、Vue 等） |
| `language` | 否 | 非英文网站的语言代码（如 `zh-CN`） |
| `added_by` | 否 | `user`（AI 自动填写） |
| `added_at` | 否 | 添加日期（AI 自动填写） |

## 验证适配器

添加后，运行一次搜索测试：

```
design-explorer button
```

检查新网站是否出现在搜索结果中。
