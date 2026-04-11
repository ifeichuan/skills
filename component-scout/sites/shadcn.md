---
name: shadcn/ui
url: https://ui.shadcn.com
tier: 2
type: component-library
search-strategy: direct-url
framework: React
---

# shadcn/ui 适配器

## 搜索策略

**主策略：direct-url**
- URL 模板：`https://ui.shadcn.com/docs/components/{name}`
- 组件名格式：小写连字符，如 `date-picker`、`data-table`、`dropdown-menu`
- 完整组件列表：`https://ui.shadcn.com/docs/components`

**备用**
- 搜索不存在的组件时，回退到 `https://ui.shadcn.com/docs` 页面搜索

## 结果页特征

- 组件文档页包含：组件描述、live preview、代码示例、API 参考
- Preview 区域是最有价值的截图目标（白色背景、居中展示）
- 页面下方有多个变体示例（sizes、variants）

## 截图技巧

- 等待时间：2 秒
- 视口建议：1280x800
- 截图目标：页面顶部的 Preview 区域（组件 demo）
- 可以截取多个变体示例

## 已知问题

- shadcn/ui 是 copy-paste 模式，不是传统 npm 包，npm info 不适用
- GitHub 仓库：`shadcn-ui/ui`
- 基于 Radix UI primitives + Tailwind CSS
