---
name: Radix UI
url: https://www.radix-ui.com
tier: 2
type: component-library
search-strategy: direct-url
framework: React
---

# Radix UI 适配器

## 搜索策略

**主策略：direct-url**
- Primitives：`https://www.radix-ui.com/primitives/docs/components/{name}`
- Themes：`https://www.radix-ui.com/themes/docs/components/{name}`
- 组件名格式：小写连字符，如 `date-picker`、`dropdown-menu`、`dialog`

**备用**
- Google：`site:radix-ui.com {query} component`

## 结果页特征

- Primitives 文档：无样式组件，页面包含 API 描述和使用示例
- Themes 文档：带样式组件，有 live demo 和 Playground
- Themes 的 demo 区域视觉效果更好，优先截图 Themes

## 截图技巧

- 等待时间：2 秒
- 视口建议：1280x800
- Themes 组件有在线 Playground，可以切换变体/尺寸/颜色
- 截取 Playground 区域最有价值

## 已知问题

- Primitives 和 Themes 是两套产品：Primitives 无样式（headless），Themes 有样式
- npm 包名格式：`@radix-ui/react-{name}`（Primitives）、`@radix-ui/themes`（Themes）
- GitHub 仓库：`radix-ui/primitives`、`radix-ui/themes`
