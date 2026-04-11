---
name: 21st.dev
url: https://21st.dev
tier: 1
type: component-library
search-strategy: site-search
framework: React
---

# 21st.dev 适配器

## 搜索策略

**主策略：site-search**（站内搜索质量好，带 live preview）
- 搜索 URL：`https://21st.dev/community/agents/search?q={query}`
- 也可浏览组件：`https://21st.dev/community/components/`

**备用：google-site**
- `site:21st.dev {query} component`

## 结果页特征

- 搜索结果为社区贡献的 React 组件卡片
- 每个结果包含：live 预览图/视频（PNG/WebP/MP4）、组件名、作者
- 点击进入详情页有完整的代码和交互式 HTML 预览
- URL 格式：`/community/components/{username}/{component-name}/{demo-name}`

## 截图技巧

- 等待时间：3 秒（预览图/视频加载）
- 视口建议：1440x900
- 搜索结果页的卡片预览图已经很有价值，可直接截图结果页
- 详情页有内嵌的 interactive HTML bundle，截取预览区域

## 已知问题

- 平台同时包含 AI agent 和 UI 组件，搜索时注意区分
- 部分组件是付费的（monetized）
- 基于 Next.js + Tailwind CSS
