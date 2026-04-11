---
name: 美叶 (Meiye)
url: https://www.meiye.art
tier: 1
type: design
search-strategy: site-search
language: zh-CN
---

# 美叶 (Meiye) 适配器

## 搜索策略

**主策略：site-search**（中文设计灵感平台，站内搜索支持中文关键词）
- 搜索方式：进入作品页 `https://www.meiye.art/works` 后使用搜索框
- 也可按分类浏览：
  - 品牌 (Branding)、界面 (UI/Interface)、包装 (Packaging)
  - 字体 (Typography)、指南 (Guidelines)
- 界面类子分类适合搜索 UI 组件灵感

**备用：google-site**
- `site:meiye.art {query}` — 注意用中文关键词效果更好
- 如 `site:meiye.art 日期选择器 界面设计`

**关键词翻译提示**：
搜索时应将英文组件名翻译为中文，例如：
- date picker → 日期选择器
- dashboard → 仪表盘 / 数据面板
- login → 登录页
- navigation → 导航
- card → 卡片

## 结果页特征

- 作品页为设计师作品集展示，以高质量截图为主
- 每个作品包含：设计截图、设计师名、项目信息
- URL 格式：`/works/{category-id}/{subcategory-id}/{project-id}`
- 支持按 灵感集、截屏、榜样、作品 等维度浏览

## 截图技巧

- 等待时间：3 秒（图片加载）
- 视口建议：1440x900
- 作品详情页有高清设计图，直接截图
- 截屏分区 (`/screenshots`) 直接就是 UI 截图集合，非常适合组件灵感

## 已知问题

- 中文网站，搜索关键词最好用中文
- 内容偏向品牌设计和完整界面设计，不是代码组件
- 有社区功能（叶友群）和工具（Linknote）
- 部分内容可能需要登录查看高清大图
