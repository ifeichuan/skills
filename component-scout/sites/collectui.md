---
name: Collect UI
url: https://collectui.com
tier: 1
type: design
search-strategy: direct-url
---

# Collect UI 适配器

## 搜索策略

**主策略：direct-url**（Collect UI 按 UI 类别整理，有明确的分类 URL）
- URL 模板：`https://collectui.com/challenges/{query}`
- 常用分类映射：
  - date picker → `date-picker`
  - login / sign up → `sign-up`
  - landing page → `landing-page`
  - dashboard → `analytics-chart`
  - settings → `settings`
  - search → `search`
  - navigation → `navigation`

**备用：google-site**
- 搜索模板：`site:collectui.com {query} UI daily`

## 结果页特征

- 分类页是 Daily UI 挑战作品的瀑布流
- 每个作品是一张设计截图（来自 Dribbble）
- 点击可以跳转到原始 Dribbble shot

## 截图技巧

- 等待时间：3 秒（图片懒加载）
- 视口建议：1440x900
- 需要向下滚动 2-3 次获取更多结果（懒加载）
- 截图分类页即可获得一组同类型的设计参考

## 已知问题

- 分类名称需要做 query → slug 的转换（空格变连字符、小写）
- 如果分类不存在会 404，回退到 Google `site:` 搜索
- 内容来源是 Daily UI 挑战，风格偏概念设计
