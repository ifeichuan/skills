---
name: Component Gallery
url: https://component.gallery
tier: 1
type: component-library
search-strategy: direct-url
---

# Component Gallery 适配器

## 搜索策略

**主策略：direct-url**（按组件类型有清晰的 URL 结构）
- URL 模板：`https://component.gallery/components/{name}/`
- 组件名格式：小写连字符，如 `date-picker`、`accordion`、`carousel`
- 完整组件列表：`https://component.gallery/components/`
- 按设计系统浏览：`https://component.gallery/design-systems/`

**备用：站内搜索**
- `Cmd+K` / `Ctrl+K` 唤起搜索
- 用 agent-browser：`agent-browser press Meta+k` 然后输入查询词

**备用：google-site**
- `site:component.gallery {query}`

## 结果页特征

- 跨设计系统的组件聚合器：60 种组件类型 × 95 个设计系统 = 2,676 个代码示例
- 组件详情页包含：来自多个设计系统的实现示例、描述、标记方式、交互模式、样式指南
- 每个示例标注技术栈（React、Vue、Web Components、Tailwind、Sass 等）
- 可按技术栈和功能特性筛选
- 支持 Dark/Light 模式切换

## 截图技巧

- 等待时间：2 秒
- 视口建议：1280x800
- 组件列表页本身就是很好的概览截图
- 组件详情页很长（包含多个设计系统的示例），截取前几个最有代表性的
- 可以用 `--full` 截取完整页面

## 已知问题

- 这是一个聚合器，不提供自己的组件代码，而是链接到各设计系统的原始实现
- 有 "Copy URLs" 功能可以批量复制链接
- 基于 Astro + Airtable + Cloudflare Pages
- 内容质量很高，适合做组件模式的横向对比
