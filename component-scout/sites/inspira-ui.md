---
name: Inspira UI
url: https://inspira-ui.com
tier: 1
type: component-library
search-strategy: site-search
framework: Vue
---

# Inspira UI 适配器

## 搜索策略

**主策略：site-search**（有键盘快捷键搜索，按类别组织良好）
- 搜索方式：打开首页后按 `K` 键唤起搜索面板，输入查询词
- 也可按类别浏览：
  - Backgrounds、Buttons、Cards、Cursors、Device Mocks
  - Input & Forms、Miscellaneous、Special Effects
  - Testimonials、Text Animations、Visualization
- URL 格式：`https://inspira-ui.com/docs/components/{category}`

**备用：google-site**
- `site:inspira-ui.com {query} component`

## 结果页特征

- 组件文档页包含 live 交互预览和代码示例
- 支持框架切换：Nuxt UI 版本 / 标准 Tailwind CSS 版本
- 每个组件有 API 文档和可调参数
- 100+ 组件，偏重动画和视觉特效

## 截图技巧

- 等待时间：3 秒（动画组件需要渲染时间）
- 视口建议：1280x800
- 截取组件预览区域，特效类组件可能需要等动画播放
- 部分组件有交互控件可以切换变体

## 已知问题

- 这是 Vue/Nuxt 组件库，不是 React
- 搜索用键盘快捷键 K 唤起，用 agent-browser 需要：`agent-browser press k` 然后 `agent-browser keyboard type "{query}"`
- 偏重特效和动画组件（背景、文字动画、光标效果等）
