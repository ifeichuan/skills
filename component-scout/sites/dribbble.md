---
name: Dribbble
url: https://dribbble.com
tier: 1
type: design
search-strategy: google-site
---

# Dribbble 适配器

## 搜索策略

**主策略：google-site**
- 搜索模板：`site:dribbble.com {query} UI component design`
- 图片搜索：`site:dribbble.com {query} UI` + `&tbm=isch`（推荐，Dribbble 本身就是视觉内容）

**备用：站内搜索**
- URL：`https://dribbble.com/search/{query}`
- 可按 shots/collections 筛选

## 结果页特征

- Google 结果直接链接到 shot 详情页
- 详情页结构：顶部是主图（高分辨率设计稿），下方是作者信息和相关 shots
- 主图是最有价值的截图目标

## 截图技巧

- 等待时间：3 秒（图片加载）
- 弹窗处理：可能出现 "Sign up" 弹窗，用 `agent-browser press Escape` 关闭
- 视口建议：1440x900，确保主图完整显示
- 如果进入详情页，截图主图区域即可，不需要截全页

## 已知问题

- 未登录时浏览数量有限制，但 Google `site:` 搜索不受此影响
- 站内搜索质量一般，Google 搜索更准确
- 部分 shot 是多图（长图），主图只是第一张
